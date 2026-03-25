// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaServerProfile {

 String get id; String get name; String get baseUrl; MediaServerType get type; String? get username; bool get isOnline;@DateTimeIso8601Converter() DateTime get updatedAt;
/// Create a copy of MediaServerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaServerProfileCopyWith<MediaServerProfile> get copyWith => _$MediaServerProfileCopyWithImpl<MediaServerProfile>(this as MediaServerProfile, _$identity);

  /// Serializes this MediaServerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaServerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.username, username) || other.username == username)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,baseUrl,type,username,isOnline,updatedAt);

@override
String toString() {
  return 'MediaServerProfile(id: $id, name: $name, baseUrl: $baseUrl, type: $type, username: $username, isOnline: $isOnline, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MediaServerProfileCopyWith<$Res>  {
  factory $MediaServerProfileCopyWith(MediaServerProfile value, $Res Function(MediaServerProfile) _then) = _$MediaServerProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String baseUrl, MediaServerType type, String? username, bool isOnline,@DateTimeIso8601Converter() DateTime updatedAt
});




}
/// @nodoc
class _$MediaServerProfileCopyWithImpl<$Res>
    implements $MediaServerProfileCopyWith<$Res> {
  _$MediaServerProfileCopyWithImpl(this._self, this._then);

  final MediaServerProfile _self;
  final $Res Function(MediaServerProfile) _then;

/// Create a copy of MediaServerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? baseUrl = null,Object? type = null,Object? username = freezed,Object? isOnline = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MediaServerType,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaServerProfile].
extension MediaServerProfilePatterns on MediaServerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaServerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaServerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaServerProfile value)  $default,){
final _that = this;
switch (_that) {
case _MediaServerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaServerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _MediaServerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String baseUrl,  MediaServerType type,  String? username,  bool isOnline, @DateTimeIso8601Converter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaServerProfile() when $default != null:
return $default(_that.id,_that.name,_that.baseUrl,_that.type,_that.username,_that.isOnline,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String baseUrl,  MediaServerType type,  String? username,  bool isOnline, @DateTimeIso8601Converter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MediaServerProfile():
return $default(_that.id,_that.name,_that.baseUrl,_that.type,_that.username,_that.isOnline,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String baseUrl,  MediaServerType type,  String? username,  bool isOnline, @DateTimeIso8601Converter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MediaServerProfile() when $default != null:
return $default(_that.id,_that.name,_that.baseUrl,_that.type,_that.username,_that.isOnline,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaServerProfile implements MediaServerProfile {
  const _MediaServerProfile({required this.id, required this.name, required this.baseUrl, required this.type, this.username, this.isOnline = false, @DateTimeIso8601Converter() required this.updatedAt});
  factory _MediaServerProfile.fromJson(Map<String, dynamic> json) => _$MediaServerProfileFromJson(json);

@override final  String id;
@override final  String name;
@override final  String baseUrl;
@override final  MediaServerType type;
@override final  String? username;
@override@JsonKey() final  bool isOnline;
@override@DateTimeIso8601Converter() final  DateTime updatedAt;

/// Create a copy of MediaServerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaServerProfileCopyWith<_MediaServerProfile> get copyWith => __$MediaServerProfileCopyWithImpl<_MediaServerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaServerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaServerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.username, username) || other.username == username)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,baseUrl,type,username,isOnline,updatedAt);

@override
String toString() {
  return 'MediaServerProfile(id: $id, name: $name, baseUrl: $baseUrl, type: $type, username: $username, isOnline: $isOnline, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MediaServerProfileCopyWith<$Res> implements $MediaServerProfileCopyWith<$Res> {
  factory _$MediaServerProfileCopyWith(_MediaServerProfile value, $Res Function(_MediaServerProfile) _then) = __$MediaServerProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String baseUrl, MediaServerType type, String? username, bool isOnline,@DateTimeIso8601Converter() DateTime updatedAt
});




}
/// @nodoc
class __$MediaServerProfileCopyWithImpl<$Res>
    implements _$MediaServerProfileCopyWith<$Res> {
  __$MediaServerProfileCopyWithImpl(this._self, this._then);

  final _MediaServerProfile _self;
  final $Res Function(_MediaServerProfile) _then;

/// Create a copy of MediaServerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? baseUrl = null,Object? type = null,Object? username = freezed,Object? isOnline = null,Object? updatedAt = null,}) {
  return _then(_MediaServerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MediaServerType,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ServerSignInRequest {

 String get baseUrl; String get username; String get password; MediaServerType get type;
/// Create a copy of ServerSignInRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerSignInRequestCopyWith<ServerSignInRequest> get copyWith => _$ServerSignInRequestCopyWithImpl<ServerSignInRequest>(this as ServerSignInRequest, _$identity);

  /// Serializes this ServerSignInRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerSignInRequest&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,username,password,type);

@override
String toString() {
  return 'ServerSignInRequest(baseUrl: $baseUrl, username: $username, password: $password, type: $type)';
}


}

/// @nodoc
abstract mixin class $ServerSignInRequestCopyWith<$Res>  {
  factory $ServerSignInRequestCopyWith(ServerSignInRequest value, $Res Function(ServerSignInRequest) _then) = _$ServerSignInRequestCopyWithImpl;
@useResult
$Res call({
 String baseUrl, String username, String password, MediaServerType type
});




}
/// @nodoc
class _$ServerSignInRequestCopyWithImpl<$Res>
    implements $ServerSignInRequestCopyWith<$Res> {
  _$ServerSignInRequestCopyWithImpl(this._self, this._then);

  final ServerSignInRequest _self;
  final $Res Function(ServerSignInRequest) _then;

/// Create a copy of ServerSignInRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? username = null,Object? password = null,Object? type = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MediaServerType,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerSignInRequest].
extension ServerSignInRequestPatterns on ServerSignInRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerSignInRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerSignInRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerSignInRequest value)  $default,){
final _that = this;
switch (_that) {
case _ServerSignInRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerSignInRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ServerSignInRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseUrl,  String username,  String password,  MediaServerType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerSignInRequest() when $default != null:
return $default(_that.baseUrl,_that.username,_that.password,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseUrl,  String username,  String password,  MediaServerType type)  $default,) {final _that = this;
switch (_that) {
case _ServerSignInRequest():
return $default(_that.baseUrl,_that.username,_that.password,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseUrl,  String username,  String password,  MediaServerType type)?  $default,) {final _that = this;
switch (_that) {
case _ServerSignInRequest() when $default != null:
return $default(_that.baseUrl,_that.username,_that.password,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerSignInRequest implements ServerSignInRequest {
  const _ServerSignInRequest({required this.baseUrl, required this.username, required this.password, this.type = MediaServerType.emby});
  factory _ServerSignInRequest.fromJson(Map<String, dynamic> json) => _$ServerSignInRequestFromJson(json);

@override final  String baseUrl;
@override final  String username;
@override final  String password;
@override@JsonKey() final  MediaServerType type;

/// Create a copy of ServerSignInRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerSignInRequestCopyWith<_ServerSignInRequest> get copyWith => __$ServerSignInRequestCopyWithImpl<_ServerSignInRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerSignInRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerSignInRequest&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,username,password,type);

@override
String toString() {
  return 'ServerSignInRequest(baseUrl: $baseUrl, username: $username, password: $password, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ServerSignInRequestCopyWith<$Res> implements $ServerSignInRequestCopyWith<$Res> {
  factory _$ServerSignInRequestCopyWith(_ServerSignInRequest value, $Res Function(_ServerSignInRequest) _then) = __$ServerSignInRequestCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, String username, String password, MediaServerType type
});




}
/// @nodoc
class __$ServerSignInRequestCopyWithImpl<$Res>
    implements _$ServerSignInRequestCopyWith<$Res> {
  __$ServerSignInRequestCopyWithImpl(this._self, this._then);

  final _ServerSignInRequest _self;
  final $Res Function(_ServerSignInRequest) _then;

/// Create a copy of ServerSignInRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? username = null,Object? password = null,Object? type = null,}) {
  return _then(_ServerSignInRequest(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MediaServerType,
  ));
}


}


/// @nodoc
mixin _$MediaServerSession {

 MediaServerProfile get server; String get accessToken; String get userId;
/// Create a copy of MediaServerSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaServerSessionCopyWith<MediaServerSession> get copyWith => _$MediaServerSessionCopyWithImpl<MediaServerSession>(this as MediaServerSession, _$identity);

  /// Serializes this MediaServerSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaServerSession&&(identical(other.server, server) || other.server == server)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,server,accessToken,userId);

@override
String toString() {
  return 'MediaServerSession(server: $server, accessToken: $accessToken, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $MediaServerSessionCopyWith<$Res>  {
  factory $MediaServerSessionCopyWith(MediaServerSession value, $Res Function(MediaServerSession) _then) = _$MediaServerSessionCopyWithImpl;
@useResult
$Res call({
 MediaServerProfile server, String accessToken, String userId
});


$MediaServerProfileCopyWith<$Res> get server;

}
/// @nodoc
class _$MediaServerSessionCopyWithImpl<$Res>
    implements $MediaServerSessionCopyWith<$Res> {
  _$MediaServerSessionCopyWithImpl(this._self, this._then);

  final MediaServerSession _self;
  final $Res Function(MediaServerSession) _then;

/// Create a copy of MediaServerSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? server = null,Object? accessToken = null,Object? userId = null,}) {
  return _then(_self.copyWith(
server: null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as MediaServerProfile,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of MediaServerSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaServerProfileCopyWith<$Res> get server {
  
  return $MediaServerProfileCopyWith<$Res>(_self.server, (value) {
    return _then(_self.copyWith(server: value));
  });
}
}


/// Adds pattern-matching-related methods to [MediaServerSession].
extension MediaServerSessionPatterns on MediaServerSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaServerSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaServerSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaServerSession value)  $default,){
final _that = this;
switch (_that) {
case _MediaServerSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaServerSession value)?  $default,){
final _that = this;
switch (_that) {
case _MediaServerSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MediaServerProfile server,  String accessToken,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaServerSession() when $default != null:
return $default(_that.server,_that.accessToken,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MediaServerProfile server,  String accessToken,  String userId)  $default,) {final _that = this;
switch (_that) {
case _MediaServerSession():
return $default(_that.server,_that.accessToken,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MediaServerProfile server,  String accessToken,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _MediaServerSession() when $default != null:
return $default(_that.server,_that.accessToken,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaServerSession implements MediaServerSession {
  const _MediaServerSession({required this.server, required this.accessToken, required this.userId});
  factory _MediaServerSession.fromJson(Map<String, dynamic> json) => _$MediaServerSessionFromJson(json);

@override final  MediaServerProfile server;
@override final  String accessToken;
@override final  String userId;

/// Create a copy of MediaServerSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaServerSessionCopyWith<_MediaServerSession> get copyWith => __$MediaServerSessionCopyWithImpl<_MediaServerSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaServerSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaServerSession&&(identical(other.server, server) || other.server == server)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,server,accessToken,userId);

@override
String toString() {
  return 'MediaServerSession(server: $server, accessToken: $accessToken, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$MediaServerSessionCopyWith<$Res> implements $MediaServerSessionCopyWith<$Res> {
  factory _$MediaServerSessionCopyWith(_MediaServerSession value, $Res Function(_MediaServerSession) _then) = __$MediaServerSessionCopyWithImpl;
@override @useResult
$Res call({
 MediaServerProfile server, String accessToken, String userId
});


@override $MediaServerProfileCopyWith<$Res> get server;

}
/// @nodoc
class __$MediaServerSessionCopyWithImpl<$Res>
    implements _$MediaServerSessionCopyWith<$Res> {
  __$MediaServerSessionCopyWithImpl(this._self, this._then);

  final _MediaServerSession _self;
  final $Res Function(_MediaServerSession) _then;

/// Create a copy of MediaServerSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? server = null,Object? accessToken = null,Object? userId = null,}) {
  return _then(_MediaServerSession(
server: null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as MediaServerProfile,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of MediaServerSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaServerProfileCopyWith<$Res> get server {
  
  return $MediaServerProfileCopyWith<$Res>(_self.server, (value) {
    return _then(_self.copyWith(server: value));
  });
}
}

// dart format on
