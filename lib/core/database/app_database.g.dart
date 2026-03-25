// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ServerRecordsTable extends ServerRecords
    with TableInfo<$ServerRecordsTable, ServerRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverTypeMeta = const VerificationMeta(
    'serverType',
  );
  @override
  late final GeneratedColumn<String> serverType = GeneratedColumn<String>(
    'server_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOnlineMeta = const VerificationMeta(
    'isOnline',
  );
  @override
  late final GeneratedColumn<bool> isOnline = GeneratedColumn<bool>(
    'is_online',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_online" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    baseUrl,
    serverType,
    username,
    isOnline,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'server_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServerRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('server_type')) {
      context.handle(
        _serverTypeMeta,
        serverType.isAcceptableOrUnknown(data['server_type']!, _serverTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_serverTypeMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('is_online')) {
      context.handle(
        _isOnlineMeta,
        isOnline.isAcceptableOrUnknown(data['is_online']!, _isOnlineMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      serverType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_type'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      isOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_online'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ServerRecordsTable createAlias(String alias) {
    return $ServerRecordsTable(attachedDatabase, alias);
  }
}

class ServerRecord extends DataClass implements Insertable<ServerRecord> {
  final String id;
  final String name;
  final String baseUrl;
  final String serverType;
  final String? username;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ServerRecord({
    required this.id,
    required this.name,
    required this.baseUrl,
    required this.serverType,
    this.username,
    required this.isOnline,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['base_url'] = Variable<String>(baseUrl);
    map['server_type'] = Variable<String>(serverType);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['is_online'] = Variable<bool>(isOnline);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ServerRecordsCompanion toCompanion(bool nullToAbsent) {
    return ServerRecordsCompanion(
      id: Value(id),
      name: Value(name),
      baseUrl: Value(baseUrl),
      serverType: Value(serverType),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      isOnline: Value(isOnline),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ServerRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerRecord(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      serverType: serializer.fromJson<String>(json['serverType']),
      username: serializer.fromJson<String?>(json['username']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'serverType': serializer.toJson<String>(serverType),
      'username': serializer.toJson<String?>(username),
      'isOnline': serializer.toJson<bool>(isOnline),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ServerRecord copyWith({
    String? id,
    String? name,
    String? baseUrl,
    String? serverType,
    Value<String?> username = const Value.absent(),
    bool? isOnline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ServerRecord(
    id: id ?? this.id,
    name: name ?? this.name,
    baseUrl: baseUrl ?? this.baseUrl,
    serverType: serverType ?? this.serverType,
    username: username.present ? username.value : this.username,
    isOnline: isOnline ?? this.isOnline,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ServerRecord copyWithCompanion(ServerRecordsCompanion data) {
    return ServerRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      serverType: data.serverType.present
          ? data.serverType.value
          : this.serverType,
      username: data.username.present ? data.username.value : this.username,
      isOnline: data.isOnline.present ? data.isOnline.value : this.isOnline,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServerRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('serverType: $serverType, ')
          ..write('username: $username, ')
          ..write('isOnline: $isOnline, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    baseUrl,
    serverType,
    username,
    isOnline,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.baseUrl == this.baseUrl &&
          other.serverType == this.serverType &&
          other.username == this.username &&
          other.isOnline == this.isOnline &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ServerRecordsCompanion extends UpdateCompanion<ServerRecord> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> baseUrl;
  final Value<String> serverType;
  final Value<String?> username;
  final Value<bool> isOnline;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ServerRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.serverType = const Value.absent(),
    this.username = const Value.absent(),
    this.isOnline = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServerRecordsCompanion.insert({
    required String id,
    required String name,
    required String baseUrl,
    required String serverType,
    this.username = const Value.absent(),
    this.isOnline = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       baseUrl = Value(baseUrl),
       serverType = Value(serverType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ServerRecord> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? baseUrl,
    Expression<String>? serverType,
    Expression<String>? username,
    Expression<bool>? isOnline,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (baseUrl != null) 'base_url': baseUrl,
      if (serverType != null) 'server_type': serverType,
      if (username != null) 'username': username,
      if (isOnline != null) 'is_online': isOnline,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServerRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? baseUrl,
    Value<String>? serverType,
    Value<String?>? username,
    Value<bool>? isOnline,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ServerRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      serverType: serverType ?? this.serverType,
      username: username ?? this.username,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (serverType.present) {
      map['server_type'] = Variable<String>(serverType.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('serverType: $serverType, ')
          ..write('username: $username, ')
          ..write('isOnline: $isOnline, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaybackStateRecordsTable extends PlaybackStateRecords
    with TableInfo<$PlaybackStateRecordsTable, PlaybackStateRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaybackStateRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionSecondsMeta = const VerificationMeta(
    'positionSeconds',
  );
  @override
  late final GeneratedColumn<int> positionSeconds = GeneratedColumn<int>(
    'position_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    itemId,
    positionSeconds,
    durationSeconds,
    deviceId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playback_state_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaybackStateRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('position_seconds')) {
      context.handle(
        _positionSecondsMeta,
        positionSeconds.isAcceptableOrUnknown(
          data['position_seconds']!,
          _positionSecondsMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId, itemId};
  @override
  PlaybackStateRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaybackStateRecord(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      positionSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position_seconds'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PlaybackStateRecordsTable createAlias(String alias) {
    return $PlaybackStateRecordsTable(attachedDatabase, alias);
  }
}

class PlaybackStateRecord extends DataClass
    implements Insertable<PlaybackStateRecord> {
  final String serverId;
  final String itemId;
  final int positionSeconds;
  final int durationSeconds;
  final String deviceId;
  final DateTime updatedAt;
  const PlaybackStateRecord({
    required this.serverId,
    required this.itemId,
    required this.positionSeconds,
    required this.durationSeconds,
    required this.deviceId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<String>(serverId);
    map['item_id'] = Variable<String>(itemId);
    map['position_seconds'] = Variable<int>(positionSeconds);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['device_id'] = Variable<String>(deviceId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlaybackStateRecordsCompanion toCompanion(bool nullToAbsent) {
    return PlaybackStateRecordsCompanion(
      serverId: Value(serverId),
      itemId: Value(itemId),
      positionSeconds: Value(positionSeconds),
      durationSeconds: Value(durationSeconds),
      deviceId: Value(deviceId),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlaybackStateRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaybackStateRecord(
      serverId: serializer.fromJson<String>(json['serverId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      positionSeconds: serializer.fromJson<int>(json['positionSeconds']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<String>(serverId),
      'itemId': serializer.toJson<String>(itemId),
      'positionSeconds': serializer.toJson<int>(positionSeconds),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'deviceId': serializer.toJson<String>(deviceId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlaybackStateRecord copyWith({
    String? serverId,
    String? itemId,
    int? positionSeconds,
    int? durationSeconds,
    String? deviceId,
    DateTime? updatedAt,
  }) => PlaybackStateRecord(
    serverId: serverId ?? this.serverId,
    itemId: itemId ?? this.itemId,
    positionSeconds: positionSeconds ?? this.positionSeconds,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    deviceId: deviceId ?? this.deviceId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PlaybackStateRecord copyWithCompanion(PlaybackStateRecordsCompanion data) {
    return PlaybackStateRecord(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      positionSeconds: data.positionSeconds.present
          ? data.positionSeconds.value
          : this.positionSeconds,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackStateRecord(')
          ..write('serverId: $serverId, ')
          ..write('itemId: $itemId, ')
          ..write('positionSeconds: $positionSeconds, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    serverId,
    itemId,
    positionSeconds,
    durationSeconds,
    deviceId,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaybackStateRecord &&
          other.serverId == this.serverId &&
          other.itemId == this.itemId &&
          other.positionSeconds == this.positionSeconds &&
          other.durationSeconds == this.durationSeconds &&
          other.deviceId == this.deviceId &&
          other.updatedAt == this.updatedAt);
}

class PlaybackStateRecordsCompanion
    extends UpdateCompanion<PlaybackStateRecord> {
  final Value<String> serverId;
  final Value<String> itemId;
  final Value<int> positionSeconds;
  final Value<int> durationSeconds;
  final Value<String> deviceId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PlaybackStateRecordsCompanion({
    this.serverId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.positionSeconds = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaybackStateRecordsCompanion.insert({
    required String serverId,
    required String itemId,
    this.positionSeconds = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    required String deviceId,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : serverId = Value(serverId),
       itemId = Value(itemId),
       deviceId = Value(deviceId),
       updatedAt = Value(updatedAt);
  static Insertable<PlaybackStateRecord> custom({
    Expression<String>? serverId,
    Expression<String>? itemId,
    Expression<int>? positionSeconds,
    Expression<int>? durationSeconds,
    Expression<String>? deviceId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (itemId != null) 'item_id': itemId,
      if (positionSeconds != null) 'position_seconds': positionSeconds,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (deviceId != null) 'device_id': deviceId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaybackStateRecordsCompanion copyWith({
    Value<String>? serverId,
    Value<String>? itemId,
    Value<int>? positionSeconds,
    Value<int>? durationSeconds,
    Value<String>? deviceId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PlaybackStateRecordsCompanion(
      serverId: serverId ?? this.serverId,
      itemId: itemId ?? this.itemId,
      positionSeconds: positionSeconds ?? this.positionSeconds,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      deviceId: deviceId ?? this.deviceId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (positionSeconds.present) {
      map['position_seconds'] = Variable<int>(positionSeconds.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackStateRecordsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('itemId: $itemId, ')
          ..write('positionSeconds: $positionSeconds, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WatchHistoryRecordsTable extends WatchHistoryRecords
    with TableInfo<$WatchHistoryRecordsTable, WatchHistoryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchHistoryRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _watchedAtMeta = const VerificationMeta(
    'watchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> watchedAt = GeneratedColumn<DateTime>(
    'watched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    itemId,
    watchedAt,
    deviceId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'watch_history_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<WatchHistoryRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('watched_at')) {
      context.handle(
        _watchedAtMeta,
        watchedAt.isAcceptableOrUnknown(data['watched_at']!, _watchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_watchedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId, itemId};
  @override
  WatchHistoryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WatchHistoryRecord(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      watchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}watched_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WatchHistoryRecordsTable createAlias(String alias) {
    return $WatchHistoryRecordsTable(attachedDatabase, alias);
  }
}

class WatchHistoryRecord extends DataClass
    implements Insertable<WatchHistoryRecord> {
  final String serverId;
  final String itemId;
  final DateTime watchedAt;
  final String deviceId;
  final DateTime updatedAt;
  const WatchHistoryRecord({
    required this.serverId,
    required this.itemId,
    required this.watchedAt,
    required this.deviceId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<String>(serverId);
    map['item_id'] = Variable<String>(itemId);
    map['watched_at'] = Variable<DateTime>(watchedAt);
    map['device_id'] = Variable<String>(deviceId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WatchHistoryRecordsCompanion toCompanion(bool nullToAbsent) {
    return WatchHistoryRecordsCompanion(
      serverId: Value(serverId),
      itemId: Value(itemId),
      watchedAt: Value(watchedAt),
      deviceId: Value(deviceId),
      updatedAt: Value(updatedAt),
    );
  }

  factory WatchHistoryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchHistoryRecord(
      serverId: serializer.fromJson<String>(json['serverId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      watchedAt: serializer.fromJson<DateTime>(json['watchedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<String>(serverId),
      'itemId': serializer.toJson<String>(itemId),
      'watchedAt': serializer.toJson<DateTime>(watchedAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WatchHistoryRecord copyWith({
    String? serverId,
    String? itemId,
    DateTime? watchedAt,
    String? deviceId,
    DateTime? updatedAt,
  }) => WatchHistoryRecord(
    serverId: serverId ?? this.serverId,
    itemId: itemId ?? this.itemId,
    watchedAt: watchedAt ?? this.watchedAt,
    deviceId: deviceId ?? this.deviceId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WatchHistoryRecord copyWithCompanion(WatchHistoryRecordsCompanion data) {
    return WatchHistoryRecord(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      watchedAt: data.watchedAt.present ? data.watchedAt.value : this.watchedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WatchHistoryRecord(')
          ..write('serverId: $serverId, ')
          ..write('itemId: $itemId, ')
          ..write('watchedAt: $watchedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(serverId, itemId, watchedAt, deviceId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchHistoryRecord &&
          other.serverId == this.serverId &&
          other.itemId == this.itemId &&
          other.watchedAt == this.watchedAt &&
          other.deviceId == this.deviceId &&
          other.updatedAt == this.updatedAt);
}

class WatchHistoryRecordsCompanion extends UpdateCompanion<WatchHistoryRecord> {
  final Value<String> serverId;
  final Value<String> itemId;
  final Value<DateTime> watchedAt;
  final Value<String> deviceId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WatchHistoryRecordsCompanion({
    this.serverId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.watchedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WatchHistoryRecordsCompanion.insert({
    required String serverId,
    required String itemId,
    required DateTime watchedAt,
    required String deviceId,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : serverId = Value(serverId),
       itemId = Value(itemId),
       watchedAt = Value(watchedAt),
       deviceId = Value(deviceId),
       updatedAt = Value(updatedAt);
  static Insertable<WatchHistoryRecord> custom({
    Expression<String>? serverId,
    Expression<String>? itemId,
    Expression<DateTime>? watchedAt,
    Expression<String>? deviceId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (itemId != null) 'item_id': itemId,
      if (watchedAt != null) 'watched_at': watchedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WatchHistoryRecordsCompanion copyWith({
    Value<String>? serverId,
    Value<String>? itemId,
    Value<DateTime>? watchedAt,
    Value<String>? deviceId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WatchHistoryRecordsCompanion(
      serverId: serverId ?? this.serverId,
      itemId: itemId ?? this.itemId,
      watchedAt: watchedAt ?? this.watchedAt,
      deviceId: deviceId ?? this.deviceId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (watchedAt.present) {
      map['watched_at'] = Variable<DateTime>(watchedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchHistoryRecordsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('itemId: $itemId, ')
          ..write('watchedAt: $watchedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionRecordsTable extends CollectionRecords
    with TableInfo<$CollectionRecordsTable, CollectionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    serverId,
    itemId,
    kind,
    deviceId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serverId, itemId, kind};
  @override
  CollectionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionRecord(
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CollectionRecordsTable createAlias(String alias) {
    return $CollectionRecordsTable(attachedDatabase, alias);
  }
}

class CollectionRecord extends DataClass
    implements Insertable<CollectionRecord> {
  final String serverId;
  final String itemId;
  final String kind;
  final String deviceId;
  final DateTime updatedAt;
  const CollectionRecord({
    required this.serverId,
    required this.itemId,
    required this.kind,
    required this.deviceId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['server_id'] = Variable<String>(serverId);
    map['item_id'] = Variable<String>(itemId);
    map['kind'] = Variable<String>(kind);
    map['device_id'] = Variable<String>(deviceId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CollectionRecordsCompanion toCompanion(bool nullToAbsent) {
    return CollectionRecordsCompanion(
      serverId: Value(serverId),
      itemId: Value(itemId),
      kind: Value(kind),
      deviceId: Value(deviceId),
      updatedAt: Value(updatedAt),
    );
  }

  factory CollectionRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionRecord(
      serverId: serializer.fromJson<String>(json['serverId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      kind: serializer.fromJson<String>(json['kind']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serverId': serializer.toJson<String>(serverId),
      'itemId': serializer.toJson<String>(itemId),
      'kind': serializer.toJson<String>(kind),
      'deviceId': serializer.toJson<String>(deviceId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CollectionRecord copyWith({
    String? serverId,
    String? itemId,
    String? kind,
    String? deviceId,
    DateTime? updatedAt,
  }) => CollectionRecord(
    serverId: serverId ?? this.serverId,
    itemId: itemId ?? this.itemId,
    kind: kind ?? this.kind,
    deviceId: deviceId ?? this.deviceId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CollectionRecord copyWithCompanion(CollectionRecordsCompanion data) {
    return CollectionRecord(
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      kind: data.kind.present ? data.kind.value : this.kind,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionRecord(')
          ..write('serverId: $serverId, ')
          ..write('itemId: $itemId, ')
          ..write('kind: $kind, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(serverId, itemId, kind, deviceId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionRecord &&
          other.serverId == this.serverId &&
          other.itemId == this.itemId &&
          other.kind == this.kind &&
          other.deviceId == this.deviceId &&
          other.updatedAt == this.updatedAt);
}

class CollectionRecordsCompanion extends UpdateCompanion<CollectionRecord> {
  final Value<String> serverId;
  final Value<String> itemId;
  final Value<String> kind;
  final Value<String> deviceId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CollectionRecordsCompanion({
    this.serverId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.kind = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionRecordsCompanion.insert({
    required String serverId,
    required String itemId,
    required String kind,
    required String deviceId,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : serverId = Value(serverId),
       itemId = Value(itemId),
       kind = Value(kind),
       deviceId = Value(deviceId),
       updatedAt = Value(updatedAt);
  static Insertable<CollectionRecord> custom({
    Expression<String>? serverId,
    Expression<String>? itemId,
    Expression<String>? kind,
    Expression<String>? deviceId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serverId != null) 'server_id': serverId,
      if (itemId != null) 'item_id': itemId,
      if (kind != null) 'kind': kind,
      if (deviceId != null) 'device_id': deviceId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionRecordsCompanion copyWith({
    Value<String>? serverId,
    Value<String>? itemId,
    Value<String>? kind,
    Value<String>? deviceId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CollectionRecordsCompanion(
      serverId: serverId ?? this.serverId,
      itemId: itemId ?? this.itemId,
      kind: kind ?? this.kind,
      deviceId: deviceId ?? this.deviceId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionRecordsCompanion(')
          ..write('serverId: $serverId, ')
          ..write('itemId: $itemId, ')
          ..write('kind: $kind, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PreferenceRecordsTable extends PreferenceRecords
    with TableInfo<$PreferenceRecordsTable, PreferenceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferenceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, deviceId, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preference_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreferenceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  PreferenceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferenceRecord(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PreferenceRecordsTable createAlias(String alias) {
    return $PreferenceRecordsTable(attachedDatabase, alias);
  }
}

class PreferenceRecord extends DataClass
    implements Insertable<PreferenceRecord> {
  final String key;
  final String value;
  final String deviceId;
  final DateTime updatedAt;
  const PreferenceRecord({
    required this.key,
    required this.value,
    required this.deviceId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['device_id'] = Variable<String>(deviceId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PreferenceRecordsCompanion toCompanion(bool nullToAbsent) {
    return PreferenceRecordsCompanion(
      key: Value(key),
      value: Value(value),
      deviceId: Value(deviceId),
      updatedAt: Value(updatedAt),
    );
  }

  factory PreferenceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenceRecord(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'deviceId': serializer.toJson<String>(deviceId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PreferenceRecord copyWith({
    String? key,
    String? value,
    String? deviceId,
    DateTime? updatedAt,
  }) => PreferenceRecord(
    key: key ?? this.key,
    value: value ?? this.value,
    deviceId: deviceId ?? this.deviceId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PreferenceRecord copyWithCompanion(PreferenceRecordsCompanion data) {
    return PreferenceRecord(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceRecord(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, deviceId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenceRecord &&
          other.key == this.key &&
          other.value == this.value &&
          other.deviceId == this.deviceId &&
          other.updatedAt == this.updatedAt);
}

class PreferenceRecordsCompanion extends UpdateCompanion<PreferenceRecord> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> deviceId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PreferenceRecordsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferenceRecordsCompanion.insert({
    required String key,
    required String value,
    required String deviceId,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       deviceId = Value(deviceId),
       updatedAt = Value(updatedAt);
  static Insertable<PreferenceRecord> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? deviceId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (deviceId != null) 'device_id': deviceId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferenceRecordsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<String>? deviceId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PreferenceRecordsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      deviceId: deviceId ?? this.deviceId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceRecordsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('deviceId: $deviceId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueRecordsTable extends SyncQueueRecords
    with TableInfo<$SyncQueueRecordsTable, SyncQueueRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _queueIdMeta = const VerificationMeta(
    'queueId',
  );
  @override
  late final GeneratedColumn<String> queueId = GeneratedColumn<String>(
    'queue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    queueId,
    entityType,
    entityId,
    payload,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('queue_id')) {
      context.handle(
        _queueIdMeta,
        queueId.isAcceptableOrUnknown(data['queue_id']!, _queueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_queueIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {queueId};
  @override
  SyncQueueRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueRecord(
      queueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queue_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncQueueRecordsTable createAlias(String alias) {
    return $SyncQueueRecordsTable(attachedDatabase, alias);
  }
}

class SyncQueueRecord extends DataClass implements Insertable<SyncQueueRecord> {
  final String queueId;
  final String entityType;
  final String entityId;
  final String payload;
  final DateTime updatedAt;
  const SyncQueueRecord({
    required this.queueId,
    required this.entityType,
    required this.entityId,
    required this.payload,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['queue_id'] = Variable<String>(queueId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['payload'] = Variable<String>(payload);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncQueueRecordsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueRecordsCompanion(
      queueId: Value(queueId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      payload: Value(payload),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncQueueRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueRecord(
      queueId: serializer.fromJson<String>(json['queueId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      payload: serializer.fromJson<String>(json['payload']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'queueId': serializer.toJson<String>(queueId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'payload': serializer.toJson<String>(payload),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncQueueRecord copyWith({
    String? queueId,
    String? entityType,
    String? entityId,
    String? payload,
    DateTime? updatedAt,
  }) => SyncQueueRecord(
    queueId: queueId ?? this.queueId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    payload: payload ?? this.payload,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SyncQueueRecord copyWithCompanion(SyncQueueRecordsCompanion data) {
    return SyncQueueRecord(
      queueId: data.queueId.present ? data.queueId.value : this.queueId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      payload: data.payload.present ? data.payload.value : this.payload,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueRecord(')
          ..write('queueId: $queueId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(queueId, entityType, entityId, payload, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueRecord &&
          other.queueId == this.queueId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.payload == this.payload &&
          other.updatedAt == this.updatedAt);
}

class SyncQueueRecordsCompanion extends UpdateCompanion<SyncQueueRecord> {
  final Value<String> queueId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> payload;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyncQueueRecordsCompanion({
    this.queueId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.payload = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueRecordsCompanion.insert({
    required String queueId,
    required String entityType,
    required String entityId,
    required String payload,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : queueId = Value(queueId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       payload = Value(payload),
       updatedAt = Value(updatedAt);
  static Insertable<SyncQueueRecord> custom({
    Expression<String>? queueId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? payload,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (queueId != null) 'queue_id': queueId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (payload != null) 'payload': payload,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueRecordsCompanion copyWith({
    Value<String>? queueId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? payload,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncQueueRecordsCompanion(
      queueId: queueId ?? this.queueId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      payload: payload ?? this.payload,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (queueId.present) {
      map['queue_id'] = Variable<String>(queueId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueRecordsCompanion(')
          ..write('queueId: $queueId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('payload: $payload, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ServerRecordsTable serverRecords = $ServerRecordsTable(this);
  late final $PlaybackStateRecordsTable playbackStateRecords =
      $PlaybackStateRecordsTable(this);
  late final $WatchHistoryRecordsTable watchHistoryRecords =
      $WatchHistoryRecordsTable(this);
  late final $CollectionRecordsTable collectionRecords =
      $CollectionRecordsTable(this);
  late final $PreferenceRecordsTable preferenceRecords =
      $PreferenceRecordsTable(this);
  late final $SyncQueueRecordsTable syncQueueRecords = $SyncQueueRecordsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    serverRecords,
    playbackStateRecords,
    watchHistoryRecords,
    collectionRecords,
    preferenceRecords,
    syncQueueRecords,
  ];
}

typedef $$ServerRecordsTableCreateCompanionBuilder =
    ServerRecordsCompanion Function({
      required String id,
      required String name,
      required String baseUrl,
      required String serverType,
      Value<String?> username,
      Value<bool> isOnline,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ServerRecordsTableUpdateCompanionBuilder =
    ServerRecordsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> baseUrl,
      Value<String> serverType,
      Value<String?> username,
      Value<bool> isOnline,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ServerRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ServerRecordsTable> {
  $$ServerRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverType => $composableBuilder(
    column: $table.serverType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServerRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServerRecordsTable> {
  $$ServerRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverType => $composableBuilder(
    column: $table.serverType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServerRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServerRecordsTable> {
  $$ServerRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get serverType => $composableBuilder(
    column: $table.serverType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<bool> get isOnline =>
      $composableBuilder(column: $table.isOnline, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ServerRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServerRecordsTable,
          ServerRecord,
          $$ServerRecordsTableFilterComposer,
          $$ServerRecordsTableOrderingComposer,
          $$ServerRecordsTableAnnotationComposer,
          $$ServerRecordsTableCreateCompanionBuilder,
          $$ServerRecordsTableUpdateCompanionBuilder,
          (
            ServerRecord,
            BaseReferences<_$AppDatabase, $ServerRecordsTable, ServerRecord>,
          ),
          ServerRecord,
          PrefetchHooks Function()
        > {
  $$ServerRecordsTableTableManager(_$AppDatabase db, $ServerRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServerRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServerRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServerRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> serverType = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServerRecordsCompanion(
                id: id,
                name: name,
                baseUrl: baseUrl,
                serverType: serverType,
                username: username,
                isOnline: isOnline,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String baseUrl,
                required String serverType,
                Value<String?> username = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ServerRecordsCompanion.insert(
                id: id,
                name: name,
                baseUrl: baseUrl,
                serverType: serverType,
                username: username,
                isOnline: isOnline,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServerRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServerRecordsTable,
      ServerRecord,
      $$ServerRecordsTableFilterComposer,
      $$ServerRecordsTableOrderingComposer,
      $$ServerRecordsTableAnnotationComposer,
      $$ServerRecordsTableCreateCompanionBuilder,
      $$ServerRecordsTableUpdateCompanionBuilder,
      (
        ServerRecord,
        BaseReferences<_$AppDatabase, $ServerRecordsTable, ServerRecord>,
      ),
      ServerRecord,
      PrefetchHooks Function()
    >;
typedef $$PlaybackStateRecordsTableCreateCompanionBuilder =
    PlaybackStateRecordsCompanion Function({
      required String serverId,
      required String itemId,
      Value<int> positionSeconds,
      Value<int> durationSeconds,
      required String deviceId,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PlaybackStateRecordsTableUpdateCompanionBuilder =
    PlaybackStateRecordsCompanion Function({
      Value<String> serverId,
      Value<String> itemId,
      Value<int> positionSeconds,
      Value<int> durationSeconds,
      Value<String> deviceId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PlaybackStateRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaybackStateRecordsTable> {
  $$PlaybackStateRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get positionSeconds => $composableBuilder(
    column: $table.positionSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaybackStateRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaybackStateRecordsTable> {
  $$PlaybackStateRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get positionSeconds => $composableBuilder(
    column: $table.positionSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaybackStateRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaybackStateRecordsTable> {
  $$PlaybackStateRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get positionSeconds => $composableBuilder(
    column: $table.positionSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PlaybackStateRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaybackStateRecordsTable,
          PlaybackStateRecord,
          $$PlaybackStateRecordsTableFilterComposer,
          $$PlaybackStateRecordsTableOrderingComposer,
          $$PlaybackStateRecordsTableAnnotationComposer,
          $$PlaybackStateRecordsTableCreateCompanionBuilder,
          $$PlaybackStateRecordsTableUpdateCompanionBuilder,
          (
            PlaybackStateRecord,
            BaseReferences<
              _$AppDatabase,
              $PlaybackStateRecordsTable,
              PlaybackStateRecord
            >,
          ),
          PlaybackStateRecord,
          PrefetchHooks Function()
        > {
  $$PlaybackStateRecordsTableTableManager(
    _$AppDatabase db,
    $PlaybackStateRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaybackStateRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaybackStateRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PlaybackStateRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> serverId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<int> positionSeconds = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaybackStateRecordsCompanion(
                serverId: serverId,
                itemId: itemId,
                positionSeconds: positionSeconds,
                durationSeconds: durationSeconds,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String serverId,
                required String itemId,
                Value<int> positionSeconds = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                required String deviceId,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PlaybackStateRecordsCompanion.insert(
                serverId: serverId,
                itemId: itemId,
                positionSeconds: positionSeconds,
                durationSeconds: durationSeconds,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaybackStateRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaybackStateRecordsTable,
      PlaybackStateRecord,
      $$PlaybackStateRecordsTableFilterComposer,
      $$PlaybackStateRecordsTableOrderingComposer,
      $$PlaybackStateRecordsTableAnnotationComposer,
      $$PlaybackStateRecordsTableCreateCompanionBuilder,
      $$PlaybackStateRecordsTableUpdateCompanionBuilder,
      (
        PlaybackStateRecord,
        BaseReferences<
          _$AppDatabase,
          $PlaybackStateRecordsTable,
          PlaybackStateRecord
        >,
      ),
      PlaybackStateRecord,
      PrefetchHooks Function()
    >;
typedef $$WatchHistoryRecordsTableCreateCompanionBuilder =
    WatchHistoryRecordsCompanion Function({
      required String serverId,
      required String itemId,
      required DateTime watchedAt,
      required String deviceId,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WatchHistoryRecordsTableUpdateCompanionBuilder =
    WatchHistoryRecordsCompanion Function({
      Value<String> serverId,
      Value<String> itemId,
      Value<DateTime> watchedAt,
      Value<String> deviceId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$WatchHistoryRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $WatchHistoryRecordsTable> {
  $$WatchHistoryRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get watchedAt => $composableBuilder(
    column: $table.watchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WatchHistoryRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WatchHistoryRecordsTable> {
  $$WatchHistoryRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get watchedAt => $composableBuilder(
    column: $table.watchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WatchHistoryRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WatchHistoryRecordsTable> {
  $$WatchHistoryRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<DateTime> get watchedAt =>
      $composableBuilder(column: $table.watchedAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WatchHistoryRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WatchHistoryRecordsTable,
          WatchHistoryRecord,
          $$WatchHistoryRecordsTableFilterComposer,
          $$WatchHistoryRecordsTableOrderingComposer,
          $$WatchHistoryRecordsTableAnnotationComposer,
          $$WatchHistoryRecordsTableCreateCompanionBuilder,
          $$WatchHistoryRecordsTableUpdateCompanionBuilder,
          (
            WatchHistoryRecord,
            BaseReferences<
              _$AppDatabase,
              $WatchHistoryRecordsTable,
              WatchHistoryRecord
            >,
          ),
          WatchHistoryRecord,
          PrefetchHooks Function()
        > {
  $$WatchHistoryRecordsTableTableManager(
    _$AppDatabase db,
    $WatchHistoryRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WatchHistoryRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WatchHistoryRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WatchHistoryRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> serverId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<DateTime> watchedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WatchHistoryRecordsCompanion(
                serverId: serverId,
                itemId: itemId,
                watchedAt: watchedAt,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String serverId,
                required String itemId,
                required DateTime watchedAt,
                required String deviceId,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WatchHistoryRecordsCompanion.insert(
                serverId: serverId,
                itemId: itemId,
                watchedAt: watchedAt,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WatchHistoryRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WatchHistoryRecordsTable,
      WatchHistoryRecord,
      $$WatchHistoryRecordsTableFilterComposer,
      $$WatchHistoryRecordsTableOrderingComposer,
      $$WatchHistoryRecordsTableAnnotationComposer,
      $$WatchHistoryRecordsTableCreateCompanionBuilder,
      $$WatchHistoryRecordsTableUpdateCompanionBuilder,
      (
        WatchHistoryRecord,
        BaseReferences<
          _$AppDatabase,
          $WatchHistoryRecordsTable,
          WatchHistoryRecord
        >,
      ),
      WatchHistoryRecord,
      PrefetchHooks Function()
    >;
typedef $$CollectionRecordsTableCreateCompanionBuilder =
    CollectionRecordsCompanion Function({
      required String serverId,
      required String itemId,
      required String kind,
      required String deviceId,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CollectionRecordsTableUpdateCompanionBuilder =
    CollectionRecordsCompanion Function({
      Value<String> serverId,
      Value<String> itemId,
      Value<String> kind,
      Value<String> deviceId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CollectionRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionRecordsTable> {
  $$CollectionRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CollectionRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionRecordsTable> {
  $$CollectionRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CollectionRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionRecordsTable> {
  $$CollectionRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CollectionRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionRecordsTable,
          CollectionRecord,
          $$CollectionRecordsTableFilterComposer,
          $$CollectionRecordsTableOrderingComposer,
          $$CollectionRecordsTableAnnotationComposer,
          $$CollectionRecordsTableCreateCompanionBuilder,
          $$CollectionRecordsTableUpdateCompanionBuilder,
          (
            CollectionRecord,
            BaseReferences<
              _$AppDatabase,
              $CollectionRecordsTable,
              CollectionRecord
            >,
          ),
          CollectionRecord,
          PrefetchHooks Function()
        > {
  $$CollectionRecordsTableTableManager(
    _$AppDatabase db,
    $CollectionRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> serverId = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CollectionRecordsCompanion(
                serverId: serverId,
                itemId: itemId,
                kind: kind,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String serverId,
                required String itemId,
                required String kind,
                required String deviceId,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CollectionRecordsCompanion.insert(
                serverId: serverId,
                itemId: itemId,
                kind: kind,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CollectionRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionRecordsTable,
      CollectionRecord,
      $$CollectionRecordsTableFilterComposer,
      $$CollectionRecordsTableOrderingComposer,
      $$CollectionRecordsTableAnnotationComposer,
      $$CollectionRecordsTableCreateCompanionBuilder,
      $$CollectionRecordsTableUpdateCompanionBuilder,
      (
        CollectionRecord,
        BaseReferences<
          _$AppDatabase,
          $CollectionRecordsTable,
          CollectionRecord
        >,
      ),
      CollectionRecord,
      PrefetchHooks Function()
    >;
typedef $$PreferenceRecordsTableCreateCompanionBuilder =
    PreferenceRecordsCompanion Function({
      required String key,
      required String value,
      required String deviceId,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PreferenceRecordsTableUpdateCompanionBuilder =
    PreferenceRecordsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<String> deviceId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PreferenceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PreferenceRecordsTable> {
  $$PreferenceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreferenceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferenceRecordsTable> {
  $$PreferenceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferenceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferenceRecordsTable> {
  $$PreferenceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PreferenceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreferenceRecordsTable,
          PreferenceRecord,
          $$PreferenceRecordsTableFilterComposer,
          $$PreferenceRecordsTableOrderingComposer,
          $$PreferenceRecordsTableAnnotationComposer,
          $$PreferenceRecordsTableCreateCompanionBuilder,
          $$PreferenceRecordsTableUpdateCompanionBuilder,
          (
            PreferenceRecord,
            BaseReferences<
              _$AppDatabase,
              $PreferenceRecordsTable,
              PreferenceRecord
            >,
          ),
          PreferenceRecord,
          PrefetchHooks Function()
        > {
  $$PreferenceRecordsTableTableManager(
    _$AppDatabase db,
    $PreferenceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferenceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferenceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferenceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreferenceRecordsCompanion(
                key: key,
                value: value,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required String deviceId,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PreferenceRecordsCompanion.insert(
                key: key,
                value: value,
                deviceId: deviceId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreferenceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreferenceRecordsTable,
      PreferenceRecord,
      $$PreferenceRecordsTableFilterComposer,
      $$PreferenceRecordsTableOrderingComposer,
      $$PreferenceRecordsTableAnnotationComposer,
      $$PreferenceRecordsTableCreateCompanionBuilder,
      $$PreferenceRecordsTableUpdateCompanionBuilder,
      (
        PreferenceRecord,
        BaseReferences<
          _$AppDatabase,
          $PreferenceRecordsTable,
          PreferenceRecord
        >,
      ),
      PreferenceRecord,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueRecordsTableCreateCompanionBuilder =
    SyncQueueRecordsCompanion Function({
      required String queueId,
      required String entityType,
      required String entityId,
      required String payload,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SyncQueueRecordsTableUpdateCompanionBuilder =
    SyncQueueRecordsCompanion Function({
      Value<String> queueId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> payload,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SyncQueueRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueRecordsTable> {
  $$SyncQueueRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get queueId => $composableBuilder(
    column: $table.queueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueRecordsTable> {
  $$SyncQueueRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get queueId => $composableBuilder(
    column: $table.queueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueRecordsTable> {
  $$SyncQueueRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get queueId =>
      $composableBuilder(column: $table.queueId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncQueueRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueRecordsTable,
          SyncQueueRecord,
          $$SyncQueueRecordsTableFilterComposer,
          $$SyncQueueRecordsTableOrderingComposer,
          $$SyncQueueRecordsTableAnnotationComposer,
          $$SyncQueueRecordsTableCreateCompanionBuilder,
          $$SyncQueueRecordsTableUpdateCompanionBuilder,
          (
            SyncQueueRecord,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueRecordsTable,
              SyncQueueRecord
            >,
          ),
          SyncQueueRecord,
          PrefetchHooks Function()
        > {
  $$SyncQueueRecordsTableTableManager(
    _$AppDatabase db,
    $SyncQueueRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> queueId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueRecordsCompanion(
                queueId: queueId,
                entityType: entityType,
                entityId: entityId,
                payload: payload,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String queueId,
                required String entityType,
                required String entityId,
                required String payload,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueRecordsCompanion.insert(
                queueId: queueId,
                entityType: entityType,
                entityId: entityId,
                payload: payload,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueRecordsTable,
      SyncQueueRecord,
      $$SyncQueueRecordsTableFilterComposer,
      $$SyncQueueRecordsTableOrderingComposer,
      $$SyncQueueRecordsTableAnnotationComposer,
      $$SyncQueueRecordsTableCreateCompanionBuilder,
      $$SyncQueueRecordsTableUpdateCompanionBuilder,
      (
        SyncQueueRecord,
        BaseReferences<_$AppDatabase, $SyncQueueRecordsTable, SyncQueueRecord>,
      ),
      SyncQueueRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ServerRecordsTableTableManager get serverRecords =>
      $$ServerRecordsTableTableManager(_db, _db.serverRecords);
  $$PlaybackStateRecordsTableTableManager get playbackStateRecords =>
      $$PlaybackStateRecordsTableTableManager(_db, _db.playbackStateRecords);
  $$WatchHistoryRecordsTableTableManager get watchHistoryRecords =>
      $$WatchHistoryRecordsTableTableManager(_db, _db.watchHistoryRecords);
  $$CollectionRecordsTableTableManager get collectionRecords =>
      $$CollectionRecordsTableTableManager(_db, _db.collectionRecords);
  $$PreferenceRecordsTableTableManager get preferenceRecords =>
      $$PreferenceRecordsTableTableManager(_db, _db.preferenceRecords);
  $$SyncQueueRecordsTableTableManager get syncQueueRecords =>
      $$SyncQueueRecordsTableTableManager(_db, _db.syncQueueRecords);
}
