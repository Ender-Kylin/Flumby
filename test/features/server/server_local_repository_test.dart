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
      final session = MediaServerSession(
        server: MediaServerProfile(
          id: 'emby-1',
          name: 'Office TV',
          baseUrl: 'https://media.example.com',
          type: MediaServerType.emby,
          username: 'alice',
          isOnline: true,
          updatedAt: DateTime.utc(2026, 3, 25, 8),
        ),
        accessToken: 'token-123',
        userId: 'user-123',
      );

      addTearDown(database.close);

      await repository.saveSession(session);
      await repository.saveActiveServerId(session.server.id);

      final storedServers = await repository.loadServers();
      final storedSession = await repository.loadSessionById(session.server.id);

      expect(storedServers, hasLength(1));
      expect(storedServers.single.name, 'Office TV');
      expect(storedServers.single.baseUrl, 'https://media.example.com');
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
      expect(storedSession, session);
      expect(await repository.loadActiveServerId(), session.server.id);

      await repository.clearSessionCredentials(session.server.id);

      expect(await repository.loadSessionById(session.server.id), isNull);
      expect(await repository.loadServers(), hasLength(1));
    },
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
