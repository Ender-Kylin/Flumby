import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(const FlutterSecureStorage());
});

class SecureStorageService {
  const SecureStorageService(this._storage);

  static const serverTokenPrefix = 'server.token.';
  static const serverUserIdPrefix = 'server.user_id.';
  static const serverUsernamePrefix = 'server.username.';
  static const serverPasswordPrefix = 'server.password.';
  static const syncCredentialPrefix = 'sync.credential.';
  static const deviceIdKey = 'device.id';

  final FlutterSecureStorage _storage;

  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }

  Future<String> getOrCreateDeviceId() async {
    final existing = await read(deviceIdKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final random = Random();
    final generated =
        'flumby-${DateTime.now().microsecondsSinceEpoch}-${random.nextInt(1 << 32)}';
    await write(deviceIdKey, generated);
    return generated;
  }

  String serverTokenKey(String serverId) {
    return '$serverTokenPrefix$serverId';
  }

  String serverUserIdKey(String serverId) {
    return '$serverUserIdPrefix$serverId';
  }

  String serverUsernameKey(String serverId) {
    return '$serverUsernamePrefix$serverId';
  }

  String serverPasswordKey(String serverId) {
    return '$serverPasswordPrefix$serverId';
  }
}
