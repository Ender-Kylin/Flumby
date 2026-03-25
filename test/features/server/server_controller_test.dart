import 'package:drift/native.dart';
import 'package:flumby/core/database/app_database.dart';
import 'package:flumby/core/storage/app_preferences_repository.dart';
import 'package:flumby/core/storage/secure_storage_service.dart';
import 'package:flumby/features/server/application/server_controller.dart';
import 'package:flumby/features/server/domain/server_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'serverSessionProvider resolves after saveSession without circular dependency',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      final secureStorage = _FakeSecureStorageService();
      final preferences = AppPreferencesRepository(database, secureStorage);
      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          secureStorageProvider.overrideWithValue(secureStorage),
          appPreferencesRepositoryProvider.overrideWithValue(preferences),
        ],
      );

      addTearDown(() async {
        container.dispose();
        await database.close();
      });

      final sessionProvider = serverSessionProvider('emby-1');
      final subscription = container.listen<AsyncValue<MediaServerSession?>>(
        sessionProvider,
        (previous, next) {},
      );
      addTearDown(subscription.close);

      expect(
        container.read(sessionProvider),
        isA<AsyncLoading<MediaServerSession?>>(),
      );

      final session = MediaServerSession(
        server: MediaServerProfile(
          id: 'emby-1',
          name: 'Office TV',
          baseUrl: 'https://tv.micu.hk',
          type: MediaServerType.emby,
          username: 'EnderKylin',
          isOnline: true,
          updatedAt: DateTime.utc(2026, 3, 25, 20, 30),
        ),
        accessToken: 'token-123',
        userId: 'user-123',
      );

      await container
          .read(serverControllerProvider.notifier)
          .saveSession(session);
      await Future<void>.delayed(Duration.zero);

      expect(await container.read(sessionProvider.future), session);
      expect(container.read(activeServerProvider)?.id, session.server.id);
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
