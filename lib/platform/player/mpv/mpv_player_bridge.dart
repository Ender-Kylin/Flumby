import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import '../../../features/player/domain/playback_models.dart';
import '../player_bridge.dart';
import 'mpv_dynamic_library.dart';

class MpvPlayerBridge implements PlayerBridge {
  MpvPlayerBridge()
    : _state = PlayerStateSnapshot.idle(backend: PlayerBackend.mpv);

  PlayerStateSnapshot _state;
  final StreamController<PlayerBridgeEvent> _eventsController =
      StreamController<PlayerBridgeEvent>.broadcast();
  _MpvBindings? _bindings;
  Pointer<Void>? _handle;
  Timer? _eventPoller;
  bool _isInitialized = false;
  bool _needsReinitialize = false;
  bool _isDrainingEvents = false;
  String? _lastLogMessage;
  String? _localeDiagnostic;

  @override
  PlayerStateSnapshot get currentState => _state;

  @override
  Stream<PlayerBridgeEvent> get events => _eventsController.stream;

  @override
  Future<void> initialize() async {
    try {
      _localeDiagnostic = _ensureNumericLocaleForMpv();
      _bindings ??= _MpvBindings(MpvDynamicLibrary.open());
      if (_isInitialized && _handle != null && _handle != nullptr) {
        return;
      }

      if (_needsReinitialize || _handle == null || _handle == nullptr) {
        _disposeHandle();
        _handle = _bindings!.create();
        _needsReinitialize = false;
      }

      if (_handle == null || _handle == nullptr) {
        final message =
            'mpv returned a null player handle. On Linux this usually means '
                    'LC_NUMERIC was not set to C before libmpv initialized. '
                    '${_localeDiagnostic ?? ''}'
                .trim();
        _state = _state.copyWith(
          status: PlayerStatus.error,
          errorMessage: message,
          launchError: message,
        );
        _emitEvent(PlayerBridgeEventType.error, message);
        return;
      }

      _lastLogMessage = null;
      await _setStartupOption('terminal', 'no', fatal: true);
      await _setStartupOption('force-window', 'immediate', fatal: true);
      await _setStartupOption('idle', 'once', fatal: true);
      await _setStartupOption('input-default-bindings', 'yes', fatal: true);
      await _setStartupOption('input-cursor', 'yes', fatal: false);
      await _setStartupOption('input-vo-keyboard', 'yes', fatal: false);
      await _setStartupOption('osc', 'yes', fatal: true);
      await _setStartupOption('keep-open', 'no', fatal: true);
      await _setStartupOption('window-maximized', 'yes', fatal: false);
      await _setStartupOption('autofit-larger', '100%x100%', fatal: false);
      await _setStartupOption('border', 'yes', fatal: false);
      await _setStartupOption('title-bar', 'yes', fatal: false);
      await _setStartupOption('title', 'Flumby', fatal: true);
      if (_state.status == PlayerStatus.error) {
        _emitEvent(PlayerBridgeEventType.error, _state.errorMessage);
        return;
      }

      final initializeResult = _bindings!.initialize(_handle!);
      if (initializeResult < 0) {
        final message = _withLastLog(
          'mpv_initialize failed with ${_describeError(initializeResult)}.',
        );
        _state = _state.copyWith(
          status: PlayerStatus.error,
          errorMessage: message,
          launchError: message,
        );
        _emitEvent(PlayerBridgeEventType.error, message);
        return;
      }

      _isInitialized = true;
      _state = _state.copyWith(
        status: PlayerStatus.ready,
        errorMessage: null,
        launchError: null,
      );
      _startEventPolling();
      final logLevelResult = _bindings!.requestLogMessages(_handle!, 'info');
      if (logLevelResult < 0) {
        _lastLogMessage =
            'mpv log subscription failed with ${_describeError(logLevelResult)}.';
      }
      _emitEvent(PlayerBridgeEventType.initialized);
    } catch (error) {
      final message = 'Bundled libmpv is not available: $error';
      _state = _state.copyWith(
        status: PlayerStatus.unavailable,
        errorMessage: message,
        launchError: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
    }
  }

  @override
  Future<void> open(PlayerMediaSource source) async {
    if (_needsReinitialize || !_isInitialized) {
      await initialize();
    }

    if (_handle == null || _handle == nullptr || _bindings == null) {
      final message = 'mpv is not initialized on this device.';
      _state = _state.copyWith(
        status: PlayerStatus.unavailable,
        source: source,
        errorMessage: message,
        launchError: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
      return;
    }

    final titleResult = _bindings!.setOptionString(
      _handle!,
      'force-media-title',
      source.title,
    );
    if (titleResult < 0) {
      final message = _withLastLog(
        'mpv could not update the media title (${_describeError(titleResult)}), but playback can still continue.',
      );
      _state = _state.copyWith(errorMessage: message);
    }

    final result = _bindings!.command(_handle!, <String>[
      'loadfile',
      source.streamUrl,
      'replace',
    ]);
    if (result < 0) {
      final message = _withLastLog(
        'mpv failed to load media with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: PlayerStatus.error,
        source: source,
        errorMessage: message,
        launchError: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
      return;
    }

    if (source.resumePositionSeconds > 0) {
      await seek(Duration(seconds: source.resumePositionSeconds));
    }

    _state = _state.copyWith(
      status: PlayerStatus.ready,
      source: source,
      errorMessage: null,
      launchError: null,
    );
  }

  @override
  Future<void> close() async {
    if (_handle == null || _handle == nullptr || _bindings == null) {
      return;
    }

    final result = _bindings!.command(_handle!, <String>['quit']);
    if (result < 0) {
      final message = _withLastLog(
        'mpv failed to quit with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: PlayerStatus.error,
        errorMessage: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
    }
  }

  @override
  Future<void> playPause() async {
    if (_handle == null || _handle == nullptr || _bindings == null) {
      return;
    }

    final result = _bindings!.commandString(_handle!, 'cycle pause');
    if (result < 0) {
      final message = _withLastLog(
        'mpv failed to toggle pause with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: PlayerStatus.error,
        errorMessage: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
      return;
    }

    _state = _state.copyWith(
      status: _state.status == PlayerStatus.playing
          ? PlayerStatus.paused
          : PlayerStatus.playing,
    );
  }

  @override
  Future<void> seek(Duration position) async {
    if (_handle == null || _handle == nullptr || _bindings == null) {
      return;
    }

    final result = _bindings!.commandString(
      _handle!,
      'seek ${position.inSeconds} absolute+exact',
    );
    if (result < 0) {
      final message = _withLastLog(
        'mpv failed to seek with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: PlayerStatus.error,
        errorMessage: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
      return;
    }

    _state = _state.copyWith(positionSeconds: position.inSeconds);
  }

  @override
  Future<void> setSubtitleTrack(String? trackId) async {
    await _setTrack('sid', trackId);
    _state = _state.copyWith(subtitleTrackId: trackId);
  }

  @override
  Future<void> setAudioTrack(String? trackId) async {
    await _setTrack('aid', trackId);
    _state = _state.copyWith(audioTrackId: trackId);
  }

  @override
  Future<void> setMpvOption(String key, String value) async {
    if (_handle == null || _handle == nullptr || _bindings == null) {
      return;
    }

    final result = _bindings!.setOptionString(_handle!, key, value);
    if (result < 0) {
      final message = _withLastLog(
        'mpv option "$key" failed with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: PlayerStatus.error,
        errorMessage: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
    }
  }

  @override
  Future<void> dispose() async {
    _eventPoller?.cancel();
    if (!_eventsController.isClosed) {
      await _eventsController.close();
    }
    _disposeHandle();
  }

  Future<void> _setTrack(String property, String? trackId) async {
    if (_handle == null || _handle == nullptr || _bindings == null) {
      return;
    }

    final value = trackId ?? 'no';
    final result = _bindings!.commandString(_handle!, 'set $property $value');
    if (result < 0) {
      final message = _withLastLog(
        'mpv failed to set $property with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: PlayerStatus.error,
        errorMessage: message,
      );
      _emitEvent(PlayerBridgeEventType.error, message);
    }
  }

  Future<void> _setStartupOption(
    String key,
    String value, {
    bool fatal = false,
  }) async {
    if (_handle == null || _handle == nullptr || _bindings == null) {
      return;
    }

    final result = _bindings!.setOptionString(_handle!, key, value);
    if (result < 0) {
      final message = _withLastLog(
        'mpv startup option "$key" failed with ${_describeError(result)}.',
      );
      _state = _state.copyWith(
        status: fatal ? PlayerStatus.error : _state.status,
        errorMessage: message,
        launchError: fatal ? message : _state.launchError,
      );
    }
  }

  void _startEventPolling() {
    _eventPoller?.cancel();
    _eventPoller = Timer.periodic(const Duration(milliseconds: 150), (_) {
      _drainEvents();
    });
  }

  void _drainEvents() {
    if (_handle == null ||
        _handle == nullptr ||
        _bindings == null ||
        _isDrainingEvents) {
      return;
    }

    _isDrainingEvents = true;
    try {
      while (true) {
        final eventPointer = _bindings!.waitEvent(_handle!, 0);
        if (eventPointer == nullptr) {
          break;
        }

        final event = eventPointer.ref;
        if (event.eventId == _MpvBindings.eventNone) {
          break;
        }

        _handleEvent(event);
      }
    } finally {
      _isDrainingEvents = false;
    }
  }

  void _handleEvent(_MpvEventNative event) {
    switch (event.eventId) {
      case _MpvBindings.eventLogMessage:
        final message = _readLogMessage(event.data);
        if (message != null && message.isNotEmpty) {
          _lastLogMessage = message;
          _emitEvent(PlayerBridgeEventType.log, message);
        }
      case _MpvBindings.eventFileLoaded:
        _state = _state.copyWith(
          status: PlayerStatus.playing,
          errorMessage: null,
          launchError: null,
        );
        _emitEvent(PlayerBridgeEventType.fileLoaded);
      case _MpvBindings.eventEndFile:
        final endData = event.data.cast<_MpvEventEndFileNative>();
        if (endData == nullptr) {
          _state = _state.copyWith(status: PlayerStatus.ready);
          _emitEvent(PlayerBridgeEventType.playbackEnded);
          return;
        }

        final reason = endData.ref.reason;
        final errorCode = endData.ref.error;
        if (reason == _MpvBindings.endFileReasonError || errorCode < 0) {
          final message = _withLastLog(
            'mpv playback ended with ${_describeError(errorCode)}.',
          );
          _state = _state.copyWith(
            status: PlayerStatus.error,
            errorMessage: message,
            launchError: message,
          );
          _emitEvent(PlayerBridgeEventType.error, message);
          return;
        }

        _state = _state.copyWith(status: PlayerStatus.ready);
        _emitEvent(PlayerBridgeEventType.playbackEnded);
      case _MpvBindings.eventShutdown:
        _isInitialized = false;
        _needsReinitialize = true;
        _eventPoller?.cancel();
        _state = _state.copyWith(
          status: PlayerStatus.ready,
          errorMessage:
              'The mpv playback window closed. You can reopen it from Flumby.',
        );
        _emitEvent(
          PlayerBridgeEventType.shutdown,
          'The mpv playback window closed. You can reopen it from Flumby.',
        );
      default:
        break;
    }
  }

  String? _readLogMessage(Pointer<Void> data) {
    if (data == nullptr) {
      return null;
    }

    final log = data.cast<_MpvEventLogMessageNative>().ref;
    final prefix = _readUtf8(log.prefix);
    final level = _readUtf8(log.level);
    final text = _readUtf8(log.text)?.trim();
    if (text == null || text.isEmpty) {
      return null;
    }

    final parts = <String>[
      if (prefix != null && prefix.isNotEmpty) prefix,
      if (level != null && level.isNotEmpty) level,
    ];
    final header = parts.join('/');
    if (header.isEmpty) {
      return text;
    }

    return '$header: $text';
  }

  String _describeError(int code) {
    if (code >= 0) {
      return 'code $code';
    }

    if (_bindings == null) {
      return 'code $code';
    }

    final errorPointer = _bindings!.errorString(code);
    final description = _readUtf8(errorPointer);
    if (description == null || description.isEmpty) {
      return 'code $code';
    }

    return '$description (code $code)';
  }

  String _withLastLog(String message) {
    if (_lastLogMessage == null || _lastLogMessage!.isEmpty) {
      return message;
    }

    return '$message Last mpv log: $_lastLogMessage';
  }

  String? _readUtf8(Pointer<Utf8> pointer) {
    if (pointer == nullptr) {
      return null;
    }

    return pointer.toDartString();
  }

  void _disposeHandle() {
    final handle = _handle;
    _eventPoller?.cancel();
    _eventPoller = null;
    if (handle != null && handle != nullptr) {
      _bindings?.terminateDestroy(handle);
    }
    _handle = null;
    _isInitialized = false;
  }

  void _emitEvent(PlayerBridgeEventType type, [String? message]) {
    if (_eventsController.isClosed) {
      return;
    }

    _eventsController.add(PlayerBridgeEvent(type: type, message: message));
  }

  String? _ensureNumericLocaleForMpv() {
    if (!Platform.isLinux) {
      return null;
    }

    try {
      final bindings = _PosixLocaleBindings.instance;
      final before = bindings.currentNumericLocale();
      bindings.setEnvironmentNumericLocale('C');
      bindings.setNumericLocale('C');
      final after = bindings.currentNumericLocale();
      return 'LC_NUMERIC before=$before after=$after';
    } catch (error) {
      return 'Failed to enforce LC_NUMERIC=C: $error';
    }
  }
}

final class _MpvBindings {
  _MpvBindings(DynamicLibrary library)
    : create = library.lookupFunction<_MpvCreateNative, _MpvCreateDart>(
        'mpv_create',
      ),
      initialize = library
          .lookupFunction<_MpvInitializeNative, _MpvInitializeDart>(
            'mpv_initialize',
          ),
      terminateDestroy = library
          .lookupFunction<_MpvTerminateDestroyNative, _MpvTerminateDestroyDart>(
            'mpv_terminate_destroy',
          ),
      _errorString = library
          .lookupFunction<_MpvErrorStringNative, _MpvErrorStringDart>(
            'mpv_error_string',
          ),
      _command = library.lookupFunction<_MpvCommandNative, _MpvCommandDart>(
        'mpv_command',
      ),
      _commandString = library
          .lookupFunction<_MpvCommandStringNative, _MpvCommandStringDart>(
            'mpv_command_string',
          ),
      _requestLogMessages = library
          .lookupFunction<
            _MpvRequestLogMessagesNative,
            _MpvRequestLogMessagesDart
          >('mpv_request_log_messages'),
      _setOptionString = library
          .lookupFunction<_MpvSetOptionStringNative, _MpvSetOptionStringDart>(
            'mpv_set_option_string',
          ),
      _waitEvent = library
          .lookupFunction<_MpvWaitEventNative, _MpvWaitEventDart>(
            'mpv_wait_event',
          );

  static const int eventNone = 0;
  static const int eventShutdown = 1;
  static const int eventLogMessage = 2;
  static const int eventEndFile = 7;
  static const int eventFileLoaded = 8;
  static const int endFileReasonError = 4;

  final _MpvCreateDart create;
  final _MpvInitializeDart initialize;
  final _MpvTerminateDestroyDart terminateDestroy;
  final _MpvErrorStringDart _errorString;
  final _MpvCommandDart _command;
  final _MpvCommandStringDart _commandString;
  final _MpvRequestLogMessagesDart _requestLogMessages;
  final _MpvSetOptionStringDart _setOptionString;
  final _MpvWaitEventDart _waitEvent;

  int command(Pointer<Void> handle, List<String> arguments) {
    final nativeArguments = <Pointer<Utf8>>[
      for (final argument in arguments) argument.toNativeUtf8(),
    ];
    final nativeArray = calloc<Pointer<Utf8>>(nativeArguments.length + 1);
    try {
      for (var index = 0; index < nativeArguments.length; index++) {
        nativeArray[index] = nativeArguments[index];
      }
      nativeArray[nativeArguments.length] = nullptr;
      return _command(handle, nativeArray);
    } finally {
      for (final pointer in nativeArguments) {
        calloc.free(pointer);
      }
      calloc.free(nativeArray);
    }
  }

  int commandString(Pointer<Void> handle, String command) {
    final nativeCommand = command.toNativeUtf8();
    try {
      return _commandString(handle, nativeCommand);
    } finally {
      calloc.free(nativeCommand);
    }
  }

  int setOptionString(Pointer<Void> handle, String key, String value) {
    final nativeKey = key.toNativeUtf8();
    final nativeValue = value.toNativeUtf8();
    try {
      return _setOptionString(handle, nativeKey, nativeValue);
    } finally {
      calloc
        ..free(nativeKey)
        ..free(nativeValue);
    }
  }

  int requestLogMessages(Pointer<Void> handle, String level) {
    final nativeLevel = level.toNativeUtf8();
    try {
      return _requestLogMessages(handle, nativeLevel);
    } finally {
      calloc.free(nativeLevel);
    }
  }

  Pointer<_MpvEventNative> waitEvent(Pointer<Void> handle, double timeout) {
    return _waitEvent(handle, timeout);
  }

  Pointer<Utf8> errorString(int code) {
    return _errorString(code);
  }
}

typedef _MpvCreateNative = Pointer<Void> Function();
typedef _MpvCreateDart = Pointer<Void> Function();

typedef _MpvInitializeNative = Int32 Function(Pointer<Void> handle);
typedef _MpvInitializeDart = int Function(Pointer<Void> handle);

typedef _MpvTerminateDestroyNative = Void Function(Pointer<Void> handle);
typedef _MpvTerminateDestroyDart = void Function(Pointer<Void> handle);

typedef _MpvErrorStringNative = Pointer<Utf8> Function(Int32 error);
typedef _MpvErrorStringDart = Pointer<Utf8> Function(int error);

typedef _MpvCommandNative =
    Int32 Function(Pointer<Void> handle, Pointer<Pointer<Utf8>> arguments);
typedef _MpvCommandDart =
    int Function(Pointer<Void> handle, Pointer<Pointer<Utf8>> arguments);

typedef _MpvCommandStringNative =
    Int32 Function(Pointer<Void> handle, Pointer<Utf8> command);
typedef _MpvCommandStringDart =
    int Function(Pointer<Void> handle, Pointer<Utf8> command);

typedef _MpvRequestLogMessagesNative =
    Int32 Function(Pointer<Void> handle, Pointer<Utf8> minLevel);
typedef _MpvRequestLogMessagesDart =
    int Function(Pointer<Void> handle, Pointer<Utf8> minLevel);

typedef _MpvSetOptionStringNative =
    Int32 Function(
      Pointer<Void> handle,
      Pointer<Utf8> name,
      Pointer<Utf8> value,
    );
typedef _MpvSetOptionStringDart =
    int Function(Pointer<Void> handle, Pointer<Utf8> name, Pointer<Utf8> value);

typedef _MpvWaitEventNative =
    Pointer<_MpvEventNative> Function(Pointer<Void> handle, Double timeout);
typedef _MpvWaitEventDart =
    Pointer<_MpvEventNative> Function(Pointer<Void> handle, double timeout);

final class _MpvEventLogMessageNative extends Struct {
  external Pointer<Utf8> prefix;
  external Pointer<Utf8> level;
  external Pointer<Utf8> text;

  @Int32()
  external int logLevel;
}

final class _MpvEventEndFileNative extends Struct {
  @Int32()
  external int reason;

  @Int32()
  external int error;

  @Int64()
  external int playlistEntryId;

  @Int64()
  external int playlistInsertId;

  @Int32()
  external int playlistInsertNumEntries;
}

final class _MpvEventNative extends Struct {
  @Int32()
  external int eventId;

  @Int32()
  external int error;

  @Uint64()
  external int replyUserdata;

  external Pointer<Void> data;
}

final class _PosixLocaleBindings {
  _PosixLocaleBindings._(DynamicLibrary library)
    : _setLocale = library.lookupFunction<_SetLocaleNative, _SetLocaleDart>(
        'setlocale',
      ),
      _setEnv = library.lookupFunction<_SetEnvNative, _SetEnvDart>('setenv');

  static final _PosixLocaleBindings instance = _PosixLocaleBindings._(
    DynamicLibrary.open('libc.so.6'),
  );

  static const int _lcNumeric = 1;

  final _SetLocaleDart _setLocale;
  final _SetEnvDart _setEnv;

  String? currentNumericLocale() {
    final pointer = _setLocale(_lcNumeric, nullptr);
    if (pointer == nullptr) {
      return null;
    }
    return pointer.cast<Utf8>().toDartString();
  }

  void setEnvironmentNumericLocale(String value) {
    final nativeName = 'LC_NUMERIC'.toNativeUtf8();
    final nativeValue = value.toNativeUtf8();
    try {
      _setEnv(nativeName, nativeValue, 1);
    } finally {
      calloc
        ..free(nativeName)
        ..free(nativeValue);
    }
  }

  void setNumericLocale(String value) {
    final nativeValue = value.toNativeUtf8();
    try {
      _setLocale(_lcNumeric, nativeValue.cast<Char>());
    } finally {
      calloc.free(nativeValue);
    }
  }
}

typedef _SetLocaleNative =
    Pointer<Char> Function(Int32 category, Pointer<Char> locale);
typedef _SetLocaleDart =
    Pointer<Char> Function(int category, Pointer<Char> locale);

typedef _SetEnvNative =
    Int32 Function(Pointer<Utf8> name, Pointer<Utf8> value, Int32 overwrite);
typedef _SetEnvDart =
    int Function(Pointer<Utf8> name, Pointer<Utf8> value, int overwrite);
