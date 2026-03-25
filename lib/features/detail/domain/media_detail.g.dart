// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaDetail _$MediaDetailFromJson(Map<String, dynamic> json) => _MediaDetail(
  id: json['id'] as String,
  serverId: json['serverId'] as String,
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterImageUrl: json['posterImageUrl'] as String?,
  backdropImageUrl: json['backdropImageUrl'] as String?,
  thumbImageUrl: json['thumbImageUrl'] as String?,
  runtimeSeconds: (json['runtimeSeconds'] as num?)?.toInt() ?? 0,
  resumePositionSeconds: (json['resumePositionSeconds'] as num?)?.toInt() ?? 0,
  isFavorite: json['isFavorite'] as bool? ?? false,
  year: (json['year'] as num?)?.toInt(),
  genres:
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  mediaType: json['mediaType'] as String,
  streamUrl: json['streamUrl'] as String,
  mediaSourceId: json['mediaSourceId'] as String?,
  playSessionId: json['playSessionId'] as String?,
);

Map<String, dynamic> _$MediaDetailToJson(_MediaDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverId': instance.serverId,
      'title': instance.title,
      'overview': instance.overview,
      'posterImageUrl': instance.posterImageUrl,
      'backdropImageUrl': instance.backdropImageUrl,
      'thumbImageUrl': instance.thumbImageUrl,
      'runtimeSeconds': instance.runtimeSeconds,
      'resumePositionSeconds': instance.resumePositionSeconds,
      'isFavorite': instance.isFavorite,
      'year': instance.year,
      'genres': instance.genres,
      'mediaType': instance.mediaType,
      'streamUrl': instance.streamUrl,
      'mediaSourceId': instance.mediaSourceId,
      'playSessionId': instance.playSessionId,
    };
