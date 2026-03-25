import 'package:freezed_annotation/freezed_annotation.dart';

import '../../server/domain/server_models.dart';

part 'playback_models.freezed.dart';
part 'playback_models.g.dart';

enum PlayerStatus { idle, ready, playing, paused, unavailable, error }

enum PlayerBackend { stub, mpv }

enum PlayerPresentationMode { embedded, separateWindow }

@freezed
abstract class PlayerMediaSource with _$PlayerMediaSource {
  const factory PlayerMediaSource({
    required String serverId,
    required String itemId,
    required String title,
    required String streamUrl,
    String? mediaSourceId,
    String? playSessionId,
    @Default(0) int durationSeconds,
    @Default(0) int resumePositionSeconds,
  }) = _PlayerMediaSource;

  factory PlayerMediaSource.fromJson(Map<String, dynamic> json) =>
      _$PlayerMediaSourceFromJson(json);
}

@freezed
abstract class PlayerStateSnapshot with _$PlayerStateSnapshot {
  const PlayerStateSnapshot._();

  const factory PlayerStateSnapshot({
    required PlayerStatus status,
    required PlayerBackend backend,
    @Default(PlayerPresentationMode.embedded)
    PlayerPresentationMode presentationMode,
    @Default(false) bool externalWindowActive,
    PlayerMediaSource? source,
    @Default(0) int positionSeconds,
    String? subtitleTrackId,
    String? audioTrackId,
    String? errorMessage,
    String? launchError,
  }) = _PlayerStateSnapshot;

  factory PlayerStateSnapshot.fromJson(Map<String, dynamic> json) =>
      _$PlayerStateSnapshotFromJson(json);

  bool get isAvailable =>
      status != PlayerStatus.unavailable && status != PlayerStatus.error;

  bool get isPlaying => status == PlayerStatus.playing;

  bool get isSeparateWindow =>
      presentationMode == PlayerPresentationMode.separateWindow;

  static PlayerStateSnapshot idle({
    PlayerBackend backend = PlayerBackend.stub,
    PlayerPresentationMode presentationMode = PlayerPresentationMode.embedded,
  }) {
    return PlayerStateSnapshot(
      status: PlayerStatus.idle,
      backend: backend,
      presentationMode: presentationMode,
    );
  }
}

@freezed
abstract class PlaybackReport with _$PlaybackReport {
  const factory PlaybackReport({
    required String itemId,
    required String playSessionId,
    String? mediaSourceId,
    @Default(0) int positionSeconds,
    @Default(false) bool isPaused,
  }) = _PlaybackReport;

  factory PlaybackReport.fromJson(Map<String, dynamic> json) =>
      _$PlaybackReportFromJson(json);
}

class PlayerLaunchContext {
  const PlayerLaunchContext({required this.session, required this.source});

  final MediaServerSession session;
  final PlayerMediaSource source;

  @override
  bool operator ==(Object other) {
    return other is PlayerLaunchContext &&
        other.session == session &&
        other.source == source;
  }

  @override
  int get hashCode => Object.hash(session, source);
}
