import 'package:drift/native.dart';
import 'package:flumby/core/database/app_database.dart';
import 'package:flumby/core/storage/app_preferences_repository.dart';
import 'package:flumby/core/storage/secure_storage_service.dart';
import 'package:flumby/features/server/data/server_local_repository.dart';
import 'package:flumby/features/server/domain/server_models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'saveSession persists server metadata in the database and credentials in secure storage',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      final secureStorage = _FakeSecureStorageService();
      final preferences = AppPreferencesRepository(database, secureStorage);
      final repository = ServerLocalRepository(
        database,
        preferences,
        secureStorage,
      );
      final session = _testSession();

      addTearDown(database.close);

      await repository.saveSession(session, password: 'secret-123');
      await repository.saveActiveLineId(session.line.id);

      final storedServers = await repository.loadServers();
      final storedLines = await repository.loadServerLines();
      final storedSession = await repository.loadSessionByLineId(session.line.id);

      expect(storedServers, hasLength(1));
      expect(storedServers.single.defaultName, 'Office TV');
      expect(storedLines, hasLength(1));
      expect(storedLines.single.customName, '内网');
      expect(storedLines.single.baseUrl, 'https://media.example.com');
      expect(
        await secureStorage.read(
          secureStorage.serverTokenKey(session.server.id),
        ),
        'token-123',
      );
      expect(
        await secureStorage.read(
          secureStorage.serverUserIdKey(session.server.id),
        ),
        'user-123',
      );
      expect(
        await secureStorage.read(
          secureStorage.serverUsernameKey(session.server.id),
        ),
        'alice',
      );
      expect(
        await secureStorage.read(
          secureStorage.serverPasswordKey(session.server.id),
        ),
        'secret-123',
      );
      expect(storedSession, session);
      expect(
        await repository.loadServerCredentials(session.server.id),
        const StoredServerCredentials(
          serverId: 'emby-1',
          username: 'alice',
          password: 'secret-123',
        ),
      );
      expect(await repository.loadActiveLineId(), session.line.id);

      await repository.clearSessionCredentials(session.line.id);

      expect(await repository.loadSessionByLineId(session.line.id), isNull);
      expect(await repository.loadServers(), hasLength(1));
    },
  );

  test('additional lines reuse the same shared server credentials', () async {
    final database = AppDatabase(NativeDatabase.memory());
    final secureStorage = _FakeSecureStorageService();
    final preferences = AppPreferencesRepository(database, secureStorage);
    final repository = ServerLocalRepository(
      database,
      preferences,
      secureStorage,
    );
    final session = _testSession();
    final backupLine = MediaServerLine(
      id: buildMediaServerLineId(
        serverId: session.server.id,
        baseUrl: 'https://backup.example.com',
      ),
      serverId: session.server.id,
      customName: '外网',
      baseUrl: 'https://backup.example.com',
      type: MediaServerType.emby,
      username: session.line.username,
      isOnline: true,
      updatedAt: DateTime.utc(2026, 3, 25, 9),
    );

    addTearDown(database.close);

    await repository.saveSession(session, password: 'secret-123');
    await repository.saveServerLine(
      backupLine,
      defaultName: session.server.defaultName,
    );

    final backupSession = await repository.loadSessionByLineId(backupLine.id);

    expect(backupSession, isNotNull);
    expect(backupSession!.accessToken, session.accessToken);
    expect(backupSession.userId, session.userId);
    expect(backupSession.line, backupLine);
    expect(
      await secureStorage.read(
        secureStorage.serverTokenKey(session.server.id),
      ),
      'token-123',
    );
    expect(
      await repository.loadServerCredentials(session.server.id),
      const StoredServerCredentials(
        serverId: 'emby-1',
        username: 'alice',
        password: 'secret-123',
      ),
    );
  });
}

MediaServerSession _testSession() {
  return MediaServerSession(
    server: MediaServerProfile(
      id: 'emby-1',
      defaultName: 'Office TV',
      type: MediaServerType.emby,
      updatedAt: DateTime.utc(2026, 3, 25, 8),
    ),
    line: MediaServerLine(
      id: buildMediaServerLineId(
        serverId: 'emby-1',
        baseUrl: 'https://media.example.com',
      ),
      serverId: 'emby-1',
      customName: '内网',
      baseUrl: 'https://media.example.com',
      type: MediaServerType.emby,
      username: 'alice',
      isOnline: true,
      updatedAt: DateTime.utc(2026, 3, 25, 8),
    ),
    accessToken: 'token-123',
    userId: 'user-123',
  );
}

class _FakeSecureStorageService extends SecureStorageService {
  _FakeSecureStorageService() : super(const FlutterSecureStorage());

  final Map<String, String> _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }
}
