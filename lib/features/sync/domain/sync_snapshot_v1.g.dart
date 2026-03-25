// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_snapshot_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncServerRecord _$SyncServerRecordFromJson(Map<String, dynamic> json) =>
    _SyncServerRecord(
      id: json['id'] as String,
      name: json['name'] as String,
      baseUrl: json['baseUrl'] as String,
      type: json['type'] as String,
      username: json['username'] as String?,
      updatedAt: const DateTimeIso8601Converter().fromJson(
        json['updatedAt'] as String,
      ),
      deviceId: json['deviceId'] as String,
    );

Map<String, dynamic> _$SyncServerRecordToJson(_SyncServerRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseUrl': instance.baseUrl,
      'type': instance.type,
      'username': instance.username,
      'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
      'deviceId': instance.deviceId,
    };

_SyncPreferenceRecord _$SyncPreferenceRecordFromJson(
  Map<String, dynamic> json,
) => _SyncPreferenceRecord(
  key: json['key'] as String,
  value: json['value'] as String,
  updatedAt: const DateTimeIso8601Converter().fromJson(
    json['updatedAt'] as String,
  ),
  deviceId: json['deviceId'] as String,
);

Map<String, dynamic> _$SyncPreferenceRecordToJson(
  _SyncPreferenceRecord instance,
) => <String, dynamic>{
  'key': instance.key,
  'value': instance.value,
  'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
  'deviceId': instance.deviceId,
};

_SyncPlaybackStateRecord _$SyncPlaybackStateRecordFromJson(
  Map<String, dynamic> json,
) => _SyncPlaybackStateRecord(
  serverId: json['serverId'] as String,
  itemId: json['itemId'] as String,
  positionSeconds: (json['positionSeconds'] as num).toInt(),
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  updatedAt: const DateTimeIso8601Converter().fromJson(
    json['updatedAt'] as String,
  ),
  deviceId: json['deviceId'] as String,
);

Map<String, dynamic> _$SyncPlaybackStateRecordToJson(
  _SyncPlaybackStateRecord instance,
) => <String, dynamic>{
  'serverId': instance.serverId,
  'itemId': instance.itemId,
  'positionSeconds': instance.positionSeconds,
  'durationSeconds': instance.durationSeconds,
  'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
  'deviceId': instance.deviceId,
};

_SyncCollectionRecord _$SyncCollectionRecordFromJson(
  Map<String, dynamic> json,
) => _SyncCollectionRecord(
  serverId: json['serverId'] as String,
  itemId: json['itemId'] as String,
  kind: json['kind'] as String,
  updatedAt: const DateTimeIso8601Converter().fromJson(
    json['updatedAt'] as String,
  ),
  deviceId: json['deviceId'] as String,
);

Map<String, dynamic> _$SyncCollectionRecordToJson(
  _SyncCollectionRecord instance,
) => <String, dynamic>{
  'serverId': instance.serverId,
  'itemId': instance.itemId,
  'kind': instance.kind,
  'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
  'deviceId': instance.deviceId,
};

_SyncWatchHistoryRecord _$SyncWatchHistoryRecordFromJson(
  Map<String, dynamic> json,
) => _SyncWatchHistoryRecord(
  serverId: json['serverId'] as String,
  itemId: json['itemId'] as String,
  watchedAt: const DateTimeIso8601Converter().fromJson(
    json['watchedAt'] as String,
  ),
  updatedAt: const DateTimeIso8601Converter().fromJson(
    json['updatedAt'] as String,
  ),
  deviceId: json['deviceId'] as String,
);

Map<String, dynamic> _$SyncWatchHistoryRecordToJson(
  _SyncWatchHistoryRecord instance,
) => <String, dynamic>{
  'serverId': instance.serverId,
  'itemId': instance.itemId,
  'watchedAt': const DateTimeIso8601Converter().toJson(instance.watchedAt),
  'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
  'deviceId': instance.deviceId,
};

_SyncSnapshotV1 _$SyncSnapshotV1FromJson(
  Map<String, dynamic> json,
) => _SyncSnapshotV1(
  schemaVersion: json['schemaVersion'] as String? ?? 'v1',
  deviceId: json['deviceId'] as String,
  updatedAt: const DateTimeIso8601Converter().fromJson(
    json['updatedAt'] as String,
  ),
  servers:
      (json['servers'] as List<dynamic>?)
          ?.map((e) => SyncServerRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SyncServerRecord>[],
  preferences:
      (json['preferences'] as List<dynamic>?)
          ?.map((e) => SyncPreferenceRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SyncPreferenceRecord>[],
  playbackStates:
      (json['playbackStates'] as List<dynamic>?)
          ?.map(
            (e) => SyncPlaybackStateRecord.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <SyncPlaybackStateRecord>[],
  collections:
      (json['collections'] as List<dynamic>?)
          ?.map((e) => SyncCollectionRecord.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SyncCollectionRecord>[],
  watchHistory:
      (json['watchHistory'] as List<dynamic>?)
          ?.map(
            (e) => SyncWatchHistoryRecord.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <SyncWatchHistoryRecord>[],
);

Map<String, dynamic> _$SyncSnapshotV1ToJson(_SyncSnapshotV1 instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'deviceId': instance.deviceId,
      'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
      'servers': instance.servers.map((e) => e.toJson()).toList(),
      'preferences': instance.preferences.map((e) => e.toJson()).toList(),
      'playbackStates': instance.playbackStates.map((e) => e.toJson()).toList(),
      'collections': instance.collections.map((e) => e.toJson()).toList(),
      'watchHistory': instance.watchHistory.map((e) => e.toJson()).toList(),
    };
