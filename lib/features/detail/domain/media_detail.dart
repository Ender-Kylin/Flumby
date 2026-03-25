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
  }) = _MediaDetail;

  factory MediaDetail.fromJson(Map<String, dynamic> json) =>
      _$MediaDetailFromJson(json);

  bool get isPlayable => streamUrl.trim().isNotEmpty;
}
