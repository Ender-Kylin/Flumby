// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_snapshot_v1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncServerRecord {

 String get id; String get name; String get baseUrl; String get type; String? get username;@DateTimeIso8601Converter() DateTime get updatedAt; String get deviceId;
/// Create a copy of SyncServerRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncServerRecordCopyWith<SyncServerRecord> get copyWith => _$SyncServerRecordCopyWithImpl<SyncServerRecord>(this as SyncServerRecord, _$identity);

  /// Serializes this SyncServerRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncServerRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.username, username) || other.username == username)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,baseUrl,type,username,updatedAt,deviceId);

@override
String toString() {
  return 'SyncServerRecord(id: $id, name: $name, baseUrl: $baseUrl, type: $type, username: $username, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SyncServerRecordCopyWith<$Res>  {
  factory $SyncServerRecordCopyWith(SyncServerRecord value, $Res Function(SyncServerRecord) _then) = _$SyncServerRecordCopyWithImpl;
@useResult
$Res call({
 String id, String name, String baseUrl, String type, String? username,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class _$SyncServerRecordCopyWithImpl<$Res>
    implements $SyncServerRecordCopyWith<$Res> {
  _$SyncServerRecordCopyWithImpl(this._self, this._then);

  final SyncServerRecord _self;
  final $Res Function(SyncServerRecord) _then;

/// Create a copy of SyncServerRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? baseUrl = null,Object? type = null,Object? username = freezed,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncServerRecord].
extension SyncServerRecordPatterns on SyncServerRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncServerRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncServerRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncServerRecord value)  $default,){
final _that = this;
switch (_that) {
case _SyncServerRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncServerRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SyncServerRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String baseUrl,  String type,  String? username, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncServerRecord() when $default != null:
return $default(_that.id,_that.name,_that.baseUrl,_that.type,_that.username,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String baseUrl,  String type,  String? username, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _SyncServerRecord():
return $default(_that.id,_that.name,_that.baseUrl,_that.type,_that.username,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String baseUrl,  String type,  String? username, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _SyncServerRecord() when $default != null:
return $default(_that.id,_that.name,_that.baseUrl,_that.type,_that.username,_that.updatedAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncServerRecord implements SyncServerRecord {
  const _SyncServerRecord({required this.id, required this.name, required this.baseUrl, required this.type, this.username, @DateTimeIso8601Converter() required this.updatedAt, required this.deviceId});
  factory _SyncServerRecord.fromJson(Map<String, dynamic> json) => _$SyncServerRecordFromJson(json);

@override final  String id;
@override final  String name;
@override final  String baseUrl;
@override final  String type;
@override final  String? username;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;
@override final  String deviceId;

/// Create a copy of SyncServerRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncServerRecordCopyWith<_SyncServerRecord> get copyWith => __$SyncServerRecordCopyWithImpl<_SyncServerRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncServerRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncServerRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.username, username) || other.username == username)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,baseUrl,type,username,updatedAt,deviceId);

@override
String toString() {
  return 'SyncServerRecord(id: $id, name: $name, baseUrl: $baseUrl, type: $type, username: $username, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$SyncServerRecordCopyWith<$Res> implements $SyncServerRecordCopyWith<$Res> {
  factory _$SyncServerRecordCopyWith(_SyncServerRecord value, $Res Function(_SyncServerRecord) _then) = __$SyncServerRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String baseUrl, String type, String? username,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class __$SyncServerRecordCopyWithImpl<$Res>
    implements _$SyncServerRecordCopyWith<$Res> {
  __$SyncServerRecordCopyWithImpl(this._self, this._then);

  final _SyncServerRecord _self;
  final $Res Function(_SyncServerRecord) _then;

/// Create a copy of SyncServerRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? baseUrl = null,Object? type = null,Object? username = freezed,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_SyncServerRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SyncPreferenceRecord {

 String get key; String get value;@DateTimeIso8601Converter() DateTime get updatedAt; String get deviceId;
/// Create a copy of SyncPreferenceRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncPreferenceRecordCopyWith<SyncPreferenceRecord> get copyWith => _$SyncPreferenceRecordCopyWithImpl<SyncPreferenceRecord>(this as SyncPreferenceRecord, _$identity);

  /// Serializes this SyncPreferenceRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncPreferenceRecord&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,value,updatedAt,deviceId);

@override
String toString() {
  return 'SyncPreferenceRecord(key: $key, value: $value, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SyncPreferenceRecordCopyWith<$Res>  {
  factory $SyncPreferenceRecordCopyWith(SyncPreferenceRecord value, $Res Function(SyncPreferenceRecord) _then) = _$SyncPreferenceRecordCopyWithImpl;
@useResult
$Res call({
 String key, String value,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class _$SyncPreferenceRecordCopyWithImpl<$Res>
    implements $SyncPreferenceRecordCopyWith<$Res> {
  _$SyncPreferenceRecordCopyWithImpl(this._self, this._then);

  final SyncPreferenceRecord _self;
  final $Res Function(SyncPreferenceRecord) _then;

/// Create a copy of SyncPreferenceRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? value = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncPreferenceRecord].
extension SyncPreferenceRecordPatterns on SyncPreferenceRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncPreferenceRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncPreferenceRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncPreferenceRecord value)  $default,){
final _that = this;
switch (_that) {
case _SyncPreferenceRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncPreferenceRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SyncPreferenceRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String value, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncPreferenceRecord() when $default != null:
return $default(_that.key,_that.value,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String value, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _SyncPreferenceRecord():
return $default(_that.key,_that.value,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String value, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _SyncPreferenceRecord() when $default != null:
return $default(_that.key,_that.value,_that.updatedAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncPreferenceRecord implements SyncPreferenceRecord {
  const _SyncPreferenceRecord({required this.key, required this.value, @DateTimeIso8601Converter() required this.updatedAt, required this.deviceId});
  factory _SyncPreferenceRecord.fromJson(Map<String, dynamic> json) => _$SyncPreferenceRecordFromJson(json);

@override final  String key;
@override final  String value;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;
@override final  String deviceId;

/// Create a copy of SyncPreferenceRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncPreferenceRecordCopyWith<_SyncPreferenceRecord> get copyWith => __$SyncPreferenceRecordCopyWithImpl<_SyncPreferenceRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncPreferenceRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncPreferenceRecord&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,value,updatedAt,deviceId);

@override
String toString() {
  return 'SyncPreferenceRecord(key: $key, value: $value, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$SyncPreferenceRecordCopyWith<$Res> implements $SyncPreferenceRecordCopyWith<$Res> {
  factory _$SyncPreferenceRecordCopyWith(_SyncPreferenceRecord value, $Res Function(_SyncPreferenceRecord) _then) = __$SyncPreferenceRecordCopyWithImpl;
@override @useResult
$Res call({
 String key, String value,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class __$SyncPreferenceRecordCopyWithImpl<$Res>
    implements _$SyncPreferenceRecordCopyWith<$Res> {
  __$SyncPreferenceRecordCopyWithImpl(this._self, this._then);

  final _SyncPreferenceRecord _self;
  final $Res Function(_SyncPreferenceRecord) _then;

/// Create a copy of SyncPreferenceRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_SyncPreferenceRecord(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SyncPlaybackStateRecord {

 String get serverId; String get itemId; int get positionSeconds; int get durationSeconds;@DateTimeIso8601Converter() DateTime get updatedAt; String get deviceId;
/// Create a copy of SyncPlaybackStateRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncPlaybackStateRecordCopyWith<SyncPlaybackStateRecord> get copyWith => _$SyncPlaybackStateRecordCopyWithImpl<SyncPlaybackStateRecord>(this as SyncPlaybackStateRecord, _$identity);

  /// Serializes this SyncPlaybackStateRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncPlaybackStateRecord&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.positionSeconds, positionSeconds) || other.positionSeconds == positionSeconds)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,positionSeconds,durationSeconds,updatedAt,deviceId);

@override
String toString() {
  return 'SyncPlaybackStateRecord(serverId: $serverId, itemId: $itemId, positionSeconds: $positionSeconds, durationSeconds: $durationSeconds, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SyncPlaybackStateRecordCopyWith<$Res>  {
  factory $SyncPlaybackStateRecordCopyWith(SyncPlaybackStateRecord value, $Res Function(SyncPlaybackStateRecord) _then) = _$SyncPlaybackStateRecordCopyWithImpl;
@useResult
$Res call({
 String serverId, String itemId, int positionSeconds, int durationSeconds,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class _$SyncPlaybackStateRecordCopyWithImpl<$Res>
    implements $SyncPlaybackStateRecordCopyWith<$Res> {
  _$SyncPlaybackStateRecordCopyWithImpl(this._self, this._then);

  final SyncPlaybackStateRecord _self;
  final $Res Function(SyncPlaybackStateRecord) _then;

/// Create a copy of SyncPlaybackStateRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverId = null,Object? itemId = null,Object? positionSeconds = null,Object? durationSeconds = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,positionSeconds: null == positionSeconds ? _self.positionSeconds : positionSeconds // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncPlaybackStateRecord].
extension SyncPlaybackStateRecordPatterns on SyncPlaybackStateRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncPlaybackStateRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncPlaybackStateRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncPlaybackStateRecord value)  $default,){
final _that = this;
switch (_that) {
case _SyncPlaybackStateRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncPlaybackStateRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SyncPlaybackStateRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serverId,  String itemId,  int positionSeconds,  int durationSeconds, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncPlaybackStateRecord() when $default != null:
return $default(_that.serverId,_that.itemId,_that.positionSeconds,_that.durationSeconds,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serverId,  String itemId,  int positionSeconds,  int durationSeconds, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _SyncPlaybackStateRecord():
return $default(_that.serverId,_that.itemId,_that.positionSeconds,_that.durationSeconds,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serverId,  String itemId,  int positionSeconds,  int durationSeconds, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _SyncPlaybackStateRecord() when $default != null:
return $default(_that.serverId,_that.itemId,_that.positionSeconds,_that.durationSeconds,_that.updatedAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncPlaybackStateRecord implements SyncPlaybackStateRecord {
  const _SyncPlaybackStateRecord({required this.serverId, required this.itemId, required this.positionSeconds, required this.durationSeconds, @DateTimeIso8601Converter() required this.updatedAt, required this.deviceId});
  factory _SyncPlaybackStateRecord.fromJson(Map<String, dynamic> json) => _$SyncPlaybackStateRecordFromJson(json);

@override final  String serverId;
@override final  String itemId;
@override final  int positionSeconds;
@override final  int durationSeconds;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;
@override final  String deviceId;

/// Create a copy of SyncPlaybackStateRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncPlaybackStateRecordCopyWith<_SyncPlaybackStateRecord> get copyWith => __$SyncPlaybackStateRecordCopyWithImpl<_SyncPlaybackStateRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncPlaybackStateRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncPlaybackStateRecord&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.positionSeconds, positionSeconds) || other.positionSeconds == positionSeconds)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,positionSeconds,durationSeconds,updatedAt,deviceId);

@override
String toString() {
  return 'SyncPlaybackStateRecord(serverId: $serverId, itemId: $itemId, positionSeconds: $positionSeconds, durationSeconds: $durationSeconds, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$SyncPlaybackStateRecordCopyWith<$Res> implements $SyncPlaybackStateRecordCopyWith<$Res> {
  factory _$SyncPlaybackStateRecordCopyWith(_SyncPlaybackStateRecord value, $Res Function(_SyncPlaybackStateRecord) _then) = __$SyncPlaybackStateRecordCopyWithImpl;
@override @useResult
$Res call({
 String serverId, String itemId, int positionSeconds, int durationSeconds,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class __$SyncPlaybackStateRecordCopyWithImpl<$Res>
    implements _$SyncPlaybackStateRecordCopyWith<$Res> {
  __$SyncPlaybackStateRecordCopyWithImpl(this._self, this._then);

  final _SyncPlaybackStateRecord _self;
  final $Res Function(_SyncPlaybackStateRecord) _then;

/// Create a copy of SyncPlaybackStateRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverId = null,Object? itemId = null,Object? positionSeconds = null,Object? durationSeconds = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_SyncPlaybackStateRecord(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,positionSeconds: null == positionSeconds ? _self.positionSeconds : positionSeconds // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SyncCollectionRecord {

 String get serverId; String get itemId; String get kind;@DateTimeIso8601Converter() DateTime get updatedAt; String get deviceId;
/// Create a copy of SyncCollectionRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncCollectionRecordCopyWith<SyncCollectionRecord> get copyWith => _$SyncCollectionRecordCopyWithImpl<SyncCollectionRecord>(this as SyncCollectionRecord, _$identity);

  /// Serializes this SyncCollectionRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncCollectionRecord&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,kind,updatedAt,deviceId);

@override
String toString() {
  return 'SyncCollectionRecord(serverId: $serverId, itemId: $itemId, kind: $kind, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SyncCollectionRecordCopyWith<$Res>  {
  factory $SyncCollectionRecordCopyWith(SyncCollectionRecord value, $Res Function(SyncCollectionRecord) _then) = _$SyncCollectionRecordCopyWithImpl;
@useResult
$Res call({
 String serverId, String itemId, String kind,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class _$SyncCollectionRecordCopyWithImpl<$Res>
    implements $SyncCollectionRecordCopyWith<$Res> {
  _$SyncCollectionRecordCopyWithImpl(this._self, this._then);

  final SyncCollectionRecord _self;
  final $Res Function(SyncCollectionRecord) _then;

/// Create a copy of SyncCollectionRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverId = null,Object? itemId = null,Object? kind = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncCollectionRecord].
extension SyncCollectionRecordPatterns on SyncCollectionRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncCollectionRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncCollectionRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncCollectionRecord value)  $default,){
final _that = this;
switch (_that) {
case _SyncCollectionRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncCollectionRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SyncCollectionRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serverId,  String itemId,  String kind, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncCollectionRecord() when $default != null:
return $default(_that.serverId,_that.itemId,_that.kind,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serverId,  String itemId,  String kind, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _SyncCollectionRecord():
return $default(_that.serverId,_that.itemId,_that.kind,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serverId,  String itemId,  String kind, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _SyncCollectionRecord() when $default != null:
return $default(_that.serverId,_that.itemId,_that.kind,_that.updatedAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncCollectionRecord implements SyncCollectionRecord {
  const _SyncCollectionRecord({required this.serverId, required this.itemId, required this.kind, @DateTimeIso8601Converter() required this.updatedAt, required this.deviceId});
  factory _SyncCollectionRecord.fromJson(Map<String, dynamic> json) => _$SyncCollectionRecordFromJson(json);

@override final  String serverId;
@override final  String itemId;
@override final  String kind;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;
@override final  String deviceId;

/// Create a copy of SyncCollectionRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncCollectionRecordCopyWith<_SyncCollectionRecord> get copyWith => __$SyncCollectionRecordCopyWithImpl<_SyncCollectionRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncCollectionRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncCollectionRecord&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,kind,updatedAt,deviceId);

@override
String toString() {
  return 'SyncCollectionRecord(serverId: $serverId, itemId: $itemId, kind: $kind, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$SyncCollectionRecordCopyWith<$Res> implements $SyncCollectionRecordCopyWith<$Res> {
  factory _$SyncCollectionRecordCopyWith(_SyncCollectionRecord value, $Res Function(_SyncCollectionRecord) _then) = __$SyncCollectionRecordCopyWithImpl;
@override @useResult
$Res call({
 String serverId, String itemId, String kind,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class __$SyncCollectionRecordCopyWithImpl<$Res>
    implements _$SyncCollectionRecordCopyWith<$Res> {
  __$SyncCollectionRecordCopyWithImpl(this._self, this._then);

  final _SyncCollectionRecord _self;
  final $Res Function(_SyncCollectionRecord) _then;

/// Create a copy of SyncCollectionRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverId = null,Object? itemId = null,Object? kind = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_SyncCollectionRecord(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SyncWatchHistoryRecord {

 String get serverId; String get itemId;@DateTimeIso8601Converter() DateTime get watchedAt;@DateTimeIso8601Converter() DateTime get updatedAt; String get deviceId;
/// Create a copy of SyncWatchHistoryRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncWatchHistoryRecordCopyWith<SyncWatchHistoryRecord> get copyWith => _$SyncWatchHistoryRecordCopyWithImpl<SyncWatchHistoryRecord>(this as SyncWatchHistoryRecord, _$identity);

  /// Serializes this SyncWatchHistoryRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncWatchHistoryRecord&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.watchedAt, watchedAt) || other.watchedAt == watchedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,watchedAt,updatedAt,deviceId);

@override
String toString() {
  return 'SyncWatchHistoryRecord(serverId: $serverId, itemId: $itemId, watchedAt: $watchedAt, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $SyncWatchHistoryRecordCopyWith<$Res>  {
  factory $SyncWatchHistoryRecordCopyWith(SyncWatchHistoryRecord value, $Res Function(SyncWatchHistoryRecord) _then) = _$SyncWatchHistoryRecordCopyWithImpl;
@useResult
$Res call({
 String serverId, String itemId,@DateTimeIso8601Converter() DateTime watchedAt,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class _$SyncWatchHistoryRecordCopyWithImpl<$Res>
    implements $SyncWatchHistoryRecordCopyWith<$Res> {
  _$SyncWatchHistoryRecordCopyWithImpl(this._self, this._then);

  final SyncWatchHistoryRecord _self;
  final $Res Function(SyncWatchHistoryRecord) _then;

/// Create a copy of SyncWatchHistoryRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverId = null,Object? itemId = null,Object? watchedAt = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_self.copyWith(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,watchedAt: null == watchedAt ? _self.watchedAt : watchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncWatchHistoryRecord].
extension SyncWatchHistoryRecordPatterns on SyncWatchHistoryRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncWatchHistoryRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncWatchHistoryRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncWatchHistoryRecord value)  $default,){
final _that = this;
switch (_that) {
case _SyncWatchHistoryRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncWatchHistoryRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SyncWatchHistoryRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serverId,  String itemId, @DateTimeIso8601Converter()  DateTime watchedAt, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncWatchHistoryRecord() when $default != null:
return $default(_that.serverId,_that.itemId,_that.watchedAt,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serverId,  String itemId, @DateTimeIso8601Converter()  DateTime watchedAt, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _SyncWatchHistoryRecord():
return $default(_that.serverId,_that.itemId,_that.watchedAt,_that.updatedAt,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serverId,  String itemId, @DateTimeIso8601Converter()  DateTime watchedAt, @DateTimeIso8601Converter()  DateTime updatedAt,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _SyncWatchHistoryRecord() when $default != null:
return $default(_that.serverId,_that.itemId,_that.watchedAt,_that.updatedAt,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncWatchHistoryRecord implements SyncWatchHistoryRecord {
  const _SyncWatchHistoryRecord({required this.serverId, required this.itemId, @DateTimeIso8601Converter() required this.watchedAt, @DateTimeIso8601Converter() required this.updatedAt, required this.deviceId});
  factory _SyncWatchHistoryRecord.fromJson(Map<String, dynamic> json) => _$SyncWatchHistoryRecordFromJson(json);

@override final  String serverId;
@override final  String itemId;
@override@DateTimeIso8601Converter() final  DateTime watchedAt;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;
@override final  String deviceId;

/// Create a copy of SyncWatchHistoryRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncWatchHistoryRecordCopyWith<_SyncWatchHistoryRecord> get copyWith => __$SyncWatchHistoryRecordCopyWithImpl<_SyncWatchHistoryRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncWatchHistoryRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncWatchHistoryRecord&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.watchedAt, watchedAt) || other.watchedAt == watchedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,watchedAt,updatedAt,deviceId);

@override
String toString() {
  return 'SyncWatchHistoryRecord(serverId: $serverId, itemId: $itemId, watchedAt: $watchedAt, updatedAt: $updatedAt, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$SyncWatchHistoryRecordCopyWith<$Res> implements $SyncWatchHistoryRecordCopyWith<$Res> {
  factory _$SyncWatchHistoryRecordCopyWith(_SyncWatchHistoryRecord value, $Res Function(_SyncWatchHistoryRecord) _then) = __$SyncWatchHistoryRecordCopyWithImpl;
@override @useResult
$Res call({
 String serverId, String itemId,@DateTimeIso8601Converter() DateTime watchedAt,@DateTimeIso8601Converter() DateTime updatedAt, String deviceId
});




}
/// @nodoc
class __$SyncWatchHistoryRecordCopyWithImpl<$Res>
    implements _$SyncWatchHistoryRecordCopyWith<$Res> {
  __$SyncWatchHistoryRecordCopyWithImpl(this._self, this._then);

  final _SyncWatchHistoryRecord _self;
  final $Res Function(_SyncWatchHistoryRecord) _then;

/// Create a copy of SyncWatchHistoryRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverId = null,Object? itemId = null,Object? watchedAt = null,Object? updatedAt = null,Object? deviceId = null,}) {
  return _then(_SyncWatchHistoryRecord(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,watchedAt: null == watchedAt ? _self.watchedAt : watchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SyncSnapshotV1 {

 String get schemaVersion; String get deviceId;@DateTimeIso8601Converter() DateTime get updatedAt; List<SyncServerRecord> get servers; List<SyncPreferenceRecord> get preferences; List<SyncPlaybackStateRecord> get playbackStates; List<SyncCollectionRecord> get collections; List<SyncWatchHistoryRecord> get watchHistory;
/// Create a copy of SyncSnapshotV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSnapshotV1CopyWith<SyncSnapshotV1> get copyWith => _$SyncSnapshotV1CopyWithImpl<SyncSnapshotV1>(this as SyncSnapshotV1, _$identity);

  /// Serializes this SyncSnapshotV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSnapshotV1&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.servers, servers)&&const DeepCollectionEquality().equals(other.preferences, preferences)&&const DeepCollectionEquality().equals(other.playbackStates, playbackStates)&&const DeepCollectionEquality().equals(other.collections, collections)&&const DeepCollectionEquality().equals(other.watchHistory, watchHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,deviceId,updatedAt,const DeepCollectionEquality().hash(servers),const DeepCollectionEquality().hash(preferences),const DeepCollectionEquality().hash(playbackStates),const DeepCollectionEquality().hash(collections),const DeepCollectionEquality().hash(watchHistory));

@override
String toString() {
  return 'SyncSnapshotV1(schemaVersion: $schemaVersion, deviceId: $deviceId, updatedAt: $updatedAt, servers: $servers, preferences: $preferences, playbackStates: $playbackStates, collections: $collections, watchHistory: $watchHistory)';
}


}

/// @nodoc
abstract mixin class $SyncSnapshotV1CopyWith<$Res>  {
  factory $SyncSnapshotV1CopyWith(SyncSnapshotV1 value, $Res Function(SyncSnapshotV1) _then) = _$SyncSnapshotV1CopyWithImpl;
@useResult
$Res call({
 String schemaVersion, String deviceId,@DateTimeIso8601Converter() DateTime updatedAt, List<SyncServerRecord> servers, List<SyncPreferenceRecord> preferences, List<SyncPlaybackStateRecord> playbackStates, List<SyncCollectionRecord> collections, List<SyncWatchHistoryRecord> watchHistory
});




}
/// @nodoc
class _$SyncSnapshotV1CopyWithImpl<$Res>
    implements $SyncSnapshotV1CopyWith<$Res> {
  _$SyncSnapshotV1CopyWithImpl(this._self, this._then);

  final SyncSnapshotV1 _self;
  final $Res Function(SyncSnapshotV1) _then;

/// Create a copy of SyncSnapshotV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? deviceId = null,Object? updatedAt = null,Object? servers = null,Object? preferences = null,Object? playbackStates = null,Object? collections = null,Object? watchHistory = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,servers: null == servers ? _self.servers : servers // ignore: cast_nullable_to_non_nullable
as List<SyncServerRecord>,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as List<SyncPreferenceRecord>,playbackStates: null == playbackStates ? _self.playbackStates : playbackStates // ignore: cast_nullable_to_non_nullable
as List<SyncPlaybackStateRecord>,collections: null == collections ? _self.collections : collections // ignore: cast_nullable_to_non_nullable
as List<SyncCollectionRecord>,watchHistory: null == watchHistory ? _self.watchHistory : watchHistory // ignore: cast_nullable_to_non_nullable
as List<SyncWatchHistoryRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncSnapshotV1].
extension SyncSnapshotV1Patterns on SyncSnapshotV1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncSnapshotV1 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncSnapshotV1() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncSnapshotV1 value)  $default,){
final _that = this;
switch (_that) {
case _SyncSnapshotV1():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncSnapshotV1 value)?  $default,){
final _that = this;
switch (_that) {
case _SyncSnapshotV1() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String schemaVersion,  String deviceId, @DateTimeIso8601Converter()  DateTime updatedAt,  List<SyncServerRecord> servers,  List<SyncPreferenceRecord> preferences,  List<SyncPlaybackStateRecord> playbackStates,  List<SyncCollectionRecord> collections,  List<SyncWatchHistoryRecord> watchHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncSnapshotV1() when $default != null:
return $default(_that.schemaVersion,_that.deviceId,_that.updatedAt,_that.servers,_that.preferences,_that.playbackStates,_that.collections,_that.watchHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String schemaVersion,  String deviceId, @DateTimeIso8601Converter()  DateTime updatedAt,  List<SyncServerRecord> servers,  List<SyncPreferenceRecord> preferences,  List<SyncPlaybackStateRecord> playbackStates,  List<SyncCollectionRecord> collections,  List<SyncWatchHistoryRecord> watchHistory)  $default,) {final _that = this;
switch (_that) {
case _SyncSnapshotV1():
return $default(_that.schemaVersion,_that.deviceId,_that.updatedAt,_that.servers,_that.preferences,_that.playbackStates,_that.collections,_that.watchHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String schemaVersion,  String deviceId, @DateTimeIso8601Converter()  DateTime updatedAt,  List<SyncServerRecord> servers,  List<SyncPreferenceRecord> preferences,  List<SyncPlaybackStateRecord> playbackStates,  List<SyncCollectionRecord> collections,  List<SyncWatchHistoryRecord> watchHistory)?  $default,) {final _that = this;
switch (_that) {
case _SyncSnapshotV1() when $default != null:
return $default(_that.schemaVersion,_that.deviceId,_that.updatedAt,_that.servers,_that.preferences,_that.playbackStates,_that.collections,_that.watchHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncSnapshotV1 implements SyncSnapshotV1 {
  const _SyncSnapshotV1({this.schemaVersion = 'v1', required this.deviceId, @DateTimeIso8601Converter() required this.updatedAt, final  List<SyncServerRecord> servers = const <SyncServerRecord>[], final  List<SyncPreferenceRecord> preferences = const <SyncPreferenceRecord>[], final  List<SyncPlaybackStateRecord> playbackStates = const <SyncPlaybackStateRecord>[], final  List<SyncCollectionRecord> collections = const <SyncCollectionRecord>[], final  List<SyncWatchHistoryRecord> watchHistory = const <SyncWatchHistoryRecord>[]}): _servers = servers,_preferences = preferences,_playbackStates = playbackStates,_collections = collections,_watchHistory = watchHistory;
  factory _SyncSnapshotV1.fromJson(Map<String, dynamic> json) => _$SyncSnapshotV1FromJson(json);

@override@JsonKey() final  String schemaVersion;
@override final  String deviceId;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;
 final  List<SyncServerRecord> _servers;
@override@JsonKey() List<SyncServerRecord> get servers {
  if (_servers is EqualUnmodifiableListView) return _servers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servers);
}

 final  List<SyncPreferenceRecord> _preferences;
@override@JsonKey() List<SyncPreferenceRecord> get preferences {
  if (_preferences is EqualUnmodifiableListView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preferences);
}

 final  List<SyncPlaybackStateRecord> _playbackStates;
@override@JsonKey() List<SyncPlaybackStateRecord> get playbackStates {
  if (_playbackStates is EqualUnmodifiableListView) return _playbackStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playbackStates);
}

 final  List<SyncCollectionRecord> _collections;
@override@JsonKey() List<SyncCollectionRecord> get collections {
  if (_collections is EqualUnmodifiableListView) return _collections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collections);
}

 final  List<SyncWatchHistoryRecord> _watchHistory;
@override@JsonKey() List<SyncWatchHistoryRecord> get watchHistory {
  if (_watchHistory is EqualUnmodifiableListView) return _watchHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchHistory);
}


/// Create a copy of SyncSnapshotV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncSnapshotV1CopyWith<_SyncSnapshotV1> get copyWith => __$SyncSnapshotV1CopyWithImpl<_SyncSnapshotV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncSnapshotV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncSnapshotV1&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._servers, _servers)&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&const DeepCollectionEquality().equals(other._playbackStates, _playbackStates)&&const DeepCollectionEquality().equals(other._collections, _collections)&&const DeepCollectionEquality().equals(other._watchHistory, _watchHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,deviceId,updatedAt,const DeepCollectionEquality().hash(_servers),const DeepCollectionEquality().hash(_preferences),const DeepCollectionEquality().hash(_playbackStates),const DeepCollectionEquality().hash(_collections),const DeepCollectionEquality().hash(_watchHistory));

@override
String toString() {
  return 'SyncSnapshotV1(schemaVersion: $schemaVersion, deviceId: $deviceId, updatedAt: $updatedAt, servers: $servers, preferences: $preferences, playbackStates: $playbackStates, collections: $collections, watchHistory: $watchHistory)';
}


}

/// @nodoc
abstract mixin class _$SyncSnapshotV1CopyWith<$Res> implements $SyncSnapshotV1CopyWith<$Res> {
  factory _$SyncSnapshotV1CopyWith(_SyncSnapshotV1 value, $Res Function(_SyncSnapshotV1) _then) = __$SyncSnapshotV1CopyWithImpl;
@override @useResult
$Res call({
 String schemaVersion, String deviceId,@DateTimeIso8601Converter() DateTime updatedAt, List<SyncServerRecord> servers, List<SyncPreferenceRecord> preferences, List<SyncPlaybackStateRecord> playbackStates, List<SyncCollectionRecord> collections, List<SyncWatchHistoryRecord> watchHistory
});




}
/// @nodoc
class __$SyncSnapshotV1CopyWithImpl<$Res>
    implements _$SyncSnapshotV1CopyWith<$Res> {
  __$SyncSnapshotV1CopyWithImpl(this._self, this._then);

  final _SyncSnapshotV1 _self;
  final $Res Function(_SyncSnapshotV1) _then;

/// Create a copy of SyncSnapshotV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? deviceId = null,Object? updatedAt = null,Object? servers = null,Object? preferences = null,Object? playbackStates = null,Object? collections = null,Object? watchHistory = null,}) {
  return _then(_SyncSnapshotV1(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,servers: null == servers ? _self._servers : servers // ignore: cast_nullable_to_non_nullable
as List<SyncServerRecord>,preferences: null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as List<SyncPreferenceRecord>,playbackStates: null == playbackStates ? _self._playbackStates : playbackStates // ignore: cast_nullable_to_non_nullable
as List<SyncPlaybackStateRecord>,collections: null == collections ? _self._collections : collections // ignore: cast_nullable_to_non_nullable
as List<SyncCollectionRecord>,watchHistory: null == watchHistory ? _self._watchHistory : watchHistory // ignore: cast_nullable_to_non_nullable
as List<SyncWatchHistoryRecord>,
  ));
}


}

// dart format on
