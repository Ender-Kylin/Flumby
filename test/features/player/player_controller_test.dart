import 'dart:async';

import 'package:drift/native.dart';
import 'package:flumby/core/database/app_database.dart';
import 'package:flumby/core/storage/app_preferences_repository.dart';
import 'package:flumby/core/storage/secure_storage_service.dart';
import 'package:flumby/features/detail/domain/media_detail.dart';
import 'package:flumby/features/home/domain/home_models.dart';
import 'package:flumby/features/library/domain/library_models.dart';
import 'package:flumby/features/player/application/player_controller.dart';
import 'package:flumby/features/player/data/playback_state_repository.dart';
import 'package:flumby/features/player/domain/playback_models.dart';
import 'package:flumby/features/server/application/media_server_access.dart';
import 'package:flumby/features/server/data/server_local_repository.dart';
import 'package:flumby/features/server/domain/media_server_adapter.dart';
import 'package:flumby/features/server/domain/server_models.dart';
import 'package:flumby/platform/player/player_bridge.dart';
import 'package:flumby/platform/player/player_bridge_factory.dart';
import 'package:flumby/platform/window/window_control_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'controller minimizes Flumby after file load and restores with pop lifecycle on shutdown',
    () async {
      final harness = _ControllerHarness.create();
      addTearDown(harness.dispose);

      final subscription = harness.container.listen(
        playerControllerProvider(_testLaunchContext()),
        (previous, next) {},
      );
      addTearDown(subscription.close);

      await _pump();
      expect(harness.windowControl.minimizeCalls, 0);

      harness.bridge.emit(
        const PlayerBridgeEvent(type: PlayerBridgeEventType.fileLoaded),
      );
      await _pump();

      final afterFileLoaded = harness.container.read(
        playerControllerProvider(_testLaunchContext()),
      );
      expect(afterFileLoaded.externalWindowActive, isTrue);
      expect(harness.windowControl.minimizeCalls, 1);
      expect(afterFileLoaded.lifecycleEvent, PlayerLifecycleEvent.none);
      expect(harness.adapter.reports, isNotEmpty);

      harness.bridge.emit(
        const PlayerBridgeEvent(
          type: PlayerBridgeEventType.shutdown,
          message: 'mpv window closed.',
        ),
      );
      await _pump();

      final afterShutdown = harness.container.read(
        playerControllerProvider(_testLaunchContext()),
      );
      expect(afterShutdown.externalWindowActive, isFalse);
      expect(afterShutdown.lifecycleEvent, PlayerLifecycleEvent.restoreAndPop);
      expect(harness.windowControl.restoreCalls, 1);
    },
  );

  test(
    'controller restores Flumby on external playback errors without pop lifecycle event',
    () async {
      final harness = _ControllerHarness.create();
      addTearDown(harness.dispose);

      final subscription = harness.container.listen(
        playerControllerProvider(_testLaunchContext()),
        (previous, next) {},
      );
      addTearDown(subscription.close);

      await _pump();

      harness.bridge.emit(
        const PlayerBridgeEvent(type: PlayerBridgeEventType.fileLoaded),
      );
      await _pump();

      harness.bridge.emit(
        const PlayerBridgeEvent(
          type: PlayerBridgeEventType.error,
          message: 'stream failed',
        ),
      );
      await _pump();

      final afterError = harness.container.read(
        playerControllerProvider(_testLaunchContext()),
      );
      expect(afterError.externalWindowActive, isFalse);
      expect(afterError.launchError, 'stream failed');
      expect(afterError.lifecycleEvent, PlayerLifecycleEvent.none);
      expect(harness.windowControl.restoreCalls, 1);
    },
  );

  test('controller closes active external playback when disposed', () async {
    final harness = _ControllerHarness.create();

    final subscription = harness.container.listen(
      playerControllerProvider(_testLaunchContext()),
      (previous, next) {},
    );

    await _pump();
    harness.bridge.emit(
      const PlayerBridgeEvent(type: PlayerBridgeEventType.fileLoaded),
    );
    await _pump();

    subscription.close();
    harness.container.dispose();
    await _pump();

    expect(harness.bridge.closeCalls, 1);
    expect(harness.windowControl.restoreCalls, 1);
    await harness.database.close();
  });
}

Future<void> _pump() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(const Duration(milliseconds: 10));
}

PlayerLaunchContext _testLaunchContext() {
  final server = MediaServerProfile(
    id: 'server-1',
    defaultName: 'Test Emby',
    type: MediaServerType.emby,
    updatedAt: DateTime.utc(2026, 3, 25),
  );
  final line = MediaServerLine(
    id: buildMediaServerLineId(
      serverId: 'server-1',
      baseUrl: 'https://emby.example.com',
    ),
    serverId: 'server-1',
    customName: '主线路',
    baseUrl: 'https://emby.example.com',
    type: MediaServerType.emby,
    updatedAt: DateTime.utc(2026, 3, 25),
  );
  final session = MediaServerSession(
    server: server,
    line: line,
    accessToken: 'token',
    userId: 'user-1',
  );
  final source = PlayerMediaSource(
    serverId: line.id,
    itemId: 'episode-1',
    title: 'Episode 1',
    streamUrl: 'https://emby.example.com/Videos/episode-1/stream',
    durationSeconds: 1200,
  );

  return PlayerLaunchContext(session: session, source: source);
}

class _ControllerHarness {
  _ControllerHarness({
    required this.database,
    required this.container,
    required this.bridge,
    required this.windowControl,
    required this.adapter,
  });

  final AppDatabase database;
  final ProviderContainer container;
  final _FakePlayerBridge bridge;
  final _RecordingWindowControlService windowControl;
  final _FakeMediaServerAdapter adapter;

  static _ControllerHarness create() {
    final database = AppDatabase(NativeDatabase.memory());
    final secureStorage = _FakeSecureStorageService();
    final preferences = AppPreferencesRepository(database, secureStorage);
    final playbackRepository = PlaybackStateRepository(database, secureStorage);
    final serverRepository = ServerLocalRepository(
      database,
      preferences,
      secureStorage,
    );
    final bridge = _FakePlayerBridge();
    final windowControl = _RecordingWindowControlService();
    final adapter = _FakeMediaServerAdapter();

    final container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        secureStorageProvider.overrideWithValue(secureStorage),
        appPreferencesRepositoryProvider.overrideWithValue(preferences),
        playbackStateRepositoryProvider.overrideWithValue(playbackRepository),
        serverLocalRepositoryProvider.overrideWithValue(serverRepository),
        playerBridgeFactoryProvider.overrideWithValue(() => bridge),
        windowControlServiceProvider.overrideWithValue(windowControl),
        mediaServerAdapterProvider.overrideWith((ref, type) => adapter),
      ],
    );

    return _ControllerHarness(
      database: database,
      container: container,
      bridge: bridge,
      windowControl: windowControl,
      adapter: adapter,
    );
  }

  Future<void> dispose() async {
    container.dispose();
    await Future<void>.delayed(Duration.zero);
    await database.close();
  }
}

class _FakePlayerBridge implements PlayerBridge {
  PlayerStateSnapshot _state = PlayerStateSnapshot.idle(
    backend: PlayerBackend.mpv,
  );
  final StreamController<PlayerBridgeEvent> _events =
      StreamController<PlayerBridgeEvent>.broadcast();
  int closeCalls = 0;

  @override
  PlayerStateSnapshot get currentState => _state;

  @override
  Stream<PlayerBridgeEvent> get events => _events.stream;

  @override
  Future<void> dispose() async {
    await _events.close();
  }

  @override
  Future<void> initialize() async {
    _state = _state.copyWith(
      status: PlayerStatus.ready,
      backend: PlayerBackend.mpv,
      errorMessage: null,
      launchError: null,
    );
    emit(const PlayerBridgeEvent(type: PlayerBridgeEventType.initialized));
  }

  @override
  Future<void> open(PlayerMediaSource source) async {
    _state = _state.copyWith(
      source: source,
      status: PlayerStatus.ready,
      errorMessage: null,
      launchError: null,
    );
  }

  @override
  Future<void> close() async {
    closeCalls += 1;
    _state = _state.copyWith(status: PlayerStatus.ready);
  }

  @override
  Future<void> playPause() async {
    _state = _state.copyWith(
      status: _state.status == PlayerStatus.playing
          ? PlayerStatus.paused
          : PlayerStatus.playing,
    );
  }

  @override
  Future<void> seek(Duration position) async {
    _state = _state.copyWith(positionSeconds: position.inSeconds);
  }

  @override
  Future<void> setAudioTrack(String? trackId) async {
    _state = _state.copyWith(audioTrackId: trackId);
  }

  @override
  Future<void> setMpvOption(String key, String value) async {}

  @override
  Future<void> setSubtitleTrack(String? trackId) async {
    _state = _state.copyWith(subtitleTrackId: trackId);
  }

  void emit(PlayerBridgeEvent event) {
    switch (event.type) {
      case PlayerBridgeEventType.initialized:
        _state = _state.copyWith(status: PlayerStatus.ready);
        break;
      case PlayerBridgeEventType.fileLoaded:
        _state = _state.copyWith(status: PlayerStatus.playing);
        break;
      case PlayerBridgeEventType.playbackEnded:
        _state = _state.copyWith(status: PlayerStatus.ready);
        break;
      case PlayerBridgeEventType.shutdown:
        _state = _state.copyWith(
          status: PlayerStatus.ready,
          errorMessage: event.message,
        );
        break;
      case PlayerBridgeEventType.error:
        _state = _state.copyWith(
          status: PlayerStatus.error,
          errorMessage: event.message,
          launchError: event.message,
        );
        break;
      case PlayerBridgeEventType.log:
        _state = _state.copyWith(errorMessage: event.message);
        break;
    }

    _events.add(event);
  }
}

class _FakeMediaServerAdapter implements MediaServerAdapter {
  final List<PlaybackReport> reports = <PlaybackReport>[];

  @override
  MediaServerType get serverType => MediaServerType.emby;

  @override
  Future<HomeFeed> fetchHome(MediaServerSession session) {
    throw UnimplementedError();
  }

  @override
  Future<MediaDetail> fetchItemDetail({
    required MediaServerSession session,
    required String itemId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<LibrarySummary>> fetchLibraries(MediaServerSession session) {
    throw UnimplementedError();
  }

  @override
  Future<List<MediaItemSummary>> fetchItems({
    required MediaServerSession session,
    required String libraryId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> reportPlayback({
    required MediaServerSession session,
    required PlaybackReport report,
  }) async {
    reports.add(report);
  }

  @override
  Uri resolveStreamUrl({
    required MediaServerSession session,
    required String itemId,
    String? mediaSourceId,
    String? playSessionId,
  }) {
    return Uri.parse('https://emby.example.com/Videos/$itemId/stream');
  }

  @override
  Future<List<MediaItemSummary>> searchItems({
    required MediaServerSession session,
    required String query,
    int limit = 50,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<MediaServerSession> signIn(ServerSignInRequest request) {
    throw UnimplementedError();
  }
}

class _RecordingWindowControlService implements WindowControlService {
  int minimizeCalls = 0;
  int restoreCalls = 0;
  int maximizeCalls = 0;
  int closeCalls = 0;
  int dragCalls = 0;
  bool isMaximized = false;

  @override
  Future<void> closeMainWindow() async {
    closeCalls += 1;
  }

  @override
  Future<bool> isMainWindowMaximized() async => isMaximized;

  @override
  Future<void> minimizeMainWindow() async {
    minimizeCalls += 1;
  }

  @override
  Future<void> restoreMainWindow() async {
    restoreCalls += 1;
  }

  @override
  Future<void> startWindowDrag(Offset globalPosition) async {
    dragCalls += 1;
  }

  @override
  Future<void> toggleMaximizeMainWindow() async {
    maximizeCalls += 1;
    isMaximized = !isMaximized;
  }
}

class _FakeSecureStorageService extends SecureStorageService {
  _FakeSecureStorageService() : super(const FlutterSecureStorage());

  final Map<String, String> _values = <String, String>{};

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }
}
