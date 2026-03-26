import '../domain/sync_snapshot_v1.dart';

class SnapshotMergeService {
  const SnapshotMergeService();

  SyncSnapshotV1 merge({
    required SyncSnapshotV1 local,
    required SyncSnapshotV1 remote,
    required String deviceId,
  }) {
    return SyncSnapshotV1(
      schemaVersion: local.schemaVersion,
      deviceId: deviceId,
      updatedAt: _latestDate(local.updatedAt, remote.updatedAt),
      servers: _mergeBy<SyncServerRecord>(
        local.servers,
        remote.servers,
        keyOf: (record) => record.id,
        updatedAtOf: (record) => record.updatedAt,
      ),
      serverLines: _mergeBy<SyncServerLineRecord>(
        local.serverLines,
        remote.serverLines,
        keyOf: (record) => record.id,
        updatedAtOf: (record) => record.updatedAt,
      ),
      preferences: _mergeBy<SyncPreferenceRecord>(
        local.preferences,
        remote.preferences,
        keyOf: (record) => record.key,
        updatedAtOf: (record) => record.updatedAt,
      ),
      playbackStates: _mergeBy<SyncPlaybackStateRecord>(
        local.playbackStates,
        remote.playbackStates,
        keyOf: (record) => '${record.serverId}:${record.itemId}',
        updatedAtOf: (record) => record.updatedAt,
      ),
      collections: _mergeBy<SyncCollectionRecord>(
        local.collections,
        remote.collections,
        keyOf: (record) => '${record.serverId}:${record.kind}:${record.itemId}',
        updatedAtOf: (record) => record.updatedAt,
      ),
      watchHistory: _mergeBy<SyncWatchHistoryRecord>(
        local.watchHistory,
        remote.watchHistory,
        keyOf: (record) => '${record.serverId}:${record.itemId}',
        updatedAtOf: (record) => record.updatedAt,
      ),
    );
  }

  List<T> _mergeBy<T>(
    List<T> local,
    List<T> remote, {
    required String Function(T value) keyOf,
    required DateTime Function(T value) updatedAtOf,
  }) {
    final merged = <String, T>{};

    for (final record in [...local, ...remote]) {
      final key = keyOf(record);
      final existing = merged[key];
      if (existing == null ||
          updatedAtOf(record).isAfter(updatedAtOf(existing))) {
        merged[key] = record;
      }
    }

    final values = merged.values.toList(growable: false);
    values.sort(
      (left, right) => updatedAtOf(right).compareTo(updatedAtOf(left)),
    );
    return values;
  }

  DateTime _latestDate(DateTime left, DateTime right) {
    return left.isAfter(right) ? left : right;
  }
}
