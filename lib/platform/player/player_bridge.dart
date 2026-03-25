import '../../features/player/domain/playback_models.dart';

enum PlayerBridgeEventType {
  initialized,
  fileLoaded,
  playbackEnded,
  shutdown,
  error,
  log,
}

class PlayerBridgeEvent {
  const PlayerBridgeEvent({required this.type, this.message});

  final PlayerBridgeEventType type;
  final String? message;
}

abstract interface class PlayerBridge {
  Stream<PlayerBridgeEvent> get events;

  Future<void> initialize();

  Future<void> open(PlayerMediaSource source);

  Future<void> close();

  Future<void> playPause();

  Future<void> seek(Duration position);

  Future<void> setSubtitleTrack(String? trackId);

  Future<void> setAudioTrack(String? trackId);

  Future<void> setMpvOption(String key, String value);

  PlayerStateSnapshot get currentState;

  Future<void> dispose();
}

class StubPlayerBridge implements PlayerBridge {
  PlayerStateSnapshot _state = PlayerStateSnapshot.idle();

  @override
  PlayerStateSnapshot get currentState => _state;

  @override
  Stream<PlayerBridgeEvent> get events =>
      const Stream<PlayerBridgeEvent>.empty();

  @override
  Future<void> dispose() async {}

  @override
  Future<void> initialize() async {
    _state = _state.copyWith(
      status: PlayerStatus.unavailable,
      backend: PlayerBackend.stub,
      errorMessage: 'Desktop mpv bridge is not available on this platform yet.',
      launchError: 'Desktop mpv bridge is not available on this platform yet.',
    );
  }

  @override
  Future<void> open(PlayerMediaSource source) async {
    _state = _state.copyWith(source: source);
  }

  @override
  Future<void> close() async {
    _state = _state.copyWith(status: PlayerStatus.ready);
  }

  @override
  Future<void> playPause() async {}

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
}
