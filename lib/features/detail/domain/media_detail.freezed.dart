// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaDetail {

 String get id; String get serverId; String get title; String get overview; String? get posterImageUrl; String? get backdropImageUrl; String? get thumbImageUrl; int get runtimeSeconds; int get resumePositionSeconds; bool get isFavorite; int? get year; List<String> get genres; String get mediaType; String get streamUrl; String? get mediaSourceId; String? get playSessionId;
/// Create a copy of MediaDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaDetailCopyWith<MediaDetail> get copyWith => _$MediaDetailCopyWithImpl<MediaDetail>(this as MediaDetail, _$identity);

  /// Serializes this MediaDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.backdropImageUrl, backdropImageUrl) || other.backdropImageUrl == backdropImageUrl)&&(identical(other.thumbImageUrl, thumbImageUrl) || other.thumbImageUrl == thumbImageUrl)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.resumePositionSeconds, resumePositionSeconds) || other.resumePositionSeconds == resumePositionSeconds)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,title,overview,posterImageUrl,backdropImageUrl,thumbImageUrl,runtimeSeconds,resumePositionSeconds,isFavorite,year,const DeepCollectionEquality().hash(genres),mediaType,streamUrl,mediaSourceId,playSessionId);

@override
String toString() {
  return 'MediaDetail(id: $id, serverId: $serverId, title: $title, overview: $overview, posterImageUrl: $posterImageUrl, backdropImageUrl: $backdropImageUrl, thumbImageUrl: $thumbImageUrl, runtimeSeconds: $runtimeSeconds, resumePositionSeconds: $resumePositionSeconds, isFavorite: $isFavorite, year: $year, genres: $genres, mediaType: $mediaType, streamUrl: $streamUrl, mediaSourceId: $mediaSourceId, playSessionId: $playSessionId)';
}


}

/// @nodoc
abstract mixin class $MediaDetailCopyWith<$Res>  {
  factory $MediaDetailCopyWith(MediaDetail value, $Res Function(MediaDetail) _then) = _$MediaDetailCopyWithImpl;
@useResult
$Res call({
 String id, String serverId, String title, String overview, String? posterImageUrl, String? backdropImageUrl, String? thumbImageUrl, int runtimeSeconds, int resumePositionSeconds, bool isFavorite, int? year, List<String> genres, String mediaType, String streamUrl, String? mediaSourceId, String? playSessionId
});




}
/// @nodoc
class _$MediaDetailCopyWithImpl<$Res>
    implements $MediaDetailCopyWith<$Res> {
  _$MediaDetailCopyWithImpl(this._self, this._then);

  final MediaDetail _self;
  final $Res Function(MediaDetail) _then;

/// Create a copy of MediaDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serverId = null,Object? title = null,Object? overview = null,Object? posterImageUrl = freezed,Object? backdropImageUrl = freezed,Object? thumbImageUrl = freezed,Object? runtimeSeconds = null,Object? resumePositionSeconds = null,Object? isFavorite = null,Object? year = freezed,Object? genres = null,Object? mediaType = null,Object? streamUrl = null,Object? mediaSourceId = freezed,Object? playSessionId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterImageUrl: freezed == posterImageUrl ? _self.posterImageUrl : posterImageUrl // ignore: cast_nullable_to_non_nullable
as String?,backdropImageUrl: freezed == backdropImageUrl ? _self.backdropImageUrl : backdropImageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbImageUrl: freezed == thumbImageUrl ? _self.thumbImageUrl : thumbImageUrl // ignore: cast_nullable_to_non_nullable
as String?,runtimeSeconds: null == runtimeSeconds ? _self.runtimeSeconds : runtimeSeconds // ignore: cast_nullable_to_non_nullable
as int,resumePositionSeconds: null == resumePositionSeconds ? _self.resumePositionSeconds : resumePositionSeconds // ignore: cast_nullable_to_non_nullable
as int,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,mediaSourceId: freezed == mediaSourceId ? _self.mediaSourceId : mediaSourceId // ignore: cast_nullable_to_non_nullable
as String?,playSessionId: freezed == playSessionId ? _self.playSessionId : playSessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaDetail].
extension MediaDetailPatterns on MediaDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaDetail value)  $default,){
final _that = this;
switch (_that) {
case _MediaDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaDetail value)?  $default,){
final _that = this;
switch (_that) {
case _MediaDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serverId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  int resumePositionSeconds,  bool isFavorite,  int? year,  List<String> genres,  String mediaType,  String streamUrl,  String? mediaSourceId,  String? playSessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaDetail() when $default != null:
return $default(_that.id,_that.serverId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.resumePositionSeconds,_that.isFavorite,_that.year,_that.genres,_that.mediaType,_that.streamUrl,_that.mediaSourceId,_that.playSessionId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serverId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  int resumePositionSeconds,  bool isFavorite,  int? year,  List<String> genres,  String mediaType,  String streamUrl,  String? mediaSourceId,  String? playSessionId)  $default,) {final _that = this;
switch (_that) {
case _MediaDetail():
return $default(_that.id,_that.serverId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.resumePositionSeconds,_that.isFavorite,_that.year,_that.genres,_that.mediaType,_that.streamUrl,_that.mediaSourceId,_that.playSessionId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serverId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  int resumePositionSeconds,  bool isFavorite,  int? year,  List<String> genres,  String mediaType,  String streamUrl,  String? mediaSourceId,  String? playSessionId)?  $default,) {final _that = this;
switch (_that) {
case _MediaDetail() when $default != null:
return $default(_that.id,_that.serverId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.resumePositionSeconds,_that.isFavorite,_that.year,_that.genres,_that.mediaType,_that.streamUrl,_that.mediaSourceId,_that.playSessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaDetail extends MediaDetail {
  const _MediaDetail({required this.id, required this.serverId, required this.title, required this.overview, this.posterImageUrl, this.backdropImageUrl, this.thumbImageUrl, this.runtimeSeconds = 0, this.resumePositionSeconds = 0, this.isFavorite = false, this.year, final  List<String> genres = const <String>[], required this.mediaType, required this.streamUrl, this.mediaSourceId, this.playSessionId}): _genres = genres,super._();
  factory _MediaDetail.fromJson(Map<String, dynamic> json) => _$MediaDetailFromJson(json);

@override final  String id;
@override final  String serverId;
@override final  String title;
@override final  String overview;
@override final  String? posterImageUrl;
@override final  String? backdropImageUrl;
@override final  String? thumbImageUrl;
@override@JsonKey() final  int runtimeSeconds;
@override@JsonKey() final  int resumePositionSeconds;
@override@JsonKey() final  bool isFavorite;
@override final  int? year;
 final  List<String> _genres;
@override@JsonKey() List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override final  String mediaType;
@override final  String streamUrl;
@override final  String? mediaSourceId;
@override final  String? playSessionId;

/// Create a copy of MediaDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaDetailCopyWith<_MediaDetail> get copyWith => __$MediaDetailCopyWithImpl<_MediaDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.backdropImageUrl, backdropImageUrl) || other.backdropImageUrl == backdropImageUrl)&&(identical(other.thumbImageUrl, thumbImageUrl) || other.thumbImageUrl == thumbImageUrl)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.resumePositionSeconds, resumePositionSeconds) || other.resumePositionSeconds == resumePositionSeconds)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,title,overview,posterImageUrl,backdropImageUrl,thumbImageUrl,runtimeSeconds,resumePositionSeconds,isFavorite,year,const DeepCollectionEquality().hash(_genres),mediaType,streamUrl,mediaSourceId,playSessionId);

@override
String toString() {
  return 'MediaDetail(id: $id, serverId: $serverId, title: $title, overview: $overview, posterImageUrl: $posterImageUrl, backdropImageUrl: $backdropImageUrl, thumbImageUrl: $thumbImageUrl, runtimeSeconds: $runtimeSeconds, resumePositionSeconds: $resumePositionSeconds, isFavorite: $isFavorite, year: $year, genres: $genres, mediaType: $mediaType, streamUrl: $streamUrl, mediaSourceId: $mediaSourceId, playSessionId: $playSessionId)';
}


}

/// @nodoc
abstract mixin class _$MediaDetailCopyWith<$Res> implements $MediaDetailCopyWith<$Res> {
  factory _$MediaDetailCopyWith(_MediaDetail value, $Res Function(_MediaDetail) _then) = __$MediaDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String serverId, String title, String overview, String? posterImageUrl, String? backdropImageUrl, String? thumbImageUrl, int runtimeSeconds, int resumePositionSeconds, bool isFavorite, int? year, List<String> genres, String mediaType, String streamUrl, String? mediaSourceId, String? playSessionId
});




}
/// @nodoc
class __$MediaDetailCopyWithImpl<$Res>
    implements _$MediaDetailCopyWith<$Res> {
  __$MediaDetailCopyWithImpl(this._self, this._then);

  final _MediaDetail _self;
  final $Res Function(_MediaDetail) _then;

/// Create a copy of MediaDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serverId = null,Object? title = null,Object? overview = null,Object? posterImageUrl = freezed,Object? backdropImageUrl = freezed,Object? thumbImageUrl = freezed,Object? runtimeSeconds = null,Object? resumePositionSeconds = null,Object? isFavorite = null,Object? year = freezed,Object? genres = null,Object? mediaType = null,Object? streamUrl = null,Object? mediaSourceId = freezed,Object? playSessionId = freezed,}) {
  return _then(_MediaDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterImageUrl: freezed == posterImageUrl ? _self.posterImageUrl : posterImageUrl // ignore: cast_nullable_to_non_nullable
as String?,backdropImageUrl: freezed == backdropImageUrl ? _self.backdropImageUrl : backdropImageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbImageUrl: freezed == thumbImageUrl ? _self.thumbImageUrl : thumbImageUrl // ignore: cast_nullable_to_non_nullable
as String?,runtimeSeconds: null == runtimeSeconds ? _self.runtimeSeconds : runtimeSeconds // ignore: cast_nullable_to_non_nullable
as int,resumePositionSeconds: null == resumePositionSeconds ? _self.resumePositionSeconds : resumePositionSeconds // ignore: cast_nullable_to_non_nullable
as int,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,mediaSourceId: freezed == mediaSourceId ? _self.mediaSourceId : mediaSourceId // ignore: cast_nullable_to_non_nullable
as String?,playSessionId: freezed == playSessionId ? _self.playSessionId : playSessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
