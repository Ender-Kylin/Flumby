import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_detail.freezed.dart';
part 'media_detail.g.dart';

@freezed
abstract class MediaDetail with _$MediaDetail {
  const factory MediaDetail({
    required String id,
    required String serverId,
    required String title,
    required String overview,
    @Default(0) int runtimeSeconds,
    @Default(0) int resumePositionSeconds,
    int? year,
    @Default(<String>[]) List<String> genres,
    required String mediaType,
    required String streamUrl,
    String? mediaSourceId,
    String? playSessionId,
  }) = _MediaDetail;

  factory MediaDetail.fromJson(Map<String, dynamic> json) =>
      _$MediaDetailFromJson(json);
}
