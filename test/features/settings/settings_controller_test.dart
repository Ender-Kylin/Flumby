import 'package:drift/native.dart';
import 'package:flumby/core/database/app_database.dart';
import 'package:flumby/core/storage/app_preferences_repository.dart';
import 'package:flumby/core/storage/secure_storage_service.dart';
import 'package:flumby/features/settings/application/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('settings persist and hydrate across provider containers', () async {
    final database = AppDatabase(NativeDatabase.memory());
    final secureStorage = _FakeSecureStorageService();
    final preferences = AppPreferencesRepository(database, secureStorage);

    addTearDown(database.close);

    final writerContainer = ProviderContainer(
      overrides: [
        appPreferencesRepositoryProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(writerContainer.dispose);

    await writerContainer
        .read(settingsControllerProvider.notifier)
        .setGitSyncEnabled(true);
    await writerContainer
        .read(settingsControllerProvider.notifier)
        .setHardwareDecoding('no');
    await writerContainer
        .read(settingsControllerProvider.notifier)
        .setSubtitleLanguage('chi');
    await writerContainer
        .read(settingsControllerProvider.notifier)
        .setOpenInSeparateWindow(false);
    await writerContainer
        .read(settingsControllerProvider.notifier)
        .setHideMainWindowDuringExternalPlayback(false);

    final readerContainer = ProviderContainer(
      overrides: [
        appPreferencesRepositoryProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(readerContainer.dispose);

    SettingsState state = readerContainer.read(settingsControllerProvider);
    while (!state.isHydrated) {
      await Future<void>.delayed(Duration.zero);
      state = readerContainer.read(settingsControllerProvider);
    }

    expect(state.gitSyncEnabled, isTrue);
    expect(state.hardwareDecoding, 'no');
    expect(state.subtitleLanguage, 'chi');
    expect(state.openInSeparateWindow, isFalse);
    expect(state.hideMainWindowDuringExternalPlayback, isFalse);
  });
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
