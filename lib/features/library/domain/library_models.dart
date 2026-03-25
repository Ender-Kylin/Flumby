import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_models.freezed.dart';
part 'library_models.g.dart';

@freezed
abstract class LibrarySummary with _$LibrarySummary {
  const factory LibrarySummary({
    required String id,
    required String serverId,
    required String title,
    required String type,
    String? libraryImageUrl,
    @Default(0) int itemCount,
  }) = _LibrarySummary;

  factory LibrarySummary.fromJson(Map<String, dynamic> json) =>
      _$LibrarySummaryFromJson(json);
}

@freezed
abstract class MediaItemSummary with _$MediaItemSummary {
  const MediaItemSummary._();

  const factory MediaItemSummary({
    required String id,
    required String serverId,
    required String libraryId,
    required String title,
    required String overview,
    String? posterImageUrl,
    String? backdropImageUrl,
    String? thumbImageUrl,
    @Default(0) int runtimeSeconds,
    @Default(0) double progress,
    @Default(false) bool isFavorite,
    @Default(false) bool isResumable,
    @Default('Video') String mediaType,
    String? seriesId,
    String? seriesTitle,
    int? year,
  }) = _MediaItemSummary;

  factory MediaItemSummary.fromJson(Map<String, dynamic> json) =>
      _$MediaItemSummaryFromJson(json);

  int get progressPercent => (progress * 100).round();

  bool get isSeries => mediaType == 'Series';

  String get searchGroupId {
    if (isSeries) {
      return 'series:$id';
    }

    final normalizedSeriesId = seriesId?.trim();
    if (normalizedSeriesId != null && normalizedSeriesId.isNotEmpty) {
      return 'series:$normalizedSeriesId';
    }

    return 'item:$id';
  }

  String get searchGroupTitle {
    if (isSeries) {
      return title;
    }

    final normalizedSeriesTitle = seriesTitle?.trim();
    if (normalizedSeriesTitle != null && normalizedSeriesTitle.isNotEmpty) {
      return normalizedSeriesTitle;
    }

    return title;
  }
}
