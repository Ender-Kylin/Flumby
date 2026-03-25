import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../platform/player/player_bridge.dart';
import '../../../platform/player/player_bridge_factory.dart';
import '../../../platform/window/window_control_service.dart';
import '../../server/application/media_server_access.dart';
import '../../server/data/server_local_repository.dart';
import '../../server/domain/media_server_adapter.dart';
import '../../settings/application/settings_controller.dart';
import '../data/playback_state_repository.dart';
import '../domain/playback_models.dart';

final playerControllerProvider = NotifierProvider.autoDispose
    .family<PlayerController, PlayerStateSnapshot, PlayerLaunchContext>(
      PlayerController.new,
    );

class PlayerController extends Notifier<PlayerStateSnapshot> {
  PlayerController(this._launchContext);

  final PlayerLaunchContext _launchContext;
  late final PlayerMediaSource _source;
  Timer? _positionTimer;
  late final PlayerBridge _bridge;
  late final String _playSessionId;
  late final PlaybackStateRepository _playbackStateRepository;
  late final ServerLocalRepository _serverLocalRepository;
  late final MediaServerAdapter _adapter;
  late final SettingsState _initialSettings;
  late final WindowControlService _windowControlService;
  late final PlayerPresentationMode _presentationMode;
  late final bool _minimizeMainWindowDuringPlayback;
  late PlayerStateSnapshot _latestSnapshot;
  StreamSubscription<PlayerBridgeEvent>? _bridgeEventsSubscription;
  bool _mainWindowMinimized = false;
  int _lastPersistedPosition = 0;
  int _lastReportedPosition = -1;

  @override
  PlayerStateSnapshot build() {
    _source = _launchContext.source;
    _playSessionId = _source.playSessionId?.trim().isNotEmpty == true
        ? _source.playSessionId!
        : 'play-${DateTime.now().microsecondsSinceEpoch}-${_source.itemId}';
    _playbackStateRepository = ref.read(playbackStateRepositoryProvider);
    _serverLocalRepository = ref.read(serverLocalRepositoryProvider);
    _adapter = ref.read(
      mediaServerAdapterProvider(_launchContext.session.server.type),
    );
    _initialSettings = ref.read(settingsControllerProvider);
    _presentationMode =
        Platform.isLinux && _initialSettings.openInSeparateWindow
        ? PlayerPresentationMode.separateWindow
        : PlayerPresentationMode.embedded;
    _minimizeMainWindowDuringPlayback =
        _presentationMode == PlayerPresentationMode.separateWindow &&
        _initialSettings.minimizeMainWindowDuringExternalPlayback;
    _windowControlService = ref.read(windowControlServiceProvider);
    _bridge = ref.read(playerBridgeFactoryProvider)();
    _bridgeEventsSubscription = _bridge.events.listen((event) {
      unawaited(_handleBridgeEvent(event));
    });
    ref.onDispose(() {
      unawaited(_disposeSession());
    });
    unawaited(_initialize());
    _latestSnapshot = _bridge.currentState.copyWith(
      source: _source,
      presentationMode: _presentationMode,
    );
    return _latestSnapshot;
  }

  Future<void> _initialize() async {
    await _bridge.initialize();
    _setSnapshot(_mergeBridgeState(_bridge.currentState));

    if (_bridge.currentState.isAvailable) {
      await _applySavedSettings();
      await _launchPlayback();
    } else {
      final launchError =
          _bridge.currentState.launchError ?? _bridge.currentState.errorMessage;
      _setSnapshot(
        _mergeBridgeState(_bridge.currentState, launchError: launchError),
      );
    }
  }

  Future<void> togglePlayback() async {
    if (_currentSnapshot.isSeparateWindow) {
      if (_currentSnapshot.externalWindowActive) {
        return;
      }

      await _launchPlayback();
      return;
    }

    await _bridge.playPause();
    _setSnapshot(_mergeBridgeState(_bridge.currentState));
    _syncProgressTicker();
    await _persistProgress(force: true, snapshot: _currentSnapshot);
    await _reportProgress(
      isPaused: !_currentSnapshot.isPlaying,
      snapshot: _currentSnapshot,
    );
  }

  Future<void> seekTo(int seconds) async {
    await _bridge.seek(Duration(seconds: seconds));
    _setSnapshot(_mergeBridgeState(_bridge.currentState));
    await _persistProgress(force: true, snapshot: _currentSnapshot);
    await _reportProgress(
      isPaused: !_currentSnapshot.isPlaying,
      snapshot: _currentSnapshot,
    );
  }

  Future<void> selectSubtitle(String? trackId) async {
    await _bridge.setSubtitleTrack(trackId);
    _setSnapshot(_mergeBridgeState(_bridge.currentState));
  }

  Future<void> selectAudio(String? trackId) async {
    await _bridge.setAudioTrack(trackId);
    _setSnapshot(_mergeBridgeState(_bridge.currentState));
  }

  Future<void> setOption(String key, String value) async {
    await _bridge.setMpvOption(key, value);
    _setSnapshot(_mergeBridgeState(_bridge.currentState));
  }

  Future<void> _applySavedSettings() async {
    await _bridge.setMpvOption('hwdec', _initialSettings.hardwareDecoding);
    await _bridge.setMpvOption('slang', _initialSettings.subtitleLanguage);
    await _bridge.setMpvOption('alang', _initialSettings.audioLanguage);
  }

  Future<void> _launchPlayback() async {
    await _bridge.open(_source);
    final launchError =
        _bridge.currentState.status == PlayerStatus.error ||
            !_bridge.currentState.isAvailable
        ? (_bridge.currentState.launchError ??
              _bridge.currentState.errorMessage)
        : null;
    _setSnapshot(
      _mergeBridgeState(
        _bridge.currentState,
        externalWindowActive: false,
        launchError: launchError,
        clearLaunchError: launchError == null,
        lifecycleEvent: PlayerLifecycleEvent.none,
      ),
    );
    if (launchError != null) {
      await _restoreMainWindow();
    }
  }

  void consumeLifecycleEvent() {
    if (_currentSnapshot.lifecycleEvent == PlayerLifecycleEvent.none) {
      return;
    }

    _setSnapshot(
      _currentSnapshot.copyWith(lifecycleEvent: PlayerLifecycleEvent.none),
    );
  }

  void _syncProgressTicker() {
    _positionTimer?.cancel();
    if (!_currentSnapshot.isPlaying) {
      return;
    }

    _positionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final durationSeconds = _source.durationSeconds;
      final nextPosition = durationSeconds > 0
          ? (_currentSnapshot.positionSeconds + 1).clamp(0, durationSeconds)
          : _currentSnapshot.positionSeconds + 1;
      _setSnapshot(_currentSnapshot.copyWith(positionSeconds: nextPosition));
      unawaited(_persistProgress(snapshot: _currentSnapshot));
      if (nextPosition % 10 == 0) {
        unawaited(_reportProgress(snapshot: _currentSnapshot));
      }
    });
  }

  Future<void> _handleBridgeEvent(PlayerBridgeEvent event) async {
    switch (event.type) {
      case PlayerBridgeEventType.initialized:
        _setSnapshot(
          _mergeBridgeState(_bridge.currentState, clearLaunchError: true),
        );
        break;
      case PlayerBridgeEventType.fileLoaded:
        _setSnapshot(
          _mergeBridgeState(
            _bridge.currentState,
            externalWindowActive: _currentSnapshot.isSeparateWindow,
            clearLaunchError: true,
            lifecycleEvent: PlayerLifecycleEvent.none,
          ),
        );
        if (_minimizeMainWindowDuringPlayback) {
          await _minimizeMainWindow();
        }
        await _persistProgress(force: true, snapshot: _currentSnapshot);
        await _reportProgress(
          isPaused: !_currentSnapshot.isPlaying,
          snapshot: _currentSnapshot,
        );
        _syncProgressTicker();
        break;
      case PlayerBridgeEventType.playbackEnded:
        _setSnapshot(
          _mergeBridgeState(
            _bridge.currentState,
            externalWindowActive: false,
            clearLaunchError: true,
            lifecycleEvent: PlayerLifecycleEvent.restoreAndPop,
          ),
        );
        _positionTimer?.cancel();
        await _persistProgress(force: true, snapshot: _currentSnapshot);
        await _reportProgress(isPaused: true, snapshot: _currentSnapshot);
        await _restoreMainWindow();
        break;
      case PlayerBridgeEventType.shutdown:
        _setSnapshot(
          _mergeBridgeState(
            _bridge.currentState,
            externalWindowActive: false,
            errorMessage: event.message,
            clearLaunchError: true,
            lifecycleEvent: PlayerLifecycleEvent.restoreAndPop,
          ),
        );
        _positionTimer?.cancel();
        await _persistProgress(force: true, snapshot: _currentSnapshot);
        await _reportProgress(isPaused: true, snapshot: _currentSnapshot);
        await _restoreMainWindow();
        break;
      case PlayerBridgeEventType.error:
        final message =
            event.message ??
            _bridge.currentState.launchError ??
            _bridge.currentState.errorMessage;
        _setSnapshot(
          _mergeBridgeState(
            _bridge.currentState,
            externalWindowActive: false,
            errorMessage: message,
            launchError: message,
            lifecycleEvent: PlayerLifecycleEvent.none,
          ),
        );
        _positionTimer?.cancel();
        await _persistProgress(force: true, snapshot: _currentSnapshot);
        await _reportProgress(isPaused: true, snapshot: _currentSnapshot);
        await _restoreMainWindow();
        break;
      case PlayerBridgeEventType.log:
        if (_currentSnapshot.launchError != null) {
          _setSnapshot(
            _currentSnapshot.copyWith(
              errorMessage: event.message ?? _currentSnapshot.errorMessage,
            ),
          );
        }
        break;
    }
  }

  Future<void> _persistProgress({
    bool force = false,
    PlayerStateSnapshot? snapshot,
  }) async {
    final currentSnapshot = snapshot ?? _currentSnapshot;
    if (currentSnapshot.source == null) {
      return;
    }
    if (!force &&
        (currentSnapshot.positionSeconds - _lastPersistedPosition).abs() < 5 &&
        currentSnapshot.positionSeconds != _source.durationSeconds) {
      return;
    }

    _lastPersistedPosition = currentSnapshot.positionSeconds;
    await _playbackStateRepository.saveState(
      serverId: _source.serverId,
      itemId: _source.itemId,
      positionSeconds: currentSnapshot.positionSeconds,
      durationSeconds: _source.durationSeconds,
    );
  }

  Future<void> _reportProgress({
    bool isPaused = false,
    PlayerStateSnapshot? snapshot,
  }) async {
    final currentSnapshot = snapshot ?? _currentSnapshot;
    if (currentSnapshot.source == null || !_bridge.currentState.isAvailable) {
      return;
    }
    if (_lastReportedPosition == currentSnapshot.positionSeconds && !isPaused) {
      return;
    }

    _lastReportedPosition = currentSnapshot.positionSeconds;
    try {
      await _adapter.reportPlayback(
        session: _launchContext.session,
        report: PlaybackReport(
          itemId: _source.itemId,
          playSessionId: _playSessionId,
          mediaSourceId: _source.mediaSourceId,
          positionSeconds: currentSnapshot.positionSeconds,
          isPaused: isPaused,
        ),
      );
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        await _serverLocalRepository.clearSessionCredentials(_source.serverId);
      }
    }
  }

  Future<void> _disposeSession() async {
    _positionTimer?.cancel();
    await _bridgeEventsSubscription?.cancel();
    if (_latestSnapshot.externalWindowActive) {
      await _bridge.close();
    }
    await _restoreMainWindow();
    await _persistProgress(force: true, snapshot: _latestSnapshot);
    await _reportProgress(isPaused: true, snapshot: _latestSnapshot);
    await _bridge.dispose();
  }

  Future<void> _minimizeMainWindow() async {
    if (_mainWindowMinimized) {
      return;
    }

    try {
      await _windowControlService.minimizeMainWindow();
      _mainWindowMinimized = true;
    } catch (_) {
      // Restoration should still work even if minimization fails.
    }
  }

  Future<void> _restoreMainWindow() async {
    if (!_mainWindowMinimized &&
        _presentationMode != PlayerPresentationMode.separateWindow) {
      return;
    }

    try {
      await _windowControlService.restoreMainWindow();
    } catch (_) {
      // If restoration fails we still want provider disposal to continue.
    } finally {
      _mainWindowMinimized = false;
    }
  }

  PlayerStateSnapshot _mergeBridgeState(
    PlayerStateSnapshot snapshot, {
    bool? externalWindowActive,
    String? errorMessage,
    String? launchError,
    bool clearLaunchError = false,
    PlayerLifecycleEvent? lifecycleEvent,
  }) {
    final currentLaunchError = clearLaunchError
        ? null
        : (launchError ?? stateOrNull?.launchError);
    final currentExternalWindowActive =
        externalWindowActive ?? stateOrNull?.externalWindowActive ?? false;
    final currentLifecycleEvent =
        lifecycleEvent ??
        stateOrNull?.lifecycleEvent ??
        PlayerLifecycleEvent.none;

    return snapshot.copyWith(
      source: snapshot.source ?? _source,
      presentationMode: _presentationMode,
      externalWindowActive: currentExternalWindowActive,
      errorMessage: errorMessage ?? snapshot.errorMessage,
      launchError: currentLaunchError,
      lifecycleEvent: currentLifecycleEvent,
    );
  }

  PlayerStateSnapshot get _currentSnapshot => stateOrNull ?? _latestSnapshot;

  void _setSnapshot(PlayerStateSnapshot snapshot) {
    _latestSnapshot = snapshot;
    state = snapshot;
  }
}
