import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class ServerRecords extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get baseUrl => text()();

  TextColumn get serverType => text()();

  TextColumn get username => text().nullable()();

  BoolColumn get isOnline => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PlaybackStateRecords extends Table {
  TextColumn get serverId => text()();

  TextColumn get itemId => text()();

  IntColumn get positionSeconds => integer().withDefault(const Constant(0))();

  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();

  TextColumn get deviceId => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {serverId, itemId};
}

class WatchHistoryRecords extends Table {
  TextColumn get serverId => text()();

  TextColumn get itemId => text()();

  DateTimeColumn get watchedAt => dateTime()();

  TextColumn get deviceId => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {serverId, itemId};
}

class CollectionRecords extends Table {
  TextColumn get serverId => text()();

  TextColumn get itemId => text()();

  TextColumn get kind => text()();

  TextColumn get deviceId => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {serverId, itemId, kind};
}

class PreferenceRecords extends Table {
  TextColumn get key => text()();

  TextColumn get value => text()();

  TextColumn get deviceId => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class SyncQueueRecords extends Table {
  TextColumn get queueId => text()();

  TextColumn get entityType => text()();

  TextColumn get entityId => text()();

  TextColumn get payload => text()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {queueId};
}

@DriftDatabase(
  tables: [
    ServerRecords,
    PlaybackStateRecords,
    WatchHistoryRecords,
    CollectionRecords,
    PreferenceRecords,
    SyncQueueRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  Future<void> upsertPlaybackState(PlaybackStateRecordsCompanion companion) {
    return into(playbackStateRecords).insertOnConflictUpdate(companion);
  }

  Future<void> enqueueSync({
    required String queueId,
    required String entityType,
    required String entityId,
    required String payload,
    required DateTime updatedAt,
  }) {
    return into(syncQueueRecords).insertOnConflictUpdate(
      SyncQueueRecordsCompanion.insert(
        queueId: queueId,
        entityType: entityType,
        entityId: entityId,
        payload: payload,
        updatedAt: updatedAt,
      ),
    );
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(_openConnection());
  ref.onDispose(database.close);
  return database;
});

QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final appSupportDirectory = await getApplicationSupportDirectory();
    final databaseFile = File(
      path.join(appSupportDirectory.path, 'flumby.sqlite'),
    );
    return NativeDatabase.createInBackground(databaseFile);
  });
}
