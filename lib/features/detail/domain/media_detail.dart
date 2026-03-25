import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_detail.freezed.dart';
part 'media_detail.g.dart';

@freezed
abstract class MediaDetail with _$MediaDetail {
  const MediaDetail._();

  const factory MediaDetail({
    required String id,
    required String serverId,
    required String title,
    required String overview,
    String? posterImageUrl,
    String? backdropImageUrl,
    String? thumbImageUrl,
    @Default(0) int runtimeSeconds,
    @Default(0) int resumePositionSeconds,
    @Default(false) bool isFavorite,
    int? year,
    @Default(<String>[]) List<String> genres,
    required String mediaType,
    required String streamUrl,
    String? mediaSourceId,
    String? playSessionId,
    @Default(<SeriesSeasonSummary>[]) List<SeriesSeasonSummary> seriesSeasons,
  }) = _MediaDetail;

  factory MediaDetail.fromJson(Map<String, dynamic> json) =>
      _$MediaDetailFromJson(json);

  bool get isPlayable => streamUrl.trim().isNotEmpty;

  bool get isSeries => mediaType == 'Series';
}

@freezed
abstract class SeriesSeasonSummary with _$SeriesSeasonSummary {
  const SeriesSeasonSummary._();

  const factory SeriesSeasonSummary({
    required String id,
    required String title,
    int? seasonNumber,
    String? imageUrl,
    @Default(<SeriesEpisodeSummary>[]) List<SeriesEpisodeSummary> episodes,
  }) = _SeriesSeasonSummary;

  factory SeriesSeasonSummary.fromJson(Map<String, dynamic> json) =>
      _$SeriesSeasonSummaryFromJson(json);

  String get displayTitle {
    if (title.trim().isNotEmpty) {
      return title;
    }
    if (seasonNumber != null) {
      return 'Season $seasonNumber';
    }
    return 'Episodes';
  }
}

@freezed
abstract class SeriesEpisodeSummary with _$SeriesEpisodeSummary {
  const SeriesEpisodeSummary._();

  const factory SeriesEpisodeSummary({
    required String id,
    required String serverId,
    required String seasonId,
    required String title,
    required String overview,
    String? posterImageUrl,
    String? backdropImageUrl,
    String? thumbImageUrl,
    @Default(0) int runtimeSeconds,
    @Default(0) double progress,
    @Default(false) bool isFavorite,
    @Default(false) bool isResumable,
    int? seasonNumber,
    int? episodeNumber,
    DateTime? lastPlayedAt,
    DateTime? premiereDate,
  }) = _SeriesEpisodeSummary;

  factory SeriesEpisodeSummary.fromJson(Map<String, dynamic> json) =>
      _$SeriesEpisodeSummaryFromJson(json);

  String get episodeLabel {
    if (episodeNumber != null) {
      return 'E${episodeNumber!.toString().padLeft(2, '0')}';
    }
    return 'EP';
  }

  int get progressPercent => (progress * 100).round();
}
