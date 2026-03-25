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
  seriesSeasons:
      (json['seriesSeasons'] as List<dynamic>?)
          ?.map((e) => SeriesSeasonSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeriesSeasonSummary>[],
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
      'seriesSeasons': instance.seriesSeasons.map((e) => e.toJson()).toList(),
    };

_SeriesSeasonSummary _$SeriesSeasonSummaryFromJson(Map<String, dynamic> json) =>
    _SeriesSeasonSummary(
      id: json['id'] as String,
      title: json['title'] as String,
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      episodes:
          (json['episodes'] as List<dynamic>?)
              ?.map(
                (e) => SeriesEpisodeSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <SeriesEpisodeSummary>[],
    );

Map<String, dynamic> _$SeriesSeasonSummaryToJson(
  _SeriesSeasonSummary instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'seasonNumber': instance.seasonNumber,
  'imageUrl': instance.imageUrl,
  'episodes': instance.episodes.map((e) => e.toJson()).toList(),
};

_SeriesEpisodeSummary _$SeriesEpisodeSummaryFromJson(
  Map<String, dynamic> json,
) => _SeriesEpisodeSummary(
  id: json['id'] as String,
  serverId: json['serverId'] as String,
  seasonId: json['seasonId'] as String,
  title: json['title'] as String,
  overview: json['overview'] as String,
  posterImageUrl: json['posterImageUrl'] as String?,
  backdropImageUrl: json['backdropImageUrl'] as String?,
  thumbImageUrl: json['thumbImageUrl'] as String?,
  runtimeSeconds: (json['runtimeSeconds'] as num?)?.toInt() ?? 0,
  progress: (json['progress'] as num?)?.toDouble() ?? 0,
  isFavorite: json['isFavorite'] as bool? ?? false,
  isResumable: json['isResumable'] as bool? ?? false,
  seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
  episodeNumber: (json['episodeNumber'] as num?)?.toInt(),
  lastPlayedAt: json['lastPlayedAt'] == null
      ? null
      : DateTime.parse(json['lastPlayedAt'] as String),
  premiereDate: json['premiereDate'] == null
      ? null
      : DateTime.parse(json['premiereDate'] as String),
);

Map<String, dynamic> _$SeriesEpisodeSummaryToJson(
  _SeriesEpisodeSummary instance,
) => <String, dynamic>{
  'id': instance.id,
  'serverId': instance.serverId,
  'seasonId': instance.seasonId,
  'title': instance.title,
  'overview': instance.overview,
  'posterImageUrl': instance.posterImageUrl,
  'backdropImageUrl': instance.backdropImageUrl,
  'thumbImageUrl': instance.thumbImageUrl,
  'runtimeSeconds': instance.runtimeSeconds,
  'progress': instance.progress,
  'isFavorite': instance.isFavorite,
  'isResumable': instance.isResumable,
  'seasonNumber': instance.seasonNumber,
  'episodeNumber': instance.episodeNumber,
  'lastPlayedAt': instance.lastPlayedAt?.toIso8601String(),
  'premiereDate': instance.premiereDate?.toIso8601String(),
};
