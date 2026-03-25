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

 String get id; String get serverId; String get title; String get overview; String? get posterImageUrl; String? get backdropImageUrl; String? get thumbImageUrl; int get runtimeSeconds; int get resumePositionSeconds; bool get isFavorite; int? get year; List<String> get genres; String get mediaType; String get streamUrl; String? get mediaSourceId; String? get playSessionId; List<SeriesSeasonSummary> get seriesSeasons;
/// Create a copy of MediaDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaDetailCopyWith<MediaDetail> get copyWith => _$MediaDetailCopyWithImpl<MediaDetail>(this as MediaDetail, _$identity);

  /// Serializes this MediaDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.backdropImageUrl, backdropImageUrl) || other.backdropImageUrl == backdropImageUrl)&&(identical(other.thumbImageUrl, thumbImageUrl) || other.thumbImageUrl == thumbImageUrl)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.resumePositionSeconds, resumePositionSeconds) || other.resumePositionSeconds == resumePositionSeconds)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId)&&const DeepCollectionEquality().equals(other.seriesSeasons, seriesSeasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,title,overview,posterImageUrl,backdropImageUrl,thumbImageUrl,runtimeSeconds,resumePositionSeconds,isFavorite,year,const DeepCollectionEquality().hash(genres),mediaType,streamUrl,mediaSourceId,playSessionId,const DeepCollectionEquality().hash(seriesSeasons));

@override
String toString() {
  return 'MediaDetail(id: $id, serverId: $serverId, title: $title, overview: $overview, posterImageUrl: $posterImageUrl, backdropImageUrl: $backdropImageUrl, thumbImageUrl: $thumbImageUrl, runtimeSeconds: $runtimeSeconds, resumePositionSeconds: $resumePositionSeconds, isFavorite: $isFavorite, year: $year, genres: $genres, mediaType: $mediaType, streamUrl: $streamUrl, mediaSourceId: $mediaSourceId, playSessionId: $playSessionId, seriesSeasons: $seriesSeasons)';
}


}

/// @nodoc
abstract mixin class $MediaDetailCopyWith<$Res>  {
  factory $MediaDetailCopyWith(MediaDetail value, $Res Function(MediaDetail) _then) = _$MediaDetailCopyWithImpl;
@useResult
$Res call({
 String id, String serverId, String title, String overview, String? posterImageUrl, String? backdropImageUrl, String? thumbImageUrl, int runtimeSeconds, int resumePositionSeconds, bool isFavorite, int? year, List<String> genres, String mediaType, String streamUrl, String? mediaSourceId, String? playSessionId, List<SeriesSeasonSummary> seriesSeasons
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serverId = null,Object? title = null,Object? overview = null,Object? posterImageUrl = freezed,Object? backdropImageUrl = freezed,Object? thumbImageUrl = freezed,Object? runtimeSeconds = null,Object? resumePositionSeconds = null,Object? isFavorite = null,Object? year = freezed,Object? genres = null,Object? mediaType = null,Object? streamUrl = null,Object? mediaSourceId = freezed,Object? playSessionId = freezed,Object? seriesSeasons = null,}) {
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
as String?,seriesSeasons: null == seriesSeasons ? _self.seriesSeasons : seriesSeasons // ignore: cast_nullable_to_non_nullable
as List<SeriesSeasonSummary>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serverId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  int resumePositionSeconds,  bool isFavorite,  int? year,  List<String> genres,  String mediaType,  String streamUrl,  String? mediaSourceId,  String? playSessionId,  List<SeriesSeasonSummary> seriesSeasons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaDetail() when $default != null:
return $default(_that.id,_that.serverId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.resumePositionSeconds,_that.isFavorite,_that.year,_that.genres,_that.mediaType,_that.streamUrl,_that.mediaSourceId,_that.playSessionId,_that.seriesSeasons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serverId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  int resumePositionSeconds,  bool isFavorite,  int? year,  List<String> genres,  String mediaType,  String streamUrl,  String? mediaSourceId,  String? playSessionId,  List<SeriesSeasonSummary> seriesSeasons)  $default,) {final _that = this;
switch (_that) {
case _MediaDetail():
return $default(_that.id,_that.serverId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.resumePositionSeconds,_that.isFavorite,_that.year,_that.genres,_that.mediaType,_that.streamUrl,_that.mediaSourceId,_that.playSessionId,_that.seriesSeasons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serverId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  int resumePositionSeconds,  bool isFavorite,  int? year,  List<String> genres,  String mediaType,  String streamUrl,  String? mediaSourceId,  String? playSessionId,  List<SeriesSeasonSummary> seriesSeasons)?  $default,) {final _that = this;
switch (_that) {
case _MediaDetail() when $default != null:
return $default(_that.id,_that.serverId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.resumePositionSeconds,_that.isFavorite,_that.year,_that.genres,_that.mediaType,_that.streamUrl,_that.mediaSourceId,_that.playSessionId,_that.seriesSeasons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaDetail extends MediaDetail {
  const _MediaDetail({required this.id, required this.serverId, required this.title, required this.overview, this.posterImageUrl, this.backdropImageUrl, this.thumbImageUrl, this.runtimeSeconds = 0, this.resumePositionSeconds = 0, this.isFavorite = false, this.year, final  List<String> genres = const <String>[], required this.mediaType, required this.streamUrl, this.mediaSourceId, this.playSessionId, final  List<SeriesSeasonSummary> seriesSeasons = const <SeriesSeasonSummary>[]}): _genres = genres,_seriesSeasons = seriesSeasons,super._();
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
 final  List<SeriesSeasonSummary> _seriesSeasons;
@override@JsonKey() List<SeriesSeasonSummary> get seriesSeasons {
  if (_seriesSeasons is EqualUnmodifiableListView) return _seriesSeasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seriesSeasons);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.backdropImageUrl, backdropImageUrl) || other.backdropImageUrl == backdropImageUrl)&&(identical(other.thumbImageUrl, thumbImageUrl) || other.thumbImageUrl == thumbImageUrl)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.resumePositionSeconds, resumePositionSeconds) || other.resumePositionSeconds == resumePositionSeconds)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId)&&const DeepCollectionEquality().equals(other._seriesSeasons, _seriesSeasons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,title,overview,posterImageUrl,backdropImageUrl,thumbImageUrl,runtimeSeconds,resumePositionSeconds,isFavorite,year,const DeepCollectionEquality().hash(_genres),mediaType,streamUrl,mediaSourceId,playSessionId,const DeepCollectionEquality().hash(_seriesSeasons));

@override
String toString() {
  return 'MediaDetail(id: $id, serverId: $serverId, title: $title, overview: $overview, posterImageUrl: $posterImageUrl, backdropImageUrl: $backdropImageUrl, thumbImageUrl: $thumbImageUrl, runtimeSeconds: $runtimeSeconds, resumePositionSeconds: $resumePositionSeconds, isFavorite: $isFavorite, year: $year, genres: $genres, mediaType: $mediaType, streamUrl: $streamUrl, mediaSourceId: $mediaSourceId, playSessionId: $playSessionId, seriesSeasons: $seriesSeasons)';
}


}

/// @nodoc
abstract mixin class _$MediaDetailCopyWith<$Res> implements $MediaDetailCopyWith<$Res> {
  factory _$MediaDetailCopyWith(_MediaDetail value, $Res Function(_MediaDetail) _then) = __$MediaDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String serverId, String title, String overview, String? posterImageUrl, String? backdropImageUrl, String? thumbImageUrl, int runtimeSeconds, int resumePositionSeconds, bool isFavorite, int? year, List<String> genres, String mediaType, String streamUrl, String? mediaSourceId, String? playSessionId, List<SeriesSeasonSummary> seriesSeasons
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serverId = null,Object? title = null,Object? overview = null,Object? posterImageUrl = freezed,Object? backdropImageUrl = freezed,Object? thumbImageUrl = freezed,Object? runtimeSeconds = null,Object? resumePositionSeconds = null,Object? isFavorite = null,Object? year = freezed,Object? genres = null,Object? mediaType = null,Object? streamUrl = null,Object? mediaSourceId = freezed,Object? playSessionId = freezed,Object? seriesSeasons = null,}) {
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
as String?,seriesSeasons: null == seriesSeasons ? _self._seriesSeasons : seriesSeasons // ignore: cast_nullable_to_non_nullable
as List<SeriesSeasonSummary>,
  ));
}


}


/// @nodoc
mixin _$SeriesSeasonSummary {

 String get id; String get title; int? get seasonNumber; String? get imageUrl; List<SeriesEpisodeSummary> get episodes;
/// Create a copy of SeriesSeasonSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeriesSeasonSummaryCopyWith<SeriesSeasonSummary> get copyWith => _$SeriesSeasonSummaryCopyWithImpl<SeriesSeasonSummary>(this as SeriesSeasonSummary, _$identity);

  /// Serializes this SeriesSeasonSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeriesSeasonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.episodes, episodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,seasonNumber,imageUrl,const DeepCollectionEquality().hash(episodes));

@override
String toString() {
  return 'SeriesSeasonSummary(id: $id, title: $title, seasonNumber: $seasonNumber, imageUrl: $imageUrl, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class $SeriesSeasonSummaryCopyWith<$Res>  {
  factory $SeriesSeasonSummaryCopyWith(SeriesSeasonSummary value, $Res Function(SeriesSeasonSummary) _then) = _$SeriesSeasonSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, int? seasonNumber, String? imageUrl, List<SeriesEpisodeSummary> episodes
});




}
/// @nodoc
class _$SeriesSeasonSummaryCopyWithImpl<$Res>
    implements $SeriesSeasonSummaryCopyWith<$Res> {
  _$SeriesSeasonSummaryCopyWithImpl(this._self, this._then);

  final SeriesSeasonSummary _self;
  final $Res Function(SeriesSeasonSummary) _then;

/// Create a copy of SeriesSeasonSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? seasonNumber = freezed,Object? imageUrl = freezed,Object? episodes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,episodes: null == episodes ? _self.episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<SeriesEpisodeSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [SeriesSeasonSummary].
extension SeriesSeasonSummaryPatterns on SeriesSeasonSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeriesSeasonSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeriesSeasonSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeriesSeasonSummary value)  $default,){
final _that = this;
switch (_that) {
case _SeriesSeasonSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeriesSeasonSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SeriesSeasonSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int? seasonNumber,  String? imageUrl,  List<SeriesEpisodeSummary> episodes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeriesSeasonSummary() when $default != null:
return $default(_that.id,_that.title,_that.seasonNumber,_that.imageUrl,_that.episodes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int? seasonNumber,  String? imageUrl,  List<SeriesEpisodeSummary> episodes)  $default,) {final _that = this;
switch (_that) {
case _SeriesSeasonSummary():
return $default(_that.id,_that.title,_that.seasonNumber,_that.imageUrl,_that.episodes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int? seasonNumber,  String? imageUrl,  List<SeriesEpisodeSummary> episodes)?  $default,) {final _that = this;
switch (_that) {
case _SeriesSeasonSummary() when $default != null:
return $default(_that.id,_that.title,_that.seasonNumber,_that.imageUrl,_that.episodes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeriesSeasonSummary extends SeriesSeasonSummary {
  const _SeriesSeasonSummary({required this.id, required this.title, this.seasonNumber, this.imageUrl, final  List<SeriesEpisodeSummary> episodes = const <SeriesEpisodeSummary>[]}): _episodes = episodes,super._();
  factory _SeriesSeasonSummary.fromJson(Map<String, dynamic> json) => _$SeriesSeasonSummaryFromJson(json);

@override final  String id;
@override final  String title;
@override final  int? seasonNumber;
@override final  String? imageUrl;
 final  List<SeriesEpisodeSummary> _episodes;
@override@JsonKey() List<SeriesEpisodeSummary> get episodes {
  if (_episodes is EqualUnmodifiableListView) return _episodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodes);
}


/// Create a copy of SeriesSeasonSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeriesSeasonSummaryCopyWith<_SeriesSeasonSummary> get copyWith => __$SeriesSeasonSummaryCopyWithImpl<_SeriesSeasonSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeriesSeasonSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeriesSeasonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._episodes, _episodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,seasonNumber,imageUrl,const DeepCollectionEquality().hash(_episodes));

@override
String toString() {
  return 'SeriesSeasonSummary(id: $id, title: $title, seasonNumber: $seasonNumber, imageUrl: $imageUrl, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class _$SeriesSeasonSummaryCopyWith<$Res> implements $SeriesSeasonSummaryCopyWith<$Res> {
  factory _$SeriesSeasonSummaryCopyWith(_SeriesSeasonSummary value, $Res Function(_SeriesSeasonSummary) _then) = __$SeriesSeasonSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int? seasonNumber, String? imageUrl, List<SeriesEpisodeSummary> episodes
});




}
/// @nodoc
class __$SeriesSeasonSummaryCopyWithImpl<$Res>
    implements _$SeriesSeasonSummaryCopyWith<$Res> {
  __$SeriesSeasonSummaryCopyWithImpl(this._self, this._then);

  final _SeriesSeasonSummary _self;
  final $Res Function(_SeriesSeasonSummary) _then;

/// Create a copy of SeriesSeasonSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? seasonNumber = freezed,Object? imageUrl = freezed,Object? episodes = null,}) {
  return _then(_SeriesSeasonSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,episodes: null == episodes ? _self._episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<SeriesEpisodeSummary>,
  ));
}


}


/// @nodoc
mixin _$SeriesEpisodeSummary {

 String get id; String get serverId; String get seasonId; String get title; String get overview; String? get posterImageUrl; String? get backdropImageUrl; String? get thumbImageUrl; int get runtimeSeconds; double get progress; bool get isFavorite; bool get isResumable; int? get seasonNumber; int? get episodeNumber; DateTime? get lastPlayedAt; DateTime? get premiereDate;
/// Create a copy of SeriesEpisodeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeriesEpisodeSummaryCopyWith<SeriesEpisodeSummary> get copyWith => _$SeriesEpisodeSummaryCopyWithImpl<SeriesEpisodeSummary>(this as SeriesEpisodeSummary, _$identity);

  /// Serializes this SeriesEpisodeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeriesEpisodeSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.backdropImageUrl, backdropImageUrl) || other.backdropImageUrl == backdropImageUrl)&&(identical(other.thumbImageUrl, thumbImageUrl) || other.thumbImageUrl == thumbImageUrl)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isResumable, isResumable) || other.isResumable == isResumable)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.episodeNumber, episodeNumber) || other.episodeNumber == episodeNumber)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt)&&(identical(other.premiereDate, premiereDate) || other.premiereDate == premiereDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,seasonId,title,overview,posterImageUrl,backdropImageUrl,thumbImageUrl,runtimeSeconds,progress,isFavorite,isResumable,seasonNumber,episodeNumber,lastPlayedAt,premiereDate);

@override
String toString() {
  return 'SeriesEpisodeSummary(id: $id, serverId: $serverId, seasonId: $seasonId, title: $title, overview: $overview, posterImageUrl: $posterImageUrl, backdropImageUrl: $backdropImageUrl, thumbImageUrl: $thumbImageUrl, runtimeSeconds: $runtimeSeconds, progress: $progress, isFavorite: $isFavorite, isResumable: $isResumable, seasonNumber: $seasonNumber, episodeNumber: $episodeNumber, lastPlayedAt: $lastPlayedAt, premiereDate: $premiereDate)';
}


}

/// @nodoc
abstract mixin class $SeriesEpisodeSummaryCopyWith<$Res>  {
  factory $SeriesEpisodeSummaryCopyWith(SeriesEpisodeSummary value, $Res Function(SeriesEpisodeSummary) _then) = _$SeriesEpisodeSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String serverId, String seasonId, String title, String overview, String? posterImageUrl, String? backdropImageUrl, String? thumbImageUrl, int runtimeSeconds, double progress, bool isFavorite, bool isResumable, int? seasonNumber, int? episodeNumber, DateTime? lastPlayedAt, DateTime? premiereDate
});




}
/// @nodoc
class _$SeriesEpisodeSummaryCopyWithImpl<$Res>
    implements $SeriesEpisodeSummaryCopyWith<$Res> {
  _$SeriesEpisodeSummaryCopyWithImpl(this._self, this._then);

  final SeriesEpisodeSummary _self;
  final $Res Function(SeriesEpisodeSummary) _then;

/// Create a copy of SeriesEpisodeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serverId = null,Object? seasonId = null,Object? title = null,Object? overview = null,Object? posterImageUrl = freezed,Object? backdropImageUrl = freezed,Object? thumbImageUrl = freezed,Object? runtimeSeconds = null,Object? progress = null,Object? isFavorite = null,Object? isResumable = null,Object? seasonNumber = freezed,Object? episodeNumber = freezed,Object? lastPlayedAt = freezed,Object? premiereDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterImageUrl: freezed == posterImageUrl ? _self.posterImageUrl : posterImageUrl // ignore: cast_nullable_to_non_nullable
as String?,backdropImageUrl: freezed == backdropImageUrl ? _self.backdropImageUrl : backdropImageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbImageUrl: freezed == thumbImageUrl ? _self.thumbImageUrl : thumbImageUrl // ignore: cast_nullable_to_non_nullable
as String?,runtimeSeconds: null == runtimeSeconds ? _self.runtimeSeconds : runtimeSeconds // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isResumable: null == isResumable ? _self.isResumable : isResumable // ignore: cast_nullable_to_non_nullable
as bool,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,episodeNumber: freezed == episodeNumber ? _self.episodeNumber : episodeNumber // ignore: cast_nullable_to_non_nullable
as int?,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,premiereDate: freezed == premiereDate ? _self.premiereDate : premiereDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeriesEpisodeSummary].
extension SeriesEpisodeSummaryPatterns on SeriesEpisodeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeriesEpisodeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeriesEpisodeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeriesEpisodeSummary value)  $default,){
final _that = this;
switch (_that) {
case _SeriesEpisodeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeriesEpisodeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SeriesEpisodeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serverId,  String seasonId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  double progress,  bool isFavorite,  bool isResumable,  int? seasonNumber,  int? episodeNumber,  DateTime? lastPlayedAt,  DateTime? premiereDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeriesEpisodeSummary() when $default != null:
return $default(_that.id,_that.serverId,_that.seasonId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.progress,_that.isFavorite,_that.isResumable,_that.seasonNumber,_that.episodeNumber,_that.lastPlayedAt,_that.premiereDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serverId,  String seasonId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  double progress,  bool isFavorite,  bool isResumable,  int? seasonNumber,  int? episodeNumber,  DateTime? lastPlayedAt,  DateTime? premiereDate)  $default,) {final _that = this;
switch (_that) {
case _SeriesEpisodeSummary():
return $default(_that.id,_that.serverId,_that.seasonId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.progress,_that.isFavorite,_that.isResumable,_that.seasonNumber,_that.episodeNumber,_that.lastPlayedAt,_that.premiereDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serverId,  String seasonId,  String title,  String overview,  String? posterImageUrl,  String? backdropImageUrl,  String? thumbImageUrl,  int runtimeSeconds,  double progress,  bool isFavorite,  bool isResumable,  int? seasonNumber,  int? episodeNumber,  DateTime? lastPlayedAt,  DateTime? premiereDate)?  $default,) {final _that = this;
switch (_that) {
case _SeriesEpisodeSummary() when $default != null:
return $default(_that.id,_that.serverId,_that.seasonId,_that.title,_that.overview,_that.posterImageUrl,_that.backdropImageUrl,_that.thumbImageUrl,_that.runtimeSeconds,_that.progress,_that.isFavorite,_that.isResumable,_that.seasonNumber,_that.episodeNumber,_that.lastPlayedAt,_that.premiereDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeriesEpisodeSummary extends SeriesEpisodeSummary {
  const _SeriesEpisodeSummary({required this.id, required this.serverId, required this.seasonId, required this.title, required this.overview, this.posterImageUrl, this.backdropImageUrl, this.thumbImageUrl, this.runtimeSeconds = 0, this.progress = 0, this.isFavorite = false, this.isResumable = false, this.seasonNumber, this.episodeNumber, this.lastPlayedAt, this.premiereDate}): super._();
  factory _SeriesEpisodeSummary.fromJson(Map<String, dynamic> json) => _$SeriesEpisodeSummaryFromJson(json);

@override final  String id;
@override final  String serverId;
@override final  String seasonId;
@override final  String title;
@override final  String overview;
@override final  String? posterImageUrl;
@override final  String? backdropImageUrl;
@override final  String? thumbImageUrl;
@override@JsonKey() final  int runtimeSeconds;
@override@JsonKey() final  double progress;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  bool isResumable;
@override final  int? seasonNumber;
@override final  int? episodeNumber;
@override final  DateTime? lastPlayedAt;
@override final  DateTime? premiereDate;

/// Create a copy of SeriesEpisodeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeriesEpisodeSummaryCopyWith<_SeriesEpisodeSummary> get copyWith => __$SeriesEpisodeSummaryCopyWithImpl<_SeriesEpisodeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeriesEpisodeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeriesEpisodeSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.posterImageUrl, posterImageUrl) || other.posterImageUrl == posterImageUrl)&&(identical(other.backdropImageUrl, backdropImageUrl) || other.backdropImageUrl == backdropImageUrl)&&(identical(other.thumbImageUrl, thumbImageUrl) || other.thumbImageUrl == thumbImageUrl)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isResumable, isResumable) || other.isResumable == isResumable)&&(identical(other.seasonNumber, seasonNumber) || other.seasonNumber == seasonNumber)&&(identical(other.episodeNumber, episodeNumber) || other.episodeNumber == episodeNumber)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt)&&(identical(other.premiereDate, premiereDate) || other.premiereDate == premiereDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,seasonId,title,overview,posterImageUrl,backdropImageUrl,thumbImageUrl,runtimeSeconds,progress,isFavorite,isResumable,seasonNumber,episodeNumber,lastPlayedAt,premiereDate);

@override
String toString() {
  return 'SeriesEpisodeSummary(id: $id, serverId: $serverId, seasonId: $seasonId, title: $title, overview: $overview, posterImageUrl: $posterImageUrl, backdropImageUrl: $backdropImageUrl, thumbImageUrl: $thumbImageUrl, runtimeSeconds: $runtimeSeconds, progress: $progress, isFavorite: $isFavorite, isResumable: $isResumable, seasonNumber: $seasonNumber, episodeNumber: $episodeNumber, lastPlayedAt: $lastPlayedAt, premiereDate: $premiereDate)';
}


}

/// @nodoc
abstract mixin class _$SeriesEpisodeSummaryCopyWith<$Res> implements $SeriesEpisodeSummaryCopyWith<$Res> {
  factory _$SeriesEpisodeSummaryCopyWith(_SeriesEpisodeSummary value, $Res Function(_SeriesEpisodeSummary) _then) = __$SeriesEpisodeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String serverId, String seasonId, String title, String overview, String? posterImageUrl, String? backdropImageUrl, String? thumbImageUrl, int runtimeSeconds, double progress, bool isFavorite, bool isResumable, int? seasonNumber, int? episodeNumber, DateTime? lastPlayedAt, DateTime? premiereDate
});




}
/// @nodoc
class __$SeriesEpisodeSummaryCopyWithImpl<$Res>
    implements _$SeriesEpisodeSummaryCopyWith<$Res> {
  __$SeriesEpisodeSummaryCopyWithImpl(this._self, this._then);

  final _SeriesEpisodeSummary _self;
  final $Res Function(_SeriesEpisodeSummary) _then;

/// Create a copy of SeriesEpisodeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serverId = null,Object? seasonId = null,Object? title = null,Object? overview = null,Object? posterImageUrl = freezed,Object? backdropImageUrl = freezed,Object? thumbImageUrl = freezed,Object? runtimeSeconds = null,Object? progress = null,Object? isFavorite = null,Object? isResumable = null,Object? seasonNumber = freezed,Object? episodeNumber = freezed,Object? lastPlayedAt = freezed,Object? premiereDate = freezed,}) {
  return _then(_SeriesEpisodeSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,seasonId: null == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,posterImageUrl: freezed == posterImageUrl ? _self.posterImageUrl : posterImageUrl // ignore: cast_nullable_to_non_nullable
as String?,backdropImageUrl: freezed == backdropImageUrl ? _self.backdropImageUrl : backdropImageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbImageUrl: freezed == thumbImageUrl ? _self.thumbImageUrl : thumbImageUrl // ignore: cast_nullable_to_non_nullable
as String?,runtimeSeconds: null == runtimeSeconds ? _self.runtimeSeconds : runtimeSeconds // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isResumable: null == isResumable ? _self.isResumable : isResumable // ignore: cast_nullable_to_non_nullable
as bool,seasonNumber: freezed == seasonNumber ? _self.seasonNumber : seasonNumber // ignore: cast_nullable_to_non_nullable
as int?,episodeNumber: freezed == episodeNumber ? _self.episodeNumber : episodeNumber // ignore: cast_nullable_to_non_nullable
as int?,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,premiereDate: freezed == premiereDate ? _self.premiereDate : premiereDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
