enum MediaServerType { emby, jellyfin }

String buildMediaServerLineId({
  required String serverId,
  required String baseUrl,
}) {
  return '$serverId::$baseUrl';
}

String extractMediaServerIdFromLineId(String lineId) {
  final separatorIndex = lineId.indexOf('::');
  if (separatorIndex == -1) {
    return lineId;
  }
  return lineId.substring(0, separatorIndex);
}

class MediaServerProfile {
  const MediaServerProfile({
    required this.id,
    required this.defaultName,
    required this.type,
    required this.updatedAt,
  });

  final String id;
  final String defaultName;
  final MediaServerType type;
  final DateTime updatedAt;

  MediaServerProfile copyWith({
    String? id,
    String? defaultName,
    MediaServerType? type,
    DateTime? updatedAt,
  }) {
    return MediaServerProfile(
      id: id ?? this.id,
      defaultName: defaultName ?? this.defaultName,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'defaultName': defaultName,
      'type': type.name,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MediaServerProfile.fromJson(Map<String, dynamic> json) {
    return MediaServerProfile(
      id: json['id'] as String,
      defaultName: (json['defaultName'] ?? json['name']) as String,
      type: MediaServerType.values.byName(json['type'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MediaServerProfile &&
            other.id == id &&
            other.defaultName == defaultName &&
            other.type == type &&
            other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(id, defaultName, type, updatedAt);
}

class MediaServerLine {
  const MediaServerLine({
    required this.id,
    required this.serverId,
    this.customName,
    required this.baseUrl,
    required this.type,
    this.username,
    this.isOnline = false,
    required this.updatedAt,
  });

  final String id;
  final String serverId;
  final String? customName;
  final String baseUrl;
  final MediaServerType type;
  final String? username;
  final bool isOnline;
  final DateTime updatedAt;

  String displayName(String defaultName) {
    final trimmed = customName?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      return trimmed;
    }
    return defaultName;
  }

  MediaServerLine copyWith({
    String? id,
    String? serverId,
    Object? customName = _sentinel,
    String? baseUrl,
    MediaServerType? type,
    Object? username = _sentinel,
    bool? isOnline,
    DateTime? updatedAt,
  }) {
    return MediaServerLine(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      customName: identical(customName, _sentinel)
          ? this.customName
          : customName as String?,
      baseUrl: baseUrl ?? this.baseUrl,
      type: type ?? this.type,
      username: identical(username, _sentinel)
          ? this.username
          : username as String?,
      isOnline: isOnline ?? this.isOnline,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serverId': serverId,
      'customName': customName,
      'baseUrl': baseUrl,
      'type': type.name,
      'username': username,
      'isOnline': isOnline,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MediaServerLine.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    return MediaServerLine(
      id: id,
      serverId:
          (json['serverId'] as String?) ?? extractMediaServerIdFromLineId(id),
      customName: json['customName'] as String?,
      baseUrl: json['baseUrl'] as String,
      type: MediaServerType.values.byName(json['type'] as String),
      username: json['username'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      updatedAt: DateTime.parse(json['updatedAt'] as String).toUtc(),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MediaServerLine &&
            other.id == id &&
            other.serverId == serverId &&
            other.customName == customName &&
            other.baseUrl == baseUrl &&
            other.type == type &&
            other.username == username &&
            other.isOnline == isOnline &&
            other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    customName,
    baseUrl,
    type,
    username,
    isOnline,
    updatedAt,
  );
}

class ServerSignInRequest {
  const ServerSignInRequest({
    required this.baseUrl,
    required this.username,
    required this.password,
    this.customName,
    this.type = MediaServerType.emby,
  });

  final String baseUrl;
  final String username;
  final String password;
  final String? customName;
  final MediaServerType type;

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
      'username': username,
      'password': password,
      'customName': customName,
      'type': type.name,
    };
  }

  factory ServerSignInRequest.fromJson(Map<String, dynamic> json) {
    return ServerSignInRequest(
      baseUrl: json['baseUrl'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      customName: json['customName'] as String?,
      type: json['type'] == null
          ? MediaServerType.emby
          : MediaServerType.values.byName(json['type'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ServerSignInRequest &&
            other.baseUrl == baseUrl &&
            other.username == username &&
            other.password == password &&
            other.customName == customName &&
            other.type == type;
  }

  @override
  int get hashCode => Object.hash(baseUrl, username, password, customName, type);
}

class MediaServerSession {
  const MediaServerSession({
    required this.server,
    required this.line,
    required this.accessToken,
    required this.userId,
  });

  final MediaServerProfile server;
  final MediaServerLine line;
  final String accessToken;
  final String userId;

  Map<String, dynamic> toJson() {
    return {
      'server': server.toJson(),
      'line': line.toJson(),
      'accessToken': accessToken,
      'userId': userId,
    };
  }

  factory MediaServerSession.fromJson(Map<String, dynamic> json) {
    return MediaServerSession(
      server: MediaServerProfile.fromJson(json['server'] as Map<String, dynamic>),
      line: MediaServerLine.fromJson(json['line'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      userId: json['userId'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MediaServerSession &&
            other.server == server &&
            other.line == line &&
            other.accessToken == accessToken &&
            other.userId == userId;
  }

  @override
  int get hashCode => Object.hash(server, line, accessToken, userId);
}

class StoredServerCredentials {
  const StoredServerCredentials({
    required this.serverId,
    required this.username,
    required this.password,
  });

  final String serverId;
  final String username;
  final String password;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StoredServerCredentials &&
            other.serverId == serverId &&
            other.username == username &&
            other.password == password;
  }

  @override
  int get hashCode => Object.hash(serverId, username, password);
}

const Object _sentinel = Object();
