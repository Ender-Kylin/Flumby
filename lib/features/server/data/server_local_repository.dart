import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/storage/app_preferences_repository.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../domain/server_models.dart';

final serverLocalRepositoryProvider = Provider<ServerLocalRepository>((ref) {
  return ServerLocalRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appPreferencesRepositoryProvider),
    ref.watch(secureStorageProvider),
  );
});

class ServerLocalRepository {
  const ServerLocalRepository(
    this._database,
    this._preferences,
    this._secureStorage,
  );

  static const activeServerIdKey = 'servers.activeServerId';

  final AppDatabase _database;
  final AppPreferencesRepository _preferences;
  final SecureStorageService _secureStorage;

  Future<List<MediaServerProfile>> loadServers() async {
    final query = _database.select(_database.serverRecords)
      ..orderBy([
        (table) =>
            OrderingTerm(expression: table.updatedAt, mode: OrderingMode.desc),
      ]);
    final rows = await query.get();
    return rows.map(_mapServer).toList(growable: false);
  }

  Future<MediaServerProfile?> loadServer(String serverId) async {
    final row = await (_database.select(
      _database.serverRecords,
    )..where((table) => table.id.equals(serverId))).getSingleOrNull();
    if (row == null) {
      return null;
    }

    return _mapServer(row);
  }

  Future<void> saveServer(MediaServerProfile server) {
    final timestamp = server.updatedAt.toUtc();
    return _database
        .into(_database.serverRecords)
        .insertOnConflictUpdate(
          ServerRecordsCompanion.insert(
            id: server.id,
            name: server.name,
            baseUrl: server.baseUrl,
            serverType: server.type.name,
            username: Value.absentIfNull(server.username),
            isOnline: Value(server.isOnline),
            createdAt: timestamp,
            updatedAt: timestamp,
          ),
        );
  }

  Future<void> saveSession(MediaServerSession session) async {
    await saveServer(session.server);
    await _secureStorage.write(
      _secureStorage.serverTokenKey(session.server.id),
      session.accessToken,
    );
    await _secureStorage.write(
      _secureStorage.serverUserIdKey(session.server.id),
      session.userId,
    );
  }

  Future<String?> loadActiveServerId() {
    return _preferences.readString(activeServerIdKey);
  }

  Future<void> saveActiveServerId(String? serverId) async {
    if (serverId == null || serverId.isEmpty) {
      await _preferences.delete(activeServerIdKey);
      return;
    }

    await _preferences.writeString(activeServerIdKey, serverId);
  }

  Future<MediaServerSession?> loadSession(MediaServerProfile server) async {
    final token = await _secureStorage.read(
      _secureStorage.serverTokenKey(server.id),
    );
    final userId = await _secureStorage.read(
      _secureStorage.serverUserIdKey(server.id),
    );
    if (token == null || token.isEmpty || userId == null || userId.isEmpty) {
      return null;
    }

    return MediaServerSession(
      server: server,
      accessToken: token,
      userId: userId,
    );
  }

  Future<MediaServerSession?> loadSessionById(String serverId) async {
    final server = await loadServer(serverId);
    if (server == null) {
      return null;
    }

    return loadSession(server);
  }

  Future<void> clearSessionCredentials(String serverId) async {
    await _secureStorage.delete(_secureStorage.serverTokenKey(serverId));
    await _secureStorage.delete(_secureStorage.serverUserIdKey(serverId));
  }

  Future<void> removeServer(String serverId) async {
    await (_database.delete(
      _database.serverRecords,
    )..where((table) => table.id.equals(serverId))).go();
    await clearSessionCredentials(serverId);

    final activeServerId = await loadActiveServerId();
    if (activeServerId == serverId) {
      await saveActiveServerId(null);
    }
  }

  MediaServerProfile _mapServer(ServerRecord row) {
    return MediaServerProfile(
      id: row.id,
      name: row.name,
      baseUrl: row.baseUrl,
      type: _parseServerType(row.serverType),
      username: row.username,
      isOnline: row.isOnline,
      updatedAt: row.updatedAt.toUtc(),
    );
  }

  MediaServerType _parseServerType(String value) {
    for (final type in MediaServerType.values) {
      if (type.name == value) {
        return type;
      }
    }
    return MediaServerType.emby;
  }
}
