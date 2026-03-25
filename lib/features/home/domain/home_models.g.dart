// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeSection _$HomeSectionFromJson(Map<String, dynamic> json) => _HomeSection(
  id: json['id'] as String,
  title: json['title'] as String,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => MediaItemSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MediaItemSummary>[],
);

Map<String, dynamic> _$HomeSectionToJson(_HomeSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

_HomeFeed _$HomeFeedFromJson(Map<String, dynamic> json) => _HomeFeed(
  continueWatching:
      (json['continueWatching'] as List<dynamic>?)
          ?.map((e) => MediaItemSummary.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MediaItemSummary>[],
  sections:
      (json['sections'] as List<dynamic>?)
          ?.map((e) => HomeSection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HomeSection>[],
);

Map<String, dynamic> _$HomeFeedToJson(_HomeFeed instance) => <String, dynamic>{
  'continueWatching': instance.continueWatching.map((e) => e.toJson()).toList(),
  'sections': instance.sections.map((e) => e.toJson()).toList(),
};
