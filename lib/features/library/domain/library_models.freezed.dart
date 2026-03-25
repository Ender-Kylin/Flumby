// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibrarySummary {

 String get id; String get serverId; String get title; String get type; int get itemCount;
/// Create a copy of LibrarySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibrarySummaryCopyWith<LibrarySummary> get copyWith => _$LibrarySummaryCopyWithImpl<LibrarySummary>(this as LibrarySummary, _$identity);

  /// Serializes this LibrarySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibrarySummary&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,title,type,itemCount);

@override
String toString() {
  return 'LibrarySummary(id: $id, serverId: $serverId, title: $title, type: $type, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class $LibrarySummaryCopyWith<$Res>  {
  factory $LibrarySummaryCopyWith(LibrarySummary value, $Res Function(LibrarySummary) _then) = _$LibrarySummaryCopyWithImpl;
@useResult
$Res call({
 String id, String serverId, String title, String type, int itemCount
});




}
/// @nodoc
class _$LibrarySummaryCopyWithImpl<$Res>
    implements $LibrarySummaryCopyWith<$Res> {
  _$LibrarySummaryCopyWithImpl(this._self, this._then);

  final LibrarySummary _self;
  final $Res Function(LibrarySummary) _then;

/// Create a copy of LibrarySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serverId = null,Object? title = null,Object? type = null,Object? itemCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LibrarySummary].
extension LibrarySummaryPatterns on LibrarySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibrarySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibrarySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibrarySummary value)  $default,){
final _that = this;
switch (_that) {
case _LibrarySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibrarySummary value)?  $default,){
final _that = this;
switch (_that) {
case _LibrarySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serverId,  String title,  String type,  int itemCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibrarySummary() when $default != null:
return $default(_that.id,_that.serverId,_that.title,_that.type,_that.itemCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serverId,  String title,  String type,  int itemCount)  $default,) {final _that = this;
switch (_that) {
case _LibrarySummary():
return $default(_that.id,_that.serverId,_that.title,_that.type,_that.itemCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serverId,  String title,  String type,  int itemCount)?  $default,) {final _that = this;
switch (_that) {
case _LibrarySummary() when $default != null:
return $default(_that.id,_that.serverId,_that.title,_that.type,_that.itemCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LibrarySummary implements LibrarySummary {
  const _LibrarySummary({required this.id, required this.serverId, required this.title, required this.type, this.itemCount = 0});
  factory _LibrarySummary.fromJson(Map<String, dynamic> json) => _$LibrarySummaryFromJson(json);

@override final  String id;
@override final  String serverId;
@override final  String title;
@override final  String type;
@override@JsonKey() final  int itemCount;

/// Create a copy of LibrarySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibrarySummaryCopyWith<_LibrarySummary> get copyWith => __$LibrarySummaryCopyWithImpl<_LibrarySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LibrarySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibrarySummary&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,title,type,itemCount);

@override
String toString() {
  return 'LibrarySummary(id: $id, serverId: $serverId, title: $title, type: $type, itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class _$LibrarySummaryCopyWith<$Res> implements $LibrarySummaryCopyWith<$Res> {
  factory _$LibrarySummaryCopyWith(_LibrarySummary value, $Res Function(_LibrarySummary) _then) = __$LibrarySummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String serverId, String title, String type, int itemCount
});




}
/// @nodoc
class __$LibrarySummaryCopyWithImpl<$Res>
    implements _$LibrarySummaryCopyWith<$Res> {
  __$LibrarySummaryCopyWithImpl(this._self, this._then);

  final _LibrarySummary _self;
  final $Res Function(_LibrarySummary) _then;

/// Create a copy of LibrarySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serverId = null,Object? title = null,Object? type = null,Object? itemCount = null,}) {
  return _then(_LibrarySummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MediaItemSummary {

 String get id; String get serverId; String get libraryId; String get title; String get overview; int get runtimeSeconds; double get progress; bool get isFavorite; bool get isResumable; int? get year;
/// Create a copy of MediaItemSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaItemSummaryCopyWith<MediaItemSummary> get copyWith => _$MediaItemSummaryCopyWithImpl<MediaItemSummary>(this as MediaItemSummary, _$identity);

  /// Serializes this MediaItemSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaItemSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.libraryId, libraryId) || other.libraryId == libraryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isResumable, isResumable) || other.isResumable == isResumable)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,libraryId,title,overview,runtimeSeconds,progress,isFavorite,isResumable,year);

@override
String toString() {
  return 'MediaItemSummary(id: $id, serverId: $serverId, libraryId: $libraryId, title: $title, overview: $overview, runtimeSeconds: $runtimeSeconds, progress: $progress, isFavorite: $isFavorite, isResumable: $isResumable, year: $year)';
}


}

/// @nodoc
abstract mixin class $MediaItemSummaryCopyWith<$Res>  {
  factory $MediaItemSummaryCopyWith(MediaItemSummary value, $Res Function(MediaItemSummary) _then) = _$MediaItemSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String serverId, String libraryId, String title, String overview, int runtimeSeconds, double progress, bool isFavorite, bool isResumable, int? year
});




}
/// @nodoc
class _$MediaItemSummaryCopyWithImpl<$Res>
    implements $MediaItemSummaryCopyWith<$Res> {
  _$MediaItemSummaryCopyWithImpl(this._self, this._then);

  final MediaItemSummary _self;
  final $Res Function(MediaItemSummary) _then;

/// Create a copy of MediaItemSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serverId = null,Object? libraryId = null,Object? title = null,Object? overview = null,Object? runtimeSeconds = null,Object? progress = null,Object? isFavorite = null,Object? isResumable = null,Object? year = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,libraryId: null == libraryId ? _self.libraryId : libraryId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,runtimeSeconds: null == runtimeSeconds ? _self.runtimeSeconds : runtimeSeconds // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isResumable: null == isResumable ? _self.isResumable : isResumable // ignore: cast_nullable_to_non_nullable
as bool,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaItemSummary].
extension MediaItemSummaryPatterns on MediaItemSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaItemSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaItemSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaItemSummary value)  $default,){
final _that = this;
switch (_that) {
case _MediaItemSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaItemSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MediaItemSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String serverId,  String libraryId,  String title,  String overview,  int runtimeSeconds,  double progress,  bool isFavorite,  bool isResumable,  int? year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaItemSummary() when $default != null:
return $default(_that.id,_that.serverId,_that.libraryId,_that.title,_that.overview,_that.runtimeSeconds,_that.progress,_that.isFavorite,_that.isResumable,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String serverId,  String libraryId,  String title,  String overview,  int runtimeSeconds,  double progress,  bool isFavorite,  bool isResumable,  int? year)  $default,) {final _that = this;
switch (_that) {
case _MediaItemSummary():
return $default(_that.id,_that.serverId,_that.libraryId,_that.title,_that.overview,_that.runtimeSeconds,_that.progress,_that.isFavorite,_that.isResumable,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String serverId,  String libraryId,  String title,  String overview,  int runtimeSeconds,  double progress,  bool isFavorite,  bool isResumable,  int? year)?  $default,) {final _that = this;
switch (_that) {
case _MediaItemSummary() when $default != null:
return $default(_that.id,_that.serverId,_that.libraryId,_that.title,_that.overview,_that.runtimeSeconds,_that.progress,_that.isFavorite,_that.isResumable,_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaItemSummary extends MediaItemSummary {
  const _MediaItemSummary({required this.id, required this.serverId, required this.libraryId, required this.title, required this.overview, this.runtimeSeconds = 0, this.progress = 0, this.isFavorite = false, this.isResumable = false, this.year}): super._();
  factory _MediaItemSummary.fromJson(Map<String, dynamic> json) => _$MediaItemSummaryFromJson(json);

@override final  String id;
@override final  String serverId;
@override final  String libraryId;
@override final  String title;
@override final  String overview;
@override@JsonKey() final  int runtimeSeconds;
@override@JsonKey() final  double progress;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  bool isResumable;
@override final  int? year;

/// Create a copy of MediaItemSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaItemSummaryCopyWith<_MediaItemSummary> get copyWith => __$MediaItemSummaryCopyWithImpl<_MediaItemSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaItemSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaItemSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.libraryId, libraryId) || other.libraryId == libraryId)&&(identical(other.title, title) || other.title == title)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.runtimeSeconds, runtimeSeconds) || other.runtimeSeconds == runtimeSeconds)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isResumable, isResumable) || other.isResumable == isResumable)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serverId,libraryId,title,overview,runtimeSeconds,progress,isFavorite,isResumable,year);

@override
String toString() {
  return 'MediaItemSummary(id: $id, serverId: $serverId, libraryId: $libraryId, title: $title, overview: $overview, runtimeSeconds: $runtimeSeconds, progress: $progress, isFavorite: $isFavorite, isResumable: $isResumable, year: $year)';
}


}

/// @nodoc
abstract mixin class _$MediaItemSummaryCopyWith<$Res> implements $MediaItemSummaryCopyWith<$Res> {
  factory _$MediaItemSummaryCopyWith(_MediaItemSummary value, $Res Function(_MediaItemSummary) _then) = __$MediaItemSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String serverId, String libraryId, String title, String overview, int runtimeSeconds, double progress, bool isFavorite, bool isResumable, int? year
});




}
/// @nodoc
class __$MediaItemSummaryCopyWithImpl<$Res>
    implements _$MediaItemSummaryCopyWith<$Res> {
  __$MediaItemSummaryCopyWithImpl(this._self, this._then);

  final _MediaItemSummary _self;
  final $Res Function(_MediaItemSummary) _then;

/// Create a copy of MediaItemSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serverId = null,Object? libraryId = null,Object? title = null,Object? overview = null,Object? runtimeSeconds = null,Object? progress = null,Object? isFavorite = null,Object? isResumable = null,Object? year = freezed,}) {
  return _then(_MediaItemSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,libraryId: null == libraryId ? _self.libraryId : libraryId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,overview: null == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String,runtimeSeconds: null == runtimeSeconds ? _self.runtimeSeconds : runtimeSeconds // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isResumable: null == isResumable ? _self.isResumable : isResumable // ignore: cast_nullable_to_non_nullable
as bool,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
