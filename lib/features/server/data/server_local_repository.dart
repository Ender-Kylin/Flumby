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

  static const activeLineIdKey = 'servers.activeLineId';
  static const legacyActiveServerIdKey = 'servers.activeServerId';
  static const lineCustomNamePrefix = 'servers.lineCustomName.';

  final AppDatabase _database;
  final AppPreferencesRepository _preferences;
  final SecureStorageService _secureStorage;

  Future<List<MediaServerProfile>> loadServers() async {
    final rows = await (_database.select(_database.serverRecords)
          ..orderBy([
            (table) => OrderingTerm(
              expression: table.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();

    final grouped = <String, MediaServerProfile>{};
    for (final row in rows) {
      final serverId = extractMediaServerIdFromLineId(row.id);
      final profile = MediaServerProfile(
        id: serverId,
        defaultName: row.name,
        type: _parseServerType(row.serverType),
        updatedAt: row.updatedAt.toUtc(),
      );
      final existing = grouped[serverId];
      if (existing == null || profile.updatedAt.isAfter(existing.updatedAt)) {
        grouped[serverId] = profile;
      }
    }

    final servers = grouped.values.toList(growable: false)
      ..sort((left, right) => right.updatedAt.compareTo(left.updatedAt));
    return servers;
  }

  Future<List<MediaServerLine>> loadServerLines() async {
    final rows = await (_database.select(_database.serverRecords)
          ..orderBy([
            (table) => OrderingTerm(
              expression: table.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
    return Future.wait(rows.map(_mapLine));
  }

  Future<MediaServerProfile?> loadServer(String serverId) async {
    final servers = await loadServers();
    for (final server in servers) {
      if (server.id == serverId) {
        return server;
      }
    }
    return null;
  }

  Future<MediaServerLine?> loadServerLine(String lineId) async {
    final row = await (_database.select(
      _database.serverRecords,
    )..where((table) => table.id.equals(lineId))).getSingleOrNull();
    if (row == null) {
      return null;
    }
    return _mapLine(row);
  }

  Future<List<MediaServerLine>> loadLinesForServer(String serverId) async {
    final lines = await loadServerLines();
    return lines.where((line) => line.serverId == serverId).toList(growable: false);
  }

  Future<void> saveServer(MediaServerProfile server) async {
    final lines = await loadLinesForServer(server.id);
    for (final line in lines) {
      await saveServerLine(line, defaultName: server.defaultName);
    }
  }

  Future<void> saveServerLine(
    MediaServerLine line, {
    String? defaultName,
  }) async {
    final timestamp = line.updatedAt.toUtc();
    final existing = await (_database.select(
      _database.serverRecords,
    )..where((table) => table.id.equals(line.id))).getSingleOrNull();
    final resolvedDefaultName =
        defaultName ?? existing?.name ?? line.customName ?? 'Emby Server';

    await _database
        .into(_database.serverRecords)
        .insertOnConflictUpdate(
          ServerRecordsCompanion.insert(
            id: line.id,
            name: resolvedDefaultName,
            baseUrl: line.baseUrl,
            serverType: line.type.name,
            username: Value.absentIfNull(line.username),
            isOnline: Value(line.isOnline),
            createdAt: timestamp,
            updatedAt: timestamp,
          ),
        );
    await _saveLineCustomName(line.id, line.customName);
  }

  Future<void> saveSession(
    MediaServerSession session, {
    String? password,
  }) async {
    await saveServerLine(session.line, defaultName: session.server.defaultName);
    await _secureStorage.write(
      _secureStorage.serverTokenKey(session.server.id),
      session.accessToken,
    );
    await _secureStorage.write(
      _secureStorage.serverUserIdKey(session.server.id),
      session.userId,
    );
    final username = session.line.username?.trim();
    if (username != null && username.isNotEmpty) {
      await _secureStorage.write(
        _secureStorage.serverUsernameKey(session.server.id),
        username,
      );
    }
    final normalizedPassword = password?.trim();
    if (normalizedPassword != null && normalizedPassword.isNotEmpty) {
      await _secureStorage.write(
        _secureStorage.serverPasswordKey(session.server.id),
        normalizedPassword,
      );
    }
  }

  Future<String?> loadActiveLineId() async {
    final lineId = await _preferences.readString(activeLineIdKey);
    if (lineId != null && lineId.isNotEmpty) {
      return lineId;
    }

    final legacyServerId = await _preferences.readString(legacyActiveServerIdKey);
    if (legacyServerId == null || legacyServerId.isEmpty) {
      return null;
    }

    final lines = await loadLinesForServer(legacyServerId);
    if (lines.isEmpty) {
      return null;
    }
    return lines.first.id;
  }

  Future<void> saveActiveLineId(String? lineId) async {
    if (lineId == null || lineId.isEmpty) {
      await _preferences.delete(activeLineIdKey);
      await _preferences.delete(legacyActiveServerIdKey);
      return;
    }

    await _preferences.writeString(activeLineIdKey, lineId);
    await _preferences.delete(legacyActiveServerIdKey);
  }

  Future<MediaServerSession?> loadSessionForLine(MediaServerLine line) async {
    final server = await loadServer(line.serverId);
    if (server == null) {
      return null;
    }

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
      line: line,
      accessToken: token,
      userId: userId,
    );
  }

  Future<MediaServerSession?> loadSessionByLineId(String lineId) async {
    final line = await loadServerLine(lineId);
    if (line == null) {
      return null;
    }

    return loadSessionForLine(line);
  }

  Future<bool> hasSessionForLine(String lineId) async {
    return (await loadSessionByLineId(lineId)) != null;
  }

  Future<StoredServerCredentials?> loadServerCredentials(String serverId) async {
    final username = await _secureStorage.read(
      _secureStorage.serverUsernameKey(serverId),
    );
    final password = await _secureStorage.read(
      _secureStorage.serverPasswordKey(serverId),
    );
    if (username == null ||
        username.isEmpty ||
        password == null ||
        password.isEmpty) {
      return null;
    }
    return StoredServerCredentials(
      serverId: serverId,
      username: username,
      password: password,
    );
  }

  Future<MediaServerSession?> loadAnySessionForServer(String serverId) async {
    final lines = await loadLinesForServer(serverId);
    for (final line in lines) {
      final session = await loadSessionForLine(line);
      if (session != null) {
        return session;
      }
    }
    return null;
  }

  Future<void> clearSessionCredentials(String lineId) async {
    final line = await loadServerLine(lineId);
    final serverId = line?.serverId ?? extractMediaServerIdFromLineId(lineId);
    await _secureStorage.delete(_secureStorage.serverTokenKey(serverId));
    await _secureStorage.delete(_secureStorage.serverUserIdKey(serverId));
    await _secureStorage.delete(_secureStorage.serverUsernameKey(serverId));
    await _secureStorage.delete(_secureStorage.serverPasswordKey(serverId));
  }

  Future<void> removeServerLine(String lineId) async {
    final line = await loadServerLine(lineId);
    final serverId = line?.serverId ?? extractMediaServerIdFromLineId(lineId);
    final lines = await loadLinesForServer(serverId);

    await (_database.delete(
      _database.serverRecords,
    )..where((table) => table.id.equals(lineId))).go();
    await _deleteLineCustomName(lineId);
    if (lines.length <= 1) {
      await clearSessionCredentials(lineId);
    }

    final activeLineId = await loadActiveLineId();
    if (activeLineId == lineId) {
      await saveActiveLineId(null);
    }
  }

  Future<void> removeServer(String serverId) async {
    final lines = await loadLinesForServer(serverId);
    for (final line in lines) {
      await _deleteLineCustomName(line.id);
    }
    await (_database.delete(
      _database.serverRecords,
    )..where((table) => table.id.like('$serverId::%'))).go();
    await _secureStorage.delete(_secureStorage.serverTokenKey(serverId));
    await _secureStorage.delete(_secureStorage.serverUserIdKey(serverId));
    await _secureStorage.delete(_secureStorage.serverUsernameKey(serverId));
    await _secureStorage.delete(_secureStorage.serverPasswordKey(serverId));

    final activeLineId = await loadActiveLineId();
    if (activeLineId != null && lines.any((line) => line.id == activeLineId)) {
      await saveActiveLineId(null);
    }
  }

  Future<MediaServerLine> _mapLine(ServerRecord row) async {
    final customName = await _preferences.readString(_lineCustomNameKey(row.id));
    return MediaServerLine(
      id: row.id,
      serverId: extractMediaServerIdFromLineId(row.id),
      customName: _normalizeCustomName(customName),
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

  String? _normalizeCustomName(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  Future<void> _saveLineCustomName(String lineId, String? value) async {
    final normalized = _normalizeCustomName(value);
    if (normalized == null) {
      await _deleteLineCustomName(lineId);
      return;
    }
    await _preferences.writeString(_lineCustomNameKey(lineId), normalized);
  }

  Future<void> _deleteLineCustomName(String lineId) {
    return _preferences.delete(_lineCustomNameKey(lineId));
  }

  String _lineCustomNameKey(String lineId) {
    return '$lineCustomNamePrefix$lineId';
  }
}
