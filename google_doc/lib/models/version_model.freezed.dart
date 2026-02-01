// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VersionModel {

 String get id; String get documentId; int get versionNumber; List<dynamic> get snapshot; String? get createdBy; String get reason; DateTime? get savedAt;// Populated fields
 UserModel? get creator;
/// Create a copy of VersionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersionModelCopyWith<VersionModel> get copyWith => _$VersionModelCopyWithImpl<VersionModel>(this as VersionModel, _$identity);

  /// Serializes this VersionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VersionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.versionNumber, versionNumber) || other.versionNumber == versionNumber)&&const DeepCollectionEquality().equals(other.snapshot, snapshot)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.creator, creator) || other.creator == creator));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentId,versionNumber,const DeepCollectionEquality().hash(snapshot),createdBy,reason,savedAt,creator);

@override
String toString() {
  return 'VersionModel(id: $id, documentId: $documentId, versionNumber: $versionNumber, snapshot: $snapshot, createdBy: $createdBy, reason: $reason, savedAt: $savedAt, creator: $creator)';
}


}

/// @nodoc
abstract mixin class $VersionModelCopyWith<$Res>  {
  factory $VersionModelCopyWith(VersionModel value, $Res Function(VersionModel) _then) = _$VersionModelCopyWithImpl;
@useResult
$Res call({
 String id, String documentId, int versionNumber, List<dynamic> snapshot, String? createdBy, String reason, DateTime? savedAt, UserModel? creator
});


$UserModelCopyWith<$Res>? get creator;

}
/// @nodoc
class _$VersionModelCopyWithImpl<$Res>
    implements $VersionModelCopyWith<$Res> {
  _$VersionModelCopyWithImpl(this._self, this._then);

  final VersionModel _self;
  final $Res Function(VersionModel) _then;

/// Create a copy of VersionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentId = null,Object? versionNumber = null,Object? snapshot = null,Object? createdBy = freezed,Object? reason = null,Object? savedAt = freezed,Object? creator = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,versionNumber: null == versionNumber ? _self.versionNumber : versionNumber // ignore: cast_nullable_to_non_nullable
as int,snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as List<dynamic>,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,creator: freezed == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}
/// Create a copy of VersionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get creator {
    if (_self.creator == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.creator!, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [VersionModel].
extension VersionModelPatterns on VersionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VersionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VersionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VersionModel value)  $default,){
final _that = this;
switch (_that) {
case _VersionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VersionModel value)?  $default,){
final _that = this;
switch (_that) {
case _VersionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String documentId,  int versionNumber,  List<dynamic> snapshot,  String? createdBy,  String reason,  DateTime? savedAt,  UserModel? creator)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VersionModel() when $default != null:
return $default(_that.id,_that.documentId,_that.versionNumber,_that.snapshot,_that.createdBy,_that.reason,_that.savedAt,_that.creator);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String documentId,  int versionNumber,  List<dynamic> snapshot,  String? createdBy,  String reason,  DateTime? savedAt,  UserModel? creator)  $default,) {final _that = this;
switch (_that) {
case _VersionModel():
return $default(_that.id,_that.documentId,_that.versionNumber,_that.snapshot,_that.createdBy,_that.reason,_that.savedAt,_that.creator);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String documentId,  int versionNumber,  List<dynamic> snapshot,  String? createdBy,  String reason,  DateTime? savedAt,  UserModel? creator)?  $default,) {final _that = this;
switch (_that) {
case _VersionModel() when $default != null:
return $default(_that.id,_that.documentId,_that.versionNumber,_that.snapshot,_that.createdBy,_that.reason,_that.savedAt,_that.creator);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VersionModel implements VersionModel {
  const _VersionModel({required this.id, required this.documentId, required this.versionNumber, required final  List<dynamic> snapshot, this.createdBy, this.reason = 'auto', this.savedAt, this.creator}): _snapshot = snapshot;
  factory _VersionModel.fromJson(Map<String, dynamic> json) => _$VersionModelFromJson(json);

@override final  String id;
@override final  String documentId;
@override final  int versionNumber;
 final  List<dynamic> _snapshot;
@override List<dynamic> get snapshot {
  if (_snapshot is EqualUnmodifiableListView) return _snapshot;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_snapshot);
}

@override final  String? createdBy;
@override@JsonKey() final  String reason;
@override final  DateTime? savedAt;
// Populated fields
@override final  UserModel? creator;

/// Create a copy of VersionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersionModelCopyWith<_VersionModel> get copyWith => __$VersionModelCopyWithImpl<_VersionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VersionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.versionNumber, versionNumber) || other.versionNumber == versionNumber)&&const DeepCollectionEquality().equals(other._snapshot, _snapshot)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.creator, creator) || other.creator == creator));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentId,versionNumber,const DeepCollectionEquality().hash(_snapshot),createdBy,reason,savedAt,creator);

@override
String toString() {
  return 'VersionModel(id: $id, documentId: $documentId, versionNumber: $versionNumber, snapshot: $snapshot, createdBy: $createdBy, reason: $reason, savedAt: $savedAt, creator: $creator)';
}


}

/// @nodoc
abstract mixin class _$VersionModelCopyWith<$Res> implements $VersionModelCopyWith<$Res> {
  factory _$VersionModelCopyWith(_VersionModel value, $Res Function(_VersionModel) _then) = __$VersionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String documentId, int versionNumber, List<dynamic> snapshot, String? createdBy, String reason, DateTime? savedAt, UserModel? creator
});


@override $UserModelCopyWith<$Res>? get creator;

}
/// @nodoc
class __$VersionModelCopyWithImpl<$Res>
    implements _$VersionModelCopyWith<$Res> {
  __$VersionModelCopyWithImpl(this._self, this._then);

  final _VersionModel _self;
  final $Res Function(_VersionModel) _then;

/// Create a copy of VersionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentId = null,Object? versionNumber = null,Object? snapshot = null,Object? createdBy = freezed,Object? reason = null,Object? savedAt = freezed,Object? creator = freezed,}) {
  return _then(_VersionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,versionNumber: null == versionNumber ? _self.versionNumber : versionNumber // ignore: cast_nullable_to_non_nullable
as int,snapshot: null == snapshot ? _self._snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as List<dynamic>,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,savedAt: freezed == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,creator: freezed == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}

/// Create a copy of VersionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get creator {
    if (_self.creator == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.creator!, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}

// dart format on
