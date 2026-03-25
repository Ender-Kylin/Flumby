// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerMediaSource {

 String get serverId; String get itemId; String get title; String get streamUrl; String? get mediaSourceId; String? get playSessionId; int get durationSeconds; int get resumePositionSeconds;
/// Create a copy of PlayerMediaSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerMediaSourceCopyWith<PlayerMediaSource> get copyWith => _$PlayerMediaSourceCopyWithImpl<PlayerMediaSource>(this as PlayerMediaSource, _$identity);

  /// Serializes this PlayerMediaSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerMediaSource&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.title, title) || other.title == title)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.resumePositionSeconds, resumePositionSeconds) || other.resumePositionSeconds == resumePositionSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,title,streamUrl,mediaSourceId,playSessionId,durationSeconds,resumePositionSeconds);

@override
String toString() {
  return 'PlayerMediaSource(serverId: $serverId, itemId: $itemId, title: $title, streamUrl: $streamUrl, mediaSourceId: $mediaSourceId, playSessionId: $playSessionId, durationSeconds: $durationSeconds, resumePositionSeconds: $resumePositionSeconds)';
}


}

/// @nodoc
abstract mixin class $PlayerMediaSourceCopyWith<$Res>  {
  factory $PlayerMediaSourceCopyWith(PlayerMediaSource value, $Res Function(PlayerMediaSource) _then) = _$PlayerMediaSourceCopyWithImpl;
@useResult
$Res call({
 String serverId, String itemId, String title, String streamUrl, String? mediaSourceId, String? playSessionId, int durationSeconds, int resumePositionSeconds
});




}
/// @nodoc
class _$PlayerMediaSourceCopyWithImpl<$Res>
    implements $PlayerMediaSourceCopyWith<$Res> {
  _$PlayerMediaSourceCopyWithImpl(this._self, this._then);

  final PlayerMediaSource _self;
  final $Res Function(PlayerMediaSource) _then;

/// Create a copy of PlayerMediaSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverId = null,Object? itemId = null,Object? title = null,Object? streamUrl = null,Object? mediaSourceId = freezed,Object? playSessionId = freezed,Object? durationSeconds = null,Object? resumePositionSeconds = null,}) {
  return _then(_self.copyWith(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,mediaSourceId: freezed == mediaSourceId ? _self.mediaSourceId : mediaSourceId // ignore: cast_nullable_to_non_nullable
as String?,playSessionId: freezed == playSessionId ? _self.playSessionId : playSessionId // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,resumePositionSeconds: null == resumePositionSeconds ? _self.resumePositionSeconds : resumePositionSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerMediaSource].
extension PlayerMediaSourcePatterns on PlayerMediaSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerMediaSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerMediaSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerMediaSource value)  $default,){
final _that = this;
switch (_that) {
case _PlayerMediaSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerMediaSource value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerMediaSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serverId,  String itemId,  String title,  String streamUrl,  String? mediaSourceId,  String? playSessionId,  int durationSeconds,  int resumePositionSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerMediaSource() when $default != null:
return $default(_that.serverId,_that.itemId,_that.title,_that.streamUrl,_that.mediaSourceId,_that.playSessionId,_that.durationSeconds,_that.resumePositionSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serverId,  String itemId,  String title,  String streamUrl,  String? mediaSourceId,  String? playSessionId,  int durationSeconds,  int resumePositionSeconds)  $default,) {final _that = this;
switch (_that) {
case _PlayerMediaSource():
return $default(_that.serverId,_that.itemId,_that.title,_that.streamUrl,_that.mediaSourceId,_that.playSessionId,_that.durationSeconds,_that.resumePositionSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serverId,  String itemId,  String title,  String streamUrl,  String? mediaSourceId,  String? playSessionId,  int durationSeconds,  int resumePositionSeconds)?  $default,) {final _that = this;
switch (_that) {
case _PlayerMediaSource() when $default != null:
return $default(_that.serverId,_that.itemId,_that.title,_that.streamUrl,_that.mediaSourceId,_that.playSessionId,_that.durationSeconds,_that.resumePositionSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerMediaSource implements PlayerMediaSource {
  const _PlayerMediaSource({required this.serverId, required this.itemId, required this.title, required this.streamUrl, this.mediaSourceId, this.playSessionId, this.durationSeconds = 0, this.resumePositionSeconds = 0});
  factory _PlayerMediaSource.fromJson(Map<String, dynamic> json) => _$PlayerMediaSourceFromJson(json);

@override final  String serverId;
@override final  String itemId;
@override final  String title;
@override final  String streamUrl;
@override final  String? mediaSourceId;
@override final  String? playSessionId;
@override@JsonKey() final  int durationSeconds;
@override@JsonKey() final  int resumePositionSeconds;

/// Create a copy of PlayerMediaSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerMediaSourceCopyWith<_PlayerMediaSource> get copyWith => __$PlayerMediaSourceCopyWithImpl<_PlayerMediaSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerMediaSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerMediaSource&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.title, title) || other.title == title)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.resumePositionSeconds, resumePositionSeconds) || other.resumePositionSeconds == resumePositionSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverId,itemId,title,streamUrl,mediaSourceId,playSessionId,durationSeconds,resumePositionSeconds);

@override
String toString() {
  return 'PlayerMediaSource(serverId: $serverId, itemId: $itemId, title: $title, streamUrl: $streamUrl, mediaSourceId: $mediaSourceId, playSessionId: $playSessionId, durationSeconds: $durationSeconds, resumePositionSeconds: $resumePositionSeconds)';
}


}

/// @nodoc
abstract mixin class _$PlayerMediaSourceCopyWith<$Res> implements $PlayerMediaSourceCopyWith<$Res> {
  factory _$PlayerMediaSourceCopyWith(_PlayerMediaSource value, $Res Function(_PlayerMediaSource) _then) = __$PlayerMediaSourceCopyWithImpl;
@override @useResult
$Res call({
 String serverId, String itemId, String title, String streamUrl, String? mediaSourceId, String? playSessionId, int durationSeconds, int resumePositionSeconds
});




}
/// @nodoc
class __$PlayerMediaSourceCopyWithImpl<$Res>
    implements _$PlayerMediaSourceCopyWith<$Res> {
  __$PlayerMediaSourceCopyWithImpl(this._self, this._then);

  final _PlayerMediaSource _self;
  final $Res Function(_PlayerMediaSource) _then;

/// Create a copy of PlayerMediaSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverId = null,Object? itemId = null,Object? title = null,Object? streamUrl = null,Object? mediaSourceId = freezed,Object? playSessionId = freezed,Object? durationSeconds = null,Object? resumePositionSeconds = null,}) {
  return _then(_PlayerMediaSource(
serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,mediaSourceId: freezed == mediaSourceId ? _self.mediaSourceId : mediaSourceId // ignore: cast_nullable_to_non_nullable
as String?,playSessionId: freezed == playSessionId ? _self.playSessionId : playSessionId // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,resumePositionSeconds: null == resumePositionSeconds ? _self.resumePositionSeconds : resumePositionSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlayerStateSnapshot {

 PlayerStatus get status; PlayerBackend get backend; PlayerPresentationMode get presentationMode; bool get externalWindowActive; PlayerMediaSource? get source; int get positionSeconds; String? get subtitleTrackId; String? get audioTrackId; String? get errorMessage; String? get launchError;
/// Create a copy of PlayerStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStateSnapshotCopyWith<PlayerStateSnapshot> get copyWith => _$PlayerStateSnapshotCopyWithImpl<PlayerStateSnapshot>(this as PlayerStateSnapshot, _$identity);

  /// Serializes this PlayerStateSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerStateSnapshot&&(identical(other.status, status) || other.status == status)&&(identical(other.backend, backend) || other.backend == backend)&&(identical(other.presentationMode, presentationMode) || other.presentationMode == presentationMode)&&(identical(other.externalWindowActive, externalWindowActive) || other.externalWindowActive == externalWindowActive)&&(identical(other.source, source) || other.source == source)&&(identical(other.positionSeconds, positionSeconds) || other.positionSeconds == positionSeconds)&&(identical(other.subtitleTrackId, subtitleTrackId) || other.subtitleTrackId == subtitleTrackId)&&(identical(other.audioTrackId, audioTrackId) || other.audioTrackId == audioTrackId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.launchError, launchError) || other.launchError == launchError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,backend,presentationMode,externalWindowActive,source,positionSeconds,subtitleTrackId,audioTrackId,errorMessage,launchError);

@override
String toString() {
  return 'PlayerStateSnapshot(status: $status, backend: $backend, presentationMode: $presentationMode, externalWindowActive: $externalWindowActive, source: $source, positionSeconds: $positionSeconds, subtitleTrackId: $subtitleTrackId, audioTrackId: $audioTrackId, errorMessage: $errorMessage, launchError: $launchError)';
}


}

/// @nodoc
abstract mixin class $PlayerStateSnapshotCopyWith<$Res>  {
  factory $PlayerStateSnapshotCopyWith(PlayerStateSnapshot value, $Res Function(PlayerStateSnapshot) _then) = _$PlayerStateSnapshotCopyWithImpl;
@useResult
$Res call({
 PlayerStatus status, PlayerBackend backend, PlayerPresentationMode presentationMode, bool externalWindowActive, PlayerMediaSource? source, int positionSeconds, String? subtitleTrackId, String? audioTrackId, String? errorMessage, String? launchError
});


$PlayerMediaSourceCopyWith<$Res>? get source;

}
/// @nodoc
class _$PlayerStateSnapshotCopyWithImpl<$Res>
    implements $PlayerStateSnapshotCopyWith<$Res> {
  _$PlayerStateSnapshotCopyWithImpl(this._self, this._then);

  final PlayerStateSnapshot _self;
  final $Res Function(PlayerStateSnapshot) _then;

/// Create a copy of PlayerStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? backend = null,Object? presentationMode = null,Object? externalWindowActive = null,Object? source = freezed,Object? positionSeconds = null,Object? subtitleTrackId = freezed,Object? audioTrackId = freezed,Object? errorMessage = freezed,Object? launchError = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlayerStatus,backend: null == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as PlayerBackend,presentationMode: null == presentationMode ? _self.presentationMode : presentationMode // ignore: cast_nullable_to_non_nullable
as PlayerPresentationMode,externalWindowActive: null == externalWindowActive ? _self.externalWindowActive : externalWindowActive // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PlayerMediaSource?,positionSeconds: null == positionSeconds ? _self.positionSeconds : positionSeconds // ignore: cast_nullable_to_non_nullable
as int,subtitleTrackId: freezed == subtitleTrackId ? _self.subtitleTrackId : subtitleTrackId // ignore: cast_nullable_to_non_nullable
as String?,audioTrackId: freezed == audioTrackId ? _self.audioTrackId : audioTrackId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,launchError: freezed == launchError ? _self.launchError : launchError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PlayerStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerMediaSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $PlayerMediaSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerStateSnapshot].
extension PlayerStateSnapshotPatterns on PlayerStateSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerStateSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerStateSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerStateSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _PlayerStateSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerStateSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerStateSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayerStatus status,  PlayerBackend backend,  PlayerPresentationMode presentationMode,  bool externalWindowActive,  PlayerMediaSource? source,  int positionSeconds,  String? subtitleTrackId,  String? audioTrackId,  String? errorMessage,  String? launchError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerStateSnapshot() when $default != null:
return $default(_that.status,_that.backend,_that.presentationMode,_that.externalWindowActive,_that.source,_that.positionSeconds,_that.subtitleTrackId,_that.audioTrackId,_that.errorMessage,_that.launchError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayerStatus status,  PlayerBackend backend,  PlayerPresentationMode presentationMode,  bool externalWindowActive,  PlayerMediaSource? source,  int positionSeconds,  String? subtitleTrackId,  String? audioTrackId,  String? errorMessage,  String? launchError)  $default,) {final _that = this;
switch (_that) {
case _PlayerStateSnapshot():
return $default(_that.status,_that.backend,_that.presentationMode,_that.externalWindowActive,_that.source,_that.positionSeconds,_that.subtitleTrackId,_that.audioTrackId,_that.errorMessage,_that.launchError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayerStatus status,  PlayerBackend backend,  PlayerPresentationMode presentationMode,  bool externalWindowActive,  PlayerMediaSource? source,  int positionSeconds,  String? subtitleTrackId,  String? audioTrackId,  String? errorMessage,  String? launchError)?  $default,) {final _that = this;
switch (_that) {
case _PlayerStateSnapshot() when $default != null:
return $default(_that.status,_that.backend,_that.presentationMode,_that.externalWindowActive,_that.source,_that.positionSeconds,_that.subtitleTrackId,_that.audioTrackId,_that.errorMessage,_that.launchError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerStateSnapshot extends PlayerStateSnapshot {
  const _PlayerStateSnapshot({required this.status, required this.backend, this.presentationMode = PlayerPresentationMode.embedded, this.externalWindowActive = false, this.source, this.positionSeconds = 0, this.subtitleTrackId, this.audioTrackId, this.errorMessage, this.launchError}): super._();
  factory _PlayerStateSnapshot.fromJson(Map<String, dynamic> json) => _$PlayerStateSnapshotFromJson(json);

@override final  PlayerStatus status;
@override final  PlayerBackend backend;
@override@JsonKey() final  PlayerPresentationMode presentationMode;
@override@JsonKey() final  bool externalWindowActive;
@override final  PlayerMediaSource? source;
@override@JsonKey() final  int positionSeconds;
@override final  String? subtitleTrackId;
@override final  String? audioTrackId;
@override final  String? errorMessage;
@override final  String? launchError;

/// Create a copy of PlayerStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerStateSnapshotCopyWith<_PlayerStateSnapshot> get copyWith => __$PlayerStateSnapshotCopyWithImpl<_PlayerStateSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerStateSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerStateSnapshot&&(identical(other.status, status) || other.status == status)&&(identical(other.backend, backend) || other.backend == backend)&&(identical(other.presentationMode, presentationMode) || other.presentationMode == presentationMode)&&(identical(other.externalWindowActive, externalWindowActive) || other.externalWindowActive == externalWindowActive)&&(identical(other.source, source) || other.source == source)&&(identical(other.positionSeconds, positionSeconds) || other.positionSeconds == positionSeconds)&&(identical(other.subtitleTrackId, subtitleTrackId) || other.subtitleTrackId == subtitleTrackId)&&(identical(other.audioTrackId, audioTrackId) || other.audioTrackId == audioTrackId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.launchError, launchError) || other.launchError == launchError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,backend,presentationMode,externalWindowActive,source,positionSeconds,subtitleTrackId,audioTrackId,errorMessage,launchError);

@override
String toString() {
  return 'PlayerStateSnapshot(status: $status, backend: $backend, presentationMode: $presentationMode, externalWindowActive: $externalWindowActive, source: $source, positionSeconds: $positionSeconds, subtitleTrackId: $subtitleTrackId, audioTrackId: $audioTrackId, errorMessage: $errorMessage, launchError: $launchError)';
}


}

/// @nodoc
abstract mixin class _$PlayerStateSnapshotCopyWith<$Res> implements $PlayerStateSnapshotCopyWith<$Res> {
  factory _$PlayerStateSnapshotCopyWith(_PlayerStateSnapshot value, $Res Function(_PlayerStateSnapshot) _then) = __$PlayerStateSnapshotCopyWithImpl;
@override @useResult
$Res call({
 PlayerStatus status, PlayerBackend backend, PlayerPresentationMode presentationMode, bool externalWindowActive, PlayerMediaSource? source, int positionSeconds, String? subtitleTrackId, String? audioTrackId, String? errorMessage, String? launchError
});


@override $PlayerMediaSourceCopyWith<$Res>? get source;

}
/// @nodoc
class __$PlayerStateSnapshotCopyWithImpl<$Res>
    implements _$PlayerStateSnapshotCopyWith<$Res> {
  __$PlayerStateSnapshotCopyWithImpl(this._self, this._then);

  final _PlayerStateSnapshot _self;
  final $Res Function(_PlayerStateSnapshot) _then;

/// Create a copy of PlayerStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? backend = null,Object? presentationMode = null,Object? externalWindowActive = null,Object? source = freezed,Object? positionSeconds = null,Object? subtitleTrackId = freezed,Object? audioTrackId = freezed,Object? errorMessage = freezed,Object? launchError = freezed,}) {
  return _then(_PlayerStateSnapshot(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlayerStatus,backend: null == backend ? _self.backend : backend // ignore: cast_nullable_to_non_nullable
as PlayerBackend,presentationMode: null == presentationMode ? _self.presentationMode : presentationMode // ignore: cast_nullable_to_non_nullable
as PlayerPresentationMode,externalWindowActive: null == externalWindowActive ? _self.externalWindowActive : externalWindowActive // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PlayerMediaSource?,positionSeconds: null == positionSeconds ? _self.positionSeconds : positionSeconds // ignore: cast_nullable_to_non_nullable
as int,subtitleTrackId: freezed == subtitleTrackId ? _self.subtitleTrackId : subtitleTrackId // ignore: cast_nullable_to_non_nullable
as String?,audioTrackId: freezed == audioTrackId ? _self.audioTrackId : audioTrackId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,launchError: freezed == launchError ? _self.launchError : launchError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlayerStateSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerMediaSourceCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $PlayerMediaSourceCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
mixin _$PlaybackReport {

 String get itemId; String get playSessionId; String? get mediaSourceId; int get positionSeconds; bool get isPaused;
/// Create a copy of PlaybackReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackReportCopyWith<PlaybackReport> get copyWith => _$PlaybackReportCopyWithImpl<PlaybackReport>(this as PlaybackReport, _$identity);

  /// Serializes this PlaybackReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackReport&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.positionSeconds, positionSeconds) || other.positionSeconds == positionSeconds)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,playSessionId,mediaSourceId,positionSeconds,isPaused);

@override
String toString() {
  return 'PlaybackReport(itemId: $itemId, playSessionId: $playSessionId, mediaSourceId: $mediaSourceId, positionSeconds: $positionSeconds, isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class $PlaybackReportCopyWith<$Res>  {
  factory $PlaybackReportCopyWith(PlaybackReport value, $Res Function(PlaybackReport) _then) = _$PlaybackReportCopyWithImpl;
@useResult
$Res call({
 String itemId, String playSessionId, String? mediaSourceId, int positionSeconds, bool isPaused
});




}
/// @nodoc
class _$PlaybackReportCopyWithImpl<$Res>
    implements $PlaybackReportCopyWith<$Res> {
  _$PlaybackReportCopyWithImpl(this._self, this._then);

  final PlaybackReport _self;
  final $Res Function(PlaybackReport) _then;

/// Create a copy of PlaybackReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? playSessionId = null,Object? mediaSourceId = freezed,Object? positionSeconds = null,Object? isPaused = null,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,playSessionId: null == playSessionId ? _self.playSessionId : playSessionId // ignore: cast_nullable_to_non_nullable
as String,mediaSourceId: freezed == mediaSourceId ? _self.mediaSourceId : mediaSourceId // ignore: cast_nullable_to_non_nullable
as String?,positionSeconds: null == positionSeconds ? _self.positionSeconds : positionSeconds // ignore: cast_nullable_to_non_nullable
as int,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackReport].
extension PlaybackReportPatterns on PlaybackReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackReport value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackReport value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemId,  String playSessionId,  String? mediaSourceId,  int positionSeconds,  bool isPaused)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackReport() when $default != null:
return $default(_that.itemId,_that.playSessionId,_that.mediaSourceId,_that.positionSeconds,_that.isPaused);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemId,  String playSessionId,  String? mediaSourceId,  int positionSeconds,  bool isPaused)  $default,) {final _that = this;
switch (_that) {
case _PlaybackReport():
return $default(_that.itemId,_that.playSessionId,_that.mediaSourceId,_that.positionSeconds,_that.isPaused);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemId,  String playSessionId,  String? mediaSourceId,  int positionSeconds,  bool isPaused)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackReport() when $default != null:
return $default(_that.itemId,_that.playSessionId,_that.mediaSourceId,_that.positionSeconds,_that.isPaused);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaybackReport implements PlaybackReport {
  const _PlaybackReport({required this.itemId, required this.playSessionId, this.mediaSourceId, this.positionSeconds = 0, this.isPaused = false});
  factory _PlaybackReport.fromJson(Map<String, dynamic> json) => _$PlaybackReportFromJson(json);

@override final  String itemId;
@override final  String playSessionId;
@override final  String? mediaSourceId;
@override@JsonKey() final  int positionSeconds;
@override@JsonKey() final  bool isPaused;

/// Create a copy of PlaybackReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackReportCopyWith<_PlaybackReport> get copyWith => __$PlaybackReportCopyWithImpl<_PlaybackReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaybackReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackReport&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.playSessionId, playSessionId) || other.playSessionId == playSessionId)&&(identical(other.mediaSourceId, mediaSourceId) || other.mediaSourceId == mediaSourceId)&&(identical(other.positionSeconds, positionSeconds) || other.positionSeconds == positionSeconds)&&(identical(other.isPaused, isPaused) || other.isPaused == isPaused));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,playSessionId,mediaSourceId,positionSeconds,isPaused);

@override
String toString() {
  return 'PlaybackReport(itemId: $itemId, playSessionId: $playSessionId, mediaSourceId: $mediaSourceId, positionSeconds: $positionSeconds, isPaused: $isPaused)';
}


}

/// @nodoc
abstract mixin class _$PlaybackReportCopyWith<$Res> implements $PlaybackReportCopyWith<$Res> {
  factory _$PlaybackReportCopyWith(_PlaybackReport value, $Res Function(_PlaybackReport) _then) = __$PlaybackReportCopyWithImpl;
@override @useResult
$Res call({
 String itemId, String playSessionId, String? mediaSourceId, int positionSeconds, bool isPaused
});




}
/// @nodoc
class __$PlaybackReportCopyWithImpl<$Res>
    implements _$PlaybackReportCopyWith<$Res> {
  __$PlaybackReportCopyWithImpl(this._self, this._then);

  final _PlaybackReport _self;
  final $Res Function(_PlaybackReport) _then;

/// Create a copy of PlaybackReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? playSessionId = null,Object? mediaSourceId = freezed,Object? positionSeconds = null,Object? isPaused = null,}) {
  return _then(_PlaybackReport(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,playSessionId: null == playSessionId ? _self.playSessionId : playSessionId // ignore: cast_nullable_to_non_nullable
as String,mediaSourceId: freezed == mediaSourceId ? _self.mediaSourceId : mediaSourceId // ignore: cast_nullable_to_non_nullable
as String?,positionSeconds: null == positionSeconds ? _self.positionSeconds : positionSeconds // ignore: cast_nullable_to_non_nullable
as int,isPaused: null == isPaused ? _self.isPaused : isPaused // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
