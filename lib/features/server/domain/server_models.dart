import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/date_time_converter.dart';

part 'server_models.freezed.dart';
part 'server_models.g.dart';

enum MediaServerType { emby, jellyfin }

@freezed
abstract class MediaServerProfile with _$MediaServerProfile {
  const factory MediaServerProfile({
    required String id,
    required String name,
    required String baseUrl,
    required MediaServerType type,
    String? username,
    @Default(false) bool isOnline,
    @DateTimeIso8601Converter() required DateTime updatedAt,
  }) = _MediaServerProfile;

  factory MediaServerProfile.fromJson(Map<String, dynamic> json) =>
      _$MediaServerProfileFromJson(json);
}

@freezed
abstract class ServerSignInRequest with _$ServerSignInRequest {
  const factory ServerSignInRequest({
    required String baseUrl,
    required String username,
    required String password,
    @Default(MediaServerType.emby) MediaServerType type,
  }) = _ServerSignInRequest;

  factory ServerSignInRequest.fromJson(Map<String, dynamic> json) =>
      _$ServerSignInRequestFromJson(json);
}

@freezed
abstract class MediaServerSession with _$MediaServerSession {
  const factory MediaServerSession({
    required MediaServerProfile server,
    required String accessToken,
    required String userId,
  }) = _MediaServerSession;

  factory MediaServerSession.fromJson(Map<String, dynamic> json) =>
      _$MediaServerSessionFromJson(json);
}
