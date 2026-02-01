// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collaboration_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CollaborationState implements DiagnosticableTreeMixin {

 List<Presence> get presences; String get saveStatus;@TimestampConverter() DateTime? get lastSavedAt; String? get errorMessage; bool get isSyncing;
/// Create a copy of CollaborationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollaborationStateCopyWith<CollaborationState> get copyWith => _$CollaborationStateCopyWithImpl<CollaborationState>(this as CollaborationState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CollaborationState'))
    ..add(DiagnosticsProperty('presences', presences))..add(DiagnosticsProperty('saveStatus', saveStatus))..add(DiagnosticsProperty('lastSavedAt', lastSavedAt))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('isSyncing', isSyncing));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollaborationState&&const DeepCollectionEquality().equals(other.presences, presences)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.lastSavedAt, lastSavedAt) || other.lastSavedAt == lastSavedAt)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(presences),saveStatus,lastSavedAt,errorMessage,isSyncing);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CollaborationState(presences: $presences, saveStatus: $saveStatus, lastSavedAt: $lastSavedAt, errorMessage: $errorMessage, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class $CollaborationStateCopyWith<$Res>  {
  factory $CollaborationStateCopyWith(CollaborationState value, $Res Function(CollaborationState) _then) = _$CollaborationStateCopyWithImpl;
@useResult
$Res call({
 List<Presence> presences, String saveStatus,@TimestampConverter() DateTime? lastSavedAt, String? errorMessage, bool isSyncing
});




}
/// @nodoc
class _$CollaborationStateCopyWithImpl<$Res>
    implements $CollaborationStateCopyWith<$Res> {
  _$CollaborationStateCopyWithImpl(this._self, this._then);

  final CollaborationState _self;
  final $Res Function(CollaborationState) _then;

/// Create a copy of CollaborationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? presences = null,Object? saveStatus = null,Object? lastSavedAt = freezed,Object? errorMessage = freezed,Object? isSyncing = null,}) {
  return _then(_self.copyWith(
presences: null == presences ? _self.presences : presences // ignore: cast_nullable_to_non_nullable
as List<Presence>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as String,lastSavedAt: freezed == lastSavedAt ? _self.lastSavedAt : lastSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CollaborationState].
extension CollaborationStatePatterns on CollaborationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollaborationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollaborationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollaborationState value)  $default,){
final _that = this;
switch (_that) {
case _CollaborationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollaborationState value)?  $default,){
final _that = this;
switch (_that) {
case _CollaborationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Presence> presences,  String saveStatus, @TimestampConverter()  DateTime? lastSavedAt,  String? errorMessage,  bool isSyncing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollaborationState() when $default != null:
return $default(_that.presences,_that.saveStatus,_that.lastSavedAt,_that.errorMessage,_that.isSyncing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Presence> presences,  String saveStatus, @TimestampConverter()  DateTime? lastSavedAt,  String? errorMessage,  bool isSyncing)  $default,) {final _that = this;
switch (_that) {
case _CollaborationState():
return $default(_that.presences,_that.saveStatus,_that.lastSavedAt,_that.errorMessage,_that.isSyncing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Presence> presences,  String saveStatus, @TimestampConverter()  DateTime? lastSavedAt,  String? errorMessage,  bool isSyncing)?  $default,) {final _that = this;
switch (_that) {
case _CollaborationState() when $default != null:
return $default(_that.presences,_that.saveStatus,_that.lastSavedAt,_that.errorMessage,_that.isSyncing);case _:
  return null;

}
}

}

/// @nodoc


class _CollaborationState with DiagnosticableTreeMixin implements CollaborationState {
  const _CollaborationState({final  List<Presence> presences = const [], this.saveStatus = 'saved', @TimestampConverter() this.lastSavedAt, this.errorMessage, this.isSyncing = false}): _presences = presences;
  

 final  List<Presence> _presences;
@override@JsonKey() List<Presence> get presences {
  if (_presences is EqualUnmodifiableListView) return _presences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_presences);
}

@override@JsonKey() final  String saveStatus;
@override@TimestampConverter() final  DateTime? lastSavedAt;
@override final  String? errorMessage;
@override@JsonKey() final  bool isSyncing;

/// Create a copy of CollaborationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollaborationStateCopyWith<_CollaborationState> get copyWith => __$CollaborationStateCopyWithImpl<_CollaborationState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CollaborationState'))
    ..add(DiagnosticsProperty('presences', presences))..add(DiagnosticsProperty('saveStatus', saveStatus))..add(DiagnosticsProperty('lastSavedAt', lastSavedAt))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('isSyncing', isSyncing));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollaborationState&&const DeepCollectionEquality().equals(other._presences, _presences)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.lastSavedAt, lastSavedAt) || other.lastSavedAt == lastSavedAt)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_presences),saveStatus,lastSavedAt,errorMessage,isSyncing);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CollaborationState(presences: $presences, saveStatus: $saveStatus, lastSavedAt: $lastSavedAt, errorMessage: $errorMessage, isSyncing: $isSyncing)';
}


}

/// @nodoc
abstract mixin class _$CollaborationStateCopyWith<$Res> implements $CollaborationStateCopyWith<$Res> {
  factory _$CollaborationStateCopyWith(_CollaborationState value, $Res Function(_CollaborationState) _then) = __$CollaborationStateCopyWithImpl;
@override @useResult
$Res call({
 List<Presence> presences, String saveStatus,@TimestampConverter() DateTime? lastSavedAt, String? errorMessage, bool isSyncing
});




}
/// @nodoc
class __$CollaborationStateCopyWithImpl<$Res>
    implements _$CollaborationStateCopyWith<$Res> {
  __$CollaborationStateCopyWithImpl(this._self, this._then);

  final _CollaborationState _self;
  final $Res Function(_CollaborationState) _then;

/// Create a copy of CollaborationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? presences = null,Object? saveStatus = null,Object? lastSavedAt = freezed,Object? errorMessage = freezed,Object? isSyncing = null,}) {
  return _then(_CollaborationState(
presences: null == presences ? _self._presences : presences // ignore: cast_nullable_to_non_nullable
as List<Presence>,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as String,lastSavedAt: freezed == lastSavedAt ? _self.lastSavedAt : lastSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
