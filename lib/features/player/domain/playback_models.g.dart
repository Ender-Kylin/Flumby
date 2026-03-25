// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerMediaSource _$PlayerMediaSourceFromJson(Map<String, dynamic> json) =>
    _PlayerMediaSource(
      serverId: json['serverId'] as String,
      itemId: json['itemId'] as String,
      title: json['title'] as String,
      streamUrl: json['streamUrl'] as String,
      mediaSourceId: json['mediaSourceId'] as String?,
      playSessionId: json['playSessionId'] as String?,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
      resumePositionSeconds:
          (json['resumePositionSeconds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlayerMediaSourceToJson(_PlayerMediaSource instance) =>
    <String, dynamic>{
      'serverId': instance.serverId,
      'itemId': instance.itemId,
      'title': instance.title,
      'streamUrl': instance.streamUrl,
      'mediaSourceId': instance.mediaSourceId,
      'playSessionId': instance.playSessionId,
      'durationSeconds': instance.durationSeconds,
      'resumePositionSeconds': instance.resumePositionSeconds,
    };

_PlayerStateSnapshot _$PlayerStateSnapshotFromJson(Map<String, dynamic> json) =>
    _PlayerStateSnapshot(
      status: $enumDecode(_$PlayerStatusEnumMap, json['status']),
      backend: $enumDecode(_$PlayerBackendEnumMap, json['backend']),
      presentationMode:
          $enumDecodeNullable(
            _$PlayerPresentationModeEnumMap,
            json['presentationMode'],
          ) ??
          PlayerPresentationMode.embedded,
      externalWindowActive: json['externalWindowActive'] as bool? ?? false,
      source: json['source'] == null
          ? null
          : PlayerMediaSource.fromJson(json['source'] as Map<String, dynamic>),
      positionSeconds: (json['positionSeconds'] as num?)?.toInt() ?? 0,
      subtitleTrackId: json['subtitleTrackId'] as String?,
      audioTrackId: json['audioTrackId'] as String?,
      errorMessage: json['errorMessage'] as String?,
      launchError: json['launchError'] as String?,
    );

Map<String, dynamic> _$PlayerStateSnapshotToJson(
  _PlayerStateSnapshot instance,
) => <String, dynamic>{
  'status': _$PlayerStatusEnumMap[instance.status]!,
  'backend': _$PlayerBackendEnumMap[instance.backend]!,
  'presentationMode':
      _$PlayerPresentationModeEnumMap[instance.presentationMode]!,
  'externalWindowActive': instance.externalWindowActive,
  'source': instance.source?.toJson(),
  'positionSeconds': instance.positionSeconds,
  'subtitleTrackId': instance.subtitleTrackId,
  'audioTrackId': instance.audioTrackId,
  'errorMessage': instance.errorMessage,
  'launchError': instance.launchError,
};

const _$PlayerStatusEnumMap = {
  PlayerStatus.idle: 'idle',
  PlayerStatus.ready: 'ready',
  PlayerStatus.playing: 'playing',
  PlayerStatus.paused: 'paused',
  PlayerStatus.unavailable: 'unavailable',
  PlayerStatus.error: 'error',
};

const _$PlayerBackendEnumMap = {
  PlayerBackend.stub: 'stub',
  PlayerBackend.mpv: 'mpv',
};

const _$PlayerPresentationModeEnumMap = {
  PlayerPresentationMode.embedded: 'embedded',
  PlayerPresentationMode.separateWindow: 'separateWindow',
};

_PlaybackReport _$PlaybackReportFromJson(Map<String, dynamic> json) =>
    _PlaybackReport(
      itemId: json['itemId'] as String,
      playSessionId: json['playSessionId'] as String,
      mediaSourceId: json['mediaSourceId'] as String?,
      positionSeconds: (json['positionSeconds'] as num?)?.toInt() ?? 0,
      isPaused: json['isPaused'] as bool? ?? false,
    );

Map<String, dynamic> _$PlaybackReportToJson(_PlaybackReport instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'playSessionId': instance.playSessionId,
      'mediaSourceId': instance.mediaSourceId,
      'positionSeconds': instance.positionSeconds,
      'isPaused': instance.isPaused,
    };
