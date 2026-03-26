import 'package:flumby/features/sync/domain/sync_snapshot_v1.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'sync snapshot serializes migratable state without sensitive fields',
    () {
      final snapshot = SyncSnapshotV1(
        deviceId: 'desktop-a',
        updatedAt: DateTime.utc(2026, 3, 25, 10),
        servers: [
          SyncServerRecord(
            id: 'emby-main',
            defaultName: 'Living Room Emby',
            type: 'emby',
            updatedAt: DateTime.utc(2026, 3, 25, 10),
            deviceId: 'desktop-a',
          ),
        ],
        serverLines: [
          SyncServerLineRecord(
            id: 'emby-main::https://emby.local',
            serverId: 'emby-main',
            customName: '内网',
            baseUrl: 'https://emby.local',
            type: 'emby',
            username: 'ender',
            updatedAt: DateTime.utc(2026, 3, 25, 10),
            deviceId: 'desktop-a',
          ),
        ],
        preferences: [
          SyncPreferenceRecord(
            key: 'player.subtitleLanguage',
            value: 'eng',
            updatedAt: DateTime.utc(2026, 3, 25, 9),
            deviceId: 'desktop-a',
          ),
        ],
      );

      final json = snapshot.toJson();
      final encodedServer =
          (json['servers']! as List<dynamic>).single as Map<String, dynamic>;

      expect(json['schemaVersion'], 'v1');
      expect(encodedServer.containsKey('accessToken'), isFalse);
      expect(encodedServer.containsKey('token'), isFalse);
      expect(SyncSnapshotV1.fromJson(json), snapshot);
    },
  );
}
