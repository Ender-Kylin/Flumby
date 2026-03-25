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
    @Default(0) int runtimeSeconds,
    @Default(0) double progress,
    @Default(false) bool isFavorite,
    @Default(false) bool isResumable,
    int? year,
  }) = _MediaItemSummary;

  factory MediaItemSummary.fromJson(Map<String, dynamic> json) =>
      _$MediaItemSummaryFromJson(json);

  int get progressPercent => (progress * 100).round();
}
