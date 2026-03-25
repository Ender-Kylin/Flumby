import 'package:flumby/features/sync/application/snapshot_merge_service.dart';
import 'package:flumby/features/sync/domain/sync_snapshot_v1.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('latest record wins during snapshot merge', () {
    const deviceId = 'desktop-a';
    final service = SnapshotMergeService();

    final local = SyncSnapshotV1(
      deviceId: deviceId,
      updatedAt: DateTime.utc(2026, 3, 24, 10),
      servers: [
        SyncServerRecord(
          id: 'emby-main',
          name: 'Living Room Emby',
          baseUrl: 'https://emby.local',
          type: 'emby',
          username: 'ender',
          updatedAt: DateTime.utc(2026, 3, 24, 9),
          deviceId: deviceId,
        ),
      ],
      preferences: [
        SyncPreferenceRecord(
          key: 'player.audioLanguage',
          value: 'jpn',
          updatedAt: DateTime.utc(2026, 3, 24, 11),
          deviceId: deviceId,
        ),
      ],
      playbackStates: [
        SyncPlaybackStateRecord(
          serverId: 'emby-main',
          itemId: 'dune-part-two',
          positionSeconds: 1200,
          durationSeconds: 9960,
          updatedAt: DateTime.utc(2026, 3, 24, 8),
          deviceId: deviceId,
        ),
      ],
    );

    final remote = SyncSnapshotV1(
      deviceId: 'laptop-b',
      updatedAt: DateTime.utc(2026, 3, 25, 9),
      servers: [
        SyncServerRecord(
          id: 'emby-main',
          name: 'Media Room Emby',
          baseUrl: 'https://emby.local',
          type: 'emby',
          username: 'ender',
          updatedAt: DateTime.utc(2026, 3, 25, 8),
          deviceId: 'laptop-b',
        ),
      ],
      preferences: [
        SyncPreferenceRecord(
          key: 'player.audioLanguage',
          value: 'eng',
          updatedAt: DateTime.utc(2026, 3, 24, 7),
          deviceId: 'laptop-b',
        ),
      ],
      playbackStates: [
        SyncPlaybackStateRecord(
          serverId: 'emby-main',
          itemId: 'dune-part-two',
          positionSeconds: 2440,
          durationSeconds: 9960,
          updatedAt: DateTime.utc(2026, 3, 25, 6),
          deviceId: 'laptop-b',
        ),
      ],
    );

    final merged = service.merge(
      local: local,
      remote: remote,
      deviceId: deviceId,
    );

    expect(merged.deviceId, deviceId);
    expect(merged.updatedAt, DateTime.utc(2026, 3, 25, 9));
    expect(merged.servers.single.name, 'Media Room Emby');
    expect(merged.preferences.single.value, 'jpn');
    expect(merged.playbackStates.single.positionSeconds, 2440);
  });
}
