import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/storage/secure_storage_service.dart';

final playbackStateRepositoryProvider = Provider<PlaybackStateRepository>((
  ref,
) {
  return PlaybackStateRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(secureStorageProvider),
  );
});

class SavedPlaybackState {
  const SavedPlaybackState({
    required this.serverId,
    required this.itemId,
    required this.positionSeconds,
    required this.durationSeconds,
    required this.updatedAt,
  });

  final String serverId;
  final String itemId;
  final int positionSeconds;
  final int durationSeconds;
  final DateTime updatedAt;
}

class PlaybackStateRepository {
  const PlaybackStateRepository(this._database, this._secureStorage);

  final AppDatabase _database;
  final SecureStorageService _secureStorage;

  Future<SavedPlaybackState?> loadState({
    required String serverId,
    required String itemId,
  }) async {
    final row =
        await (_database.select(_database.playbackStateRecords)
              ..where((table) => table.serverId.equals(serverId))
              ..where((table) => table.itemId.equals(itemId)))
            .getSingleOrNull();
    if (row == null) {
      return null;
    }

    return SavedPlaybackState(
      serverId: row.serverId,
      itemId: row.itemId,
      positionSeconds: row.positionSeconds,
      durationSeconds: row.durationSeconds,
      updatedAt: row.updatedAt.toUtc(),
    );
  }

  Future<void> saveState({
    required String serverId,
    required String itemId,
    required int positionSeconds,
    required int durationSeconds,
  }) async {
    final deviceId = await _secureStorage.getOrCreateDeviceId();
    await _database.upsertPlaybackState(
      PlaybackStateRecordsCompanion.insert(
        serverId: serverId,
        itemId: itemId,
        positionSeconds: Value(positionSeconds),
        durationSeconds: Value(durationSeconds),
        deviceId: deviceId,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
