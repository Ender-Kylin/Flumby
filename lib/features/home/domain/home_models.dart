import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/library_models.dart';

part 'home_models.freezed.dart';
part 'home_models.g.dart';

@freezed
abstract class HomeSection with _$HomeSection {
  const factory HomeSection({
    required String id,
    required String title,
    @Default(<MediaItemSummary>[]) List<MediaItemSummary> items,
  }) = _HomeSection;

  factory HomeSection.fromJson(Map<String, dynamic> json) =>
      _$HomeSectionFromJson(json);
}

@freezed
abstract class HomeFeed with _$HomeFeed {
  const factory HomeFeed({
    @Default(<MediaItemSummary>[]) List<MediaItemSummary> continueWatching,
    @Default(<HomeSection>[]) List<HomeSection> sections,
  }) = _HomeFeed;

  factory HomeFeed.fromJson(Map<String, dynamic> json) =>
      _$HomeFeedFromJson(json);
}
