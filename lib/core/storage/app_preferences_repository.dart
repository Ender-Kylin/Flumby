import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import 'secure_storage_service.dart';

final appPreferencesRepositoryProvider = Provider<AppPreferencesRepository>((
  ref,
) {
  return AppPreferencesRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(secureStorageProvider),
  );
});

class AppPreferencesRepository {
  const AppPreferencesRepository(this._database, this._secureStorage);

  final AppDatabase _database;
  final SecureStorageService _secureStorage;

  Future<String?> readString(String key) async {
    final record = await (_database.select(
      _database.preferenceRecords,
    )..where((table) => table.key.equals(key))).getSingleOrNull();
    return record?.value;
  }

  Future<bool?> readBool(String key) async {
    final value = await readString(key);
    if (value == null) {
      return null;
    }

    return value.toLowerCase() == 'true';
  }

  Future<void> writeString(String key, String value) async {
    final deviceId = await _secureStorage.getOrCreateDeviceId();
    await _database
        .into(_database.preferenceRecords)
        .insertOnConflictUpdate(
          PreferenceRecordsCompanion.insert(
            key: key,
            value: value,
            deviceId: deviceId,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> writeBool(String key, bool value) {
    return writeString(key, value.toString());
  }

  Future<void> delete(String key) async {
    await (_database.delete(
      _database.preferenceRecords,
    )..where((table) => table.key.equals(key))).go();
  }
}
