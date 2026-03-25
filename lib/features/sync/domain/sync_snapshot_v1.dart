import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/date_time_converter.dart';

part 'sync_snapshot_v1.freezed.dart';
part 'sync_snapshot_v1.g.dart';

@freezed
abstract class SyncServerRecord with _$SyncServerRecord {
  const factory SyncServerRecord({
    required String id,
    required String name,
    required String baseUrl,
    required String type,
    String? username,
    @DateTimeIso8601Converter() required DateTime updatedAt,
    required String deviceId,
  }) = _SyncServerRecord;

  factory SyncServerRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncServerRecordFromJson(json);
}

@freezed
abstract class SyncPreferenceRecord with _$SyncPreferenceRecord {
  const factory SyncPreferenceRecord({
    required String key,
    required String value,
    @DateTimeIso8601Converter() required DateTime updatedAt,
    required String deviceId,
  }) = _SyncPreferenceRecord;

  factory SyncPreferenceRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncPreferenceRecordFromJson(json);
}

@freezed
abstract class SyncPlaybackStateRecord with _$SyncPlaybackStateRecord {
  const factory SyncPlaybackStateRecord({
    required String serverId,
    required String itemId,
    required int positionSeconds,
    required int durationSeconds,
    @DateTimeIso8601Converter() required DateTime updatedAt,
    required String deviceId,
  }) = _SyncPlaybackStateRecord;

  factory SyncPlaybackStateRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncPlaybackStateRecordFromJson(json);
}

@freezed
abstract class SyncCollectionRecord with _$SyncCollectionRecord {
  const factory SyncCollectionRecord({
    required String serverId,
    required String itemId,
    required String kind,
    @DateTimeIso8601Converter() required DateTime updatedAt,
    required String deviceId,
  }) = _SyncCollectionRecord;

  factory SyncCollectionRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncCollectionRecordFromJson(json);
}

@freezed
abstract class SyncWatchHistoryRecord with _$SyncWatchHistoryRecord {
  const factory SyncWatchHistoryRecord({
    required String serverId,
    required String itemId,
    @DateTimeIso8601Converter() required DateTime watchedAt,
    @DateTimeIso8601Converter() required DateTime updatedAt,
    required String deviceId,
  }) = _SyncWatchHistoryRecord;

  factory SyncWatchHistoryRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncWatchHistoryRecordFromJson(json);
}

@freezed
abstract class SyncSnapshotV1 with _$SyncSnapshotV1 {
  const factory SyncSnapshotV1({
    @Default('v1') String schemaVersion,
    required String deviceId,
    @DateTimeIso8601Converter() required DateTime updatedAt,
    @Default(<SyncServerRecord>[]) List<SyncServerRecord> servers,
    @Default(<SyncPreferenceRecord>[]) List<SyncPreferenceRecord> preferences,
    @Default(<SyncPlaybackStateRecord>[])
    List<SyncPlaybackStateRecord> playbackStates,
    @Default(<SyncCollectionRecord>[]) List<SyncCollectionRecord> collections,
    @Default(<SyncWatchHistoryRecord>[])
    List<SyncWatchHistoryRecord> watchHistory,
  }) = _SyncSnapshotV1;

  factory SyncSnapshotV1.fromJson(Map<String, dynamic> json) =>
      _$SyncSnapshotV1FromJson(json);
}
