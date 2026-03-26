class SyncServerRecord {
  const SyncServerRecord({
    required this.id,
    required this.defaultName,
    required this.type,
    required this.updatedAt,
    required this.deviceId,
  });

  final String id;
  final String defaultName;
  final String type;
  final DateTime updatedAt;
  final String deviceId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'defaultName': defaultName,
      'type': type,
      'updatedAt': updatedAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  factory SyncServerRecord.fromJson(Map<String, dynamic> json) {
    return SyncServerRecord(
      id: json['id'] as String,
      defaultName: (json['defaultName'] ?? json['name']) as String,
      type: json['type'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deviceId: json['deviceId'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncServerRecord &&
          other.id == id &&
          other.defaultName == defaultName &&
          other.type == type &&
          other.updatedAt == updatedAt &&
          other.deviceId == deviceId;

  @override
  int get hashCode => Object.hash(id, defaultName, type, updatedAt, deviceId);
}

class SyncServerLineRecord {
  const SyncServerLineRecord({
    required this.id,
    required this.serverId,
    this.customName,
    required this.baseUrl,
    required this.type,
    this.username,
    required this.updatedAt,
    required this.deviceId,
  });

  final String id;
  final String serverId;
  final String? customName;
  final String baseUrl;
  final String type;
  final String? username;
  final DateTime updatedAt;
  final String deviceId;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serverId': serverId,
      'customName': customName,
      'baseUrl': baseUrl,
      'type': type,
      'username': username,
      'updatedAt': updatedAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  factory SyncServerLineRecord.fromJson(Map<String, dynamic> json) {
    return SyncServerLineRecord(
      id: json['id'] as String,
      serverId: json['serverId'] as String,
      customName: json['customName'] as String?,
      baseUrl: json['baseUrl'] as String,
      type: json['type'] as String,
      username: json['username'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deviceId: json['deviceId'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncServerLineRecord &&
          other.id == id &&
          other.serverId == serverId &&
          other.customName == customName &&
          other.baseUrl == baseUrl &&
          other.type == type &&
          other.username == username &&
          other.updatedAt == updatedAt &&
          other.deviceId == deviceId;

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    customName,
    baseUrl,
    type,
    username,
    updatedAt,
    deviceId,
  );
}

class SyncPreferenceRecord {
  const SyncPreferenceRecord({
    required this.key,
    required this.value,
    required this.updatedAt,
    required this.deviceId,
  });

  final String key;
  final String value;
  final DateTime updatedAt;
  final String deviceId;

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'updatedAt': updatedAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  factory SyncPreferenceRecord.fromJson(Map<String, dynamic> json) {
    return SyncPreferenceRecord(
      key: json['key'] as String,
      value: json['value'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deviceId: json['deviceId'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncPreferenceRecord &&
          other.key == key &&
          other.value == value &&
          other.updatedAt == updatedAt &&
          other.deviceId == deviceId;

  @override
  int get hashCode => Object.hash(key, value, updatedAt, deviceId);
}

class SyncPlaybackStateRecord {
  const SyncPlaybackStateRecord({
    required this.serverId,
    required this.itemId,
    required this.positionSeconds,
    required this.durationSeconds,
    required this.updatedAt,
    required this.deviceId,
  });

  final String serverId;
  final String itemId;
  final int positionSeconds;
  final int durationSeconds;
  final DateTime updatedAt;
  final String deviceId;

  Map<String, dynamic> toJson() {
    return {
      'serverId': serverId,
      'itemId': itemId,
      'positionSeconds': positionSeconds,
      'durationSeconds': durationSeconds,
      'updatedAt': updatedAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  factory SyncPlaybackStateRecord.fromJson(Map<String, dynamic> json) {
    return SyncPlaybackStateRecord(
      serverId: json['serverId'] as String,
      itemId: json['itemId'] as String,
      positionSeconds: json['positionSeconds'] as int,
      durationSeconds: json['durationSeconds'] as int,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deviceId: json['deviceId'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncPlaybackStateRecord &&
          other.serverId == serverId &&
          other.itemId == itemId &&
          other.positionSeconds == positionSeconds &&
          other.durationSeconds == durationSeconds &&
          other.updatedAt == updatedAt &&
          other.deviceId == deviceId;

  @override
  int get hashCode => Object.hash(
    serverId,
    itemId,
    positionSeconds,
    durationSeconds,
    updatedAt,
    deviceId,
  );
}

class SyncCollectionRecord {
  const SyncCollectionRecord({
    required this.serverId,
    required this.itemId,
    required this.kind,
    required this.updatedAt,
    required this.deviceId,
  });

  final String serverId;
  final String itemId;
  final String kind;
  final DateTime updatedAt;
  final String deviceId;

  Map<String, dynamic> toJson() {
    return {
      'serverId': serverId,
      'itemId': itemId,
      'kind': kind,
      'updatedAt': updatedAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  factory SyncCollectionRecord.fromJson(Map<String, dynamic> json) {
    return SyncCollectionRecord(
      serverId: json['serverId'] as String,
      itemId: json['itemId'] as String,
      kind: json['kind'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deviceId: json['deviceId'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncCollectionRecord &&
          other.serverId == serverId &&
          other.itemId == itemId &&
          other.kind == kind &&
          other.updatedAt == updatedAt &&
          other.deviceId == deviceId;

  @override
  int get hashCode => Object.hash(serverId, itemId, kind, updatedAt, deviceId);
}

class SyncWatchHistoryRecord {
  const SyncWatchHistoryRecord({
    required this.serverId,
    required this.itemId,
    required this.watchedAt,
    required this.updatedAt,
    required this.deviceId,
  });

  final String serverId;
  final String itemId;
  final DateTime watchedAt;
  final DateTime updatedAt;
  final String deviceId;

  Map<String, dynamic> toJson() {
    return {
      'serverId': serverId,
      'itemId': itemId,
      'watchedAt': watchedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  factory SyncWatchHistoryRecord.fromJson(Map<String, dynamic> json) {
    return SyncWatchHistoryRecord(
      serverId: json['serverId'] as String,
      itemId: json['itemId'] as String,
      watchedAt: DateTime.parse(json['watchedAt'] as String).toUtc(),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      deviceId: json['deviceId'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncWatchHistoryRecord &&
          other.serverId == serverId &&
          other.itemId == itemId &&
          other.watchedAt == watchedAt &&
          other.updatedAt == updatedAt &&
          other.deviceId == deviceId;

  @override
  int get hashCode =>
      Object.hash(serverId, itemId, watchedAt, updatedAt, deviceId);
}

class SyncSnapshotV1 {
  const SyncSnapshotV1({
    this.schemaVersion = 'v1',
    required this.deviceId,
    required this.updatedAt,
    this.servers = const <SyncServerRecord>[],
    this.serverLines = const <SyncServerLineRecord>[],
    this.preferences = const <SyncPreferenceRecord>[],
    this.playbackStates = const <SyncPlaybackStateRecord>[],
    this.collections = const <SyncCollectionRecord>[],
    this.watchHistory = const <SyncWatchHistoryRecord>[],
  });

  final String schemaVersion;
  final String deviceId;
  final DateTime updatedAt;
  final List<SyncServerRecord> servers;
  final List<SyncServerLineRecord> serverLines;
  final List<SyncPreferenceRecord> preferences;
  final List<SyncPlaybackStateRecord> playbackStates;
  final List<SyncCollectionRecord> collections;
  final List<SyncWatchHistoryRecord> watchHistory;

  Map<String, dynamic> toJson() {
    return {
      'schemaVersion': schemaVersion,
      'deviceId': deviceId,
      'updatedAt': updatedAt.toIso8601String(),
      'servers': servers.map((item) => item.toJson()).toList(growable: false),
      'serverLines': serverLines
          .map((item) => item.toJson())
          .toList(growable: false),
      'preferences': preferences
          .map((item) => item.toJson())
          .toList(growable: false),
      'playbackStates': playbackStates
          .map((item) => item.toJson())
          .toList(growable: false),
      'collections': collections
          .map((item) => item.toJson())
          .toList(growable: false),
      'watchHistory': watchHistory
          .map((item) => item.toJson())
          .toList(growable: false),
    };
  }

  factory SyncSnapshotV1.fromJson(Map<String, dynamic> json) {
    List<T> mapList<T>(
      String key,
      T Function(Map<String, dynamic>) fromJson,
    ) {
      final rawList = json[key] as List<dynamic>? ?? const [];
      return rawList
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(growable: false);
    }

    return SyncSnapshotV1(
      schemaVersion: json['schemaVersion'] as String? ?? 'v1',
      deviceId: json['deviceId'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
      servers: mapList('servers', SyncServerRecord.fromJson),
      serverLines: mapList('serverLines', SyncServerLineRecord.fromJson),
      preferences: mapList('preferences', SyncPreferenceRecord.fromJson),
      playbackStates: mapList(
        'playbackStates',
        SyncPlaybackStateRecord.fromJson,
      ),
      collections: mapList('collections', SyncCollectionRecord.fromJson),
      watchHistory: mapList('watchHistory', SyncWatchHistoryRecord.fromJson),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncSnapshotV1 &&
          other.schemaVersion == schemaVersion &&
          other.deviceId == deviceId &&
          other.updatedAt == updatedAt &&
          _listEquals(other.servers, servers) &&
          _listEquals(other.serverLines, serverLines) &&
          _listEquals(other.preferences, preferences) &&
          _listEquals(other.playbackStates, playbackStates) &&
          _listEquals(other.collections, collections) &&
          _listEquals(other.watchHistory, watchHistory);

  @override
  int get hashCode => Object.hash(
    schemaVersion,
    deviceId,
    updatedAt,
    Object.hashAll(servers),
    Object.hashAll(serverLines),
    Object.hashAll(preferences),
    Object.hashAll(playbackStates),
    Object.hashAll(collections),
    Object.hashAll(watchHistory),
  );
}

bool _listEquals<T>(List<T> left, List<T> right) {
  if (left.length != right.length) {
    return false;
  }
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) {
      return false;
    }
  }
  return true;
}
