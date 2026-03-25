import 'sync_snapshot_v1.dart';

abstract interface class SyncProvider {
  String get providerId;

  Future<void> validateConfig(Map<String, Object?> config);

  Future<SyncSnapshotV1?> pullSnapshot();

  Future<void> pushSnapshot(SyncSnapshotV1 snapshot);

  Future<bool> healthCheck();
}
