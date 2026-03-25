// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaServerProfile _$MediaServerProfileFromJson(Map<String, dynamic> json) =>
    _MediaServerProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      baseUrl: json['baseUrl'] as String,
      type: $enumDecode(_$MediaServerTypeEnumMap, json['type']),
      username: json['username'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      updatedAt: const DateTimeIso8601Converter().fromJson(
        json['updatedAt'] as String,
      ),
    );

Map<String, dynamic> _$MediaServerProfileToJson(_MediaServerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseUrl': instance.baseUrl,
      'type': _$MediaServerTypeEnumMap[instance.type]!,
      'username': instance.username,
      'isOnline': instance.isOnline,
      'updatedAt': const DateTimeIso8601Converter().toJson(instance.updatedAt),
    };

const _$MediaServerTypeEnumMap = {
  MediaServerType.emby: 'emby',
  MediaServerType.jellyfin: 'jellyfin',
};

_ServerSignInRequest _$ServerSignInRequestFromJson(Map<String, dynamic> json) =>
    _ServerSignInRequest(
      baseUrl: json['baseUrl'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      type:
          $enumDecodeNullable(_$MediaServerTypeEnumMap, json['type']) ??
          MediaServerType.emby,
    );

Map<String, dynamic> _$ServerSignInRequestToJson(
  _ServerSignInRequest instance,
) => <String, dynamic>{
  'baseUrl': instance.baseUrl,
  'username': instance.username,
  'password': instance.password,
  'type': _$MediaServerTypeEnumMap[instance.type]!,
};

_MediaServerSession _$MediaServerSessionFromJson(Map<String, dynamic> json) =>
    _MediaServerSession(
      server: MediaServerProfile.fromJson(
        json['server'] as Map<String, dynamic>,
      ),
      accessToken: json['accessToken'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$MediaServerSessionToJson(_MediaServerSession instance) =>
    <String, dynamic>{
      'server': instance.server.toJson(),
      'accessToken': instance.accessToken,
      'userId': instance.userId,
    };
