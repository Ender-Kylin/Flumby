// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibrarySummary _$LibrarySummaryFromJson(Map<String, dynamic> json) =>
    _LibrarySummary(
      id: json['id'] as String,
      serverId: json['serverId'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LibrarySummaryToJson(_LibrarySummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverId': instance.serverId,
      'title': instance.title,
      'type': instance.type,
      'itemCount': instance.itemCount,
    };

_MediaItemSummary _$MediaItemSummaryFromJson(Map<String, dynamic> json) =>
    _MediaItemSummary(
      id: json['id'] as String,
      serverId: json['serverId'] as String,
      libraryId: json['libraryId'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      runtimeSeconds: (json['runtimeSeconds'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isResumable: json['isResumable'] as bool? ?? false,
      year: (json['year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaItemSummaryToJson(_MediaItemSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverId': instance.serverId,
      'libraryId': instance.libraryId,
      'title': instance.title,
      'overview': instance.overview,
      'runtimeSeconds': instance.runtimeSeconds,
      'progress': instance.progress,
      'isFavorite': instance.isFavorite,
      'isResumable': instance.isResumable,
      'year': instance.year,
    };
