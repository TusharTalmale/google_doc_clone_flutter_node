// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {

 String get id; String get documentId; String get userId; Anchor get anchor; String get content; bool get resolved; String? get resolvedBy; DateTime? get resolvedAt; List<ReplyModel> get replies; String get type;// comment, suggestion
 Map<String, dynamic>? get suggestedDelta; DateTime? get createdAt; DateTime? get updatedAt;// Populated fields
 UserModel? get user;
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentModelCopyWith<CommentModel> get copyWith => _$CommentModelCopyWithImpl<CommentModel>(this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.content, content) || other.content == content)&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.resolvedBy, resolvedBy) || other.resolvedBy == resolvedBy)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.suggestedDelta, suggestedDelta)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentId,userId,anchor,content,resolved,resolvedBy,resolvedAt,const DeepCollectionEquality().hash(replies),type,const DeepCollectionEquality().hash(suggestedDelta),createdAt,updatedAt,user);

@override
String toString() {
  return 'CommentModel(id: $id, documentId: $documentId, userId: $userId, anchor: $anchor, content: $content, resolved: $resolved, resolvedBy: $resolvedBy, resolvedAt: $resolvedAt, replies: $replies, type: $type, suggestedDelta: $suggestedDelta, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
}


}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res>  {
  factory $CommentModelCopyWith(CommentModel value, $Res Function(CommentModel) _then) = _$CommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String documentId, String userId, Anchor anchor, String content, bool resolved, String? resolvedBy, DateTime? resolvedAt, List<ReplyModel> replies, String type, Map<String, dynamic>? suggestedDelta, DateTime? createdAt, DateTime? updatedAt, UserModel? user
});


$AnchorCopyWith<$Res> get anchor;$UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$CommentModelCopyWithImpl<$Res>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? documentId = null,Object? userId = null,Object? anchor = null,Object? content = null,Object? resolved = null,Object? resolvedBy = freezed,Object? resolvedAt = freezed,Object? replies = null,Object? type = null,Object? suggestedDelta = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as Anchor,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,resolvedBy: freezed == resolvedBy ? _self.resolvedBy : resolvedBy // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<ReplyModel>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,suggestedDelta: freezed == suggestedDelta ? _self.suggestedDelta : suggestedDelta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnchorCopyWith<$Res> get anchor {
  
  return $AnchorCopyWith<$Res>(_self.anchor, (value) {
    return _then(_self.copyWith(anchor: value));
  });
}/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String documentId,  String userId,  Anchor anchor,  String content,  bool resolved,  String? resolvedBy,  DateTime? resolvedAt,  List<ReplyModel> replies,  String type,  Map<String, dynamic>? suggestedDelta,  DateTime? createdAt,  DateTime? updatedAt,  UserModel? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.documentId,_that.userId,_that.anchor,_that.content,_that.resolved,_that.resolvedBy,_that.resolvedAt,_that.replies,_that.type,_that.suggestedDelta,_that.createdAt,_that.updatedAt,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String documentId,  String userId,  Anchor anchor,  String content,  bool resolved,  String? resolvedBy,  DateTime? resolvedAt,  List<ReplyModel> replies,  String type,  Map<String, dynamic>? suggestedDelta,  DateTime? createdAt,  DateTime? updatedAt,  UserModel? user)  $default,) {final _that = this;
switch (_that) {
case _CommentModel():
return $default(_that.id,_that.documentId,_that.userId,_that.anchor,_that.content,_that.resolved,_that.resolvedBy,_that.resolvedAt,_that.replies,_that.type,_that.suggestedDelta,_that.createdAt,_that.updatedAt,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String documentId,  String userId,  Anchor anchor,  String content,  bool resolved,  String? resolvedBy,  DateTime? resolvedAt,  List<ReplyModel> replies,  String type,  Map<String, dynamic>? suggestedDelta,  DateTime? createdAt,  DateTime? updatedAt,  UserModel? user)?  $default,) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.documentId,_that.userId,_that.anchor,_that.content,_that.resolved,_that.resolvedBy,_that.resolvedAt,_that.replies,_that.type,_that.suggestedDelta,_that.createdAt,_that.updatedAt,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentModel implements CommentModel {
  const _CommentModel({required this.id, required this.documentId, required this.userId, required this.anchor, required this.content, this.resolved = false, this.resolvedBy, this.resolvedAt, final  List<ReplyModel> replies = const [], this.type = 'comment', final  Map<String, dynamic>? suggestedDelta, this.createdAt, this.updatedAt, this.user}): _replies = replies,_suggestedDelta = suggestedDelta;
  factory _CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

@override final  String id;
@override final  String documentId;
@override final  String userId;
@override final  Anchor anchor;
@override final  String content;
@override@JsonKey() final  bool resolved;
@override final  String? resolvedBy;
@override final  DateTime? resolvedAt;
 final  List<ReplyModel> _replies;
@override@JsonKey() List<ReplyModel> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override@JsonKey() final  String type;
// comment, suggestion
 final  Map<String, dynamic>? _suggestedDelta;
// comment, suggestion
@override Map<String, dynamic>? get suggestedDelta {
  final value = _suggestedDelta;
  if (value == null) return null;
  if (_suggestedDelta is EqualUnmodifiableMapView) return _suggestedDelta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
// Populated fields
@override final  UserModel? user;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentModelCopyWith<_CommentModel> get copyWith => __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.anchor, anchor) || other.anchor == anchor)&&(identical(other.content, content) || other.content == content)&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.resolvedBy, resolvedBy) || other.resolvedBy == resolvedBy)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._suggestedDelta, _suggestedDelta)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,documentId,userId,anchor,content,resolved,resolvedBy,resolvedAt,const DeepCollectionEquality().hash(_replies),type,const DeepCollectionEquality().hash(_suggestedDelta),createdAt,updatedAt,user);

@override
String toString() {
  return 'CommentModel(id: $id, documentId: $documentId, userId: $userId, anchor: $anchor, content: $content, resolved: $resolved, resolvedBy: $resolvedBy, resolvedAt: $resolvedAt, replies: $replies, type: $type, suggestedDelta: $suggestedDelta, createdAt: $createdAt, updatedAt: $updatedAt, user: $user)';
}


}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res> implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(_CommentModel value, $Res Function(_CommentModel) _then) = __$CommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String documentId, String userId, Anchor anchor, String content, bool resolved, String? resolvedBy, DateTime? resolvedAt, List<ReplyModel> replies, String type, Map<String, dynamic>? suggestedDelta, DateTime? createdAt, DateTime? updatedAt, UserModel? user
});


@override $AnchorCopyWith<$Res> get anchor;@override $UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? documentId = null,Object? userId = null,Object? anchor = null,Object? content = null,Object? resolved = null,Object? resolvedBy = freezed,Object? resolvedAt = freezed,Object? replies = null,Object? type = null,Object? suggestedDelta = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? user = freezed,}) {
  return _then(_CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,anchor: null == anchor ? _self.anchor : anchor // ignore: cast_nullable_to_non_nullable
as Anchor,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,resolvedBy: freezed == resolvedBy ? _self.resolvedBy : resolvedBy // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<ReplyModel>,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,suggestedDelta: freezed == suggestedDelta ? _self._suggestedDelta : suggestedDelta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnchorCopyWith<$Res> get anchor {
  
  return $AnchorCopyWith<$Res>(_self.anchor, (value) {
    return _then(_self.copyWith(anchor: value));
  });
}/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$Anchor {

 int get index; int get length;
/// Create a copy of Anchor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnchorCopyWith<Anchor> get copyWith => _$AnchorCopyWithImpl<Anchor>(this as Anchor, _$identity);

  /// Serializes this Anchor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Anchor&&(identical(other.index, index) || other.index == index)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,length);

@override
String toString() {
  return 'Anchor(index: $index, length: $length)';
}


}

/// @nodoc
abstract mixin class $AnchorCopyWith<$Res>  {
  factory $AnchorCopyWith(Anchor value, $Res Function(Anchor) _then) = _$AnchorCopyWithImpl;
@useResult
$Res call({
 int index, int length
});




}
/// @nodoc
class _$AnchorCopyWithImpl<$Res>
    implements $AnchorCopyWith<$Res> {
  _$AnchorCopyWithImpl(this._self, this._then);

  final Anchor _self;
  final $Res Function(Anchor) _then;

/// Create a copy of Anchor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? length = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Anchor].
extension AnchorPatterns on Anchor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Anchor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Anchor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Anchor value)  $default,){
final _that = this;
switch (_that) {
case _Anchor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Anchor value)?  $default,){
final _that = this;
switch (_that) {
case _Anchor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int length)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Anchor() when $default != null:
return $default(_that.index,_that.length);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int length)  $default,) {final _that = this;
switch (_that) {
case _Anchor():
return $default(_that.index,_that.length);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int length)?  $default,) {final _that = this;
switch (_that) {
case _Anchor() when $default != null:
return $default(_that.index,_that.length);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Anchor implements Anchor {
  const _Anchor({required this.index, this.length = 0});
  factory _Anchor.fromJson(Map<String, dynamic> json) => _$AnchorFromJson(json);

@override final  int index;
@override@JsonKey() final  int length;

/// Create a copy of Anchor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnchorCopyWith<_Anchor> get copyWith => __$AnchorCopyWithImpl<_Anchor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnchorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Anchor&&(identical(other.index, index) || other.index == index)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,length);

@override
String toString() {
  return 'Anchor(index: $index, length: $length)';
}


}

/// @nodoc
abstract mixin class _$AnchorCopyWith<$Res> implements $AnchorCopyWith<$Res> {
  factory _$AnchorCopyWith(_Anchor value, $Res Function(_Anchor) _then) = __$AnchorCopyWithImpl;
@override @useResult
$Res call({
 int index, int length
});




}
/// @nodoc
class __$AnchorCopyWithImpl<$Res>
    implements _$AnchorCopyWith<$Res> {
  __$AnchorCopyWithImpl(this._self, this._then);

  final _Anchor _self;
  final $Res Function(_Anchor) _then;

/// Create a copy of Anchor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? length = null,}) {
  return _then(_Anchor(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReplyModel {

 String get userId; String get content; DateTime? get createdAt;// Populated fields
 UserModel? get user;
/// Create a copy of ReplyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplyModelCopyWith<ReplyModel> get copyWith => _$ReplyModelCopyWithImpl<ReplyModel>(this as ReplyModel, _$identity);

  /// Serializes this ReplyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplyModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,content,createdAt,user);

@override
String toString() {
  return 'ReplyModel(userId: $userId, content: $content, createdAt: $createdAt, user: $user)';
}


}

/// @nodoc
abstract mixin class $ReplyModelCopyWith<$Res>  {
  factory $ReplyModelCopyWith(ReplyModel value, $Res Function(ReplyModel) _then) = _$ReplyModelCopyWithImpl;
@useResult
$Res call({
 String userId, String content, DateTime? createdAt, UserModel? user
});


$UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$ReplyModelCopyWithImpl<$Res>
    implements $ReplyModelCopyWith<$Res> {
  _$ReplyModelCopyWithImpl(this._self, this._then);

  final ReplyModel _self;
  final $Res Function(ReplyModel) _then;

/// Create a copy of ReplyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? content = null,Object? createdAt = freezed,Object? user = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}
/// Create a copy of ReplyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReplyModel].
extension ReplyModelPatterns on ReplyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplyModel value)  $default,){
final _that = this;
switch (_that) {
case _ReplyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplyModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReplyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String content,  DateTime? createdAt,  UserModel? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplyModel() when $default != null:
return $default(_that.userId,_that.content,_that.createdAt,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String content,  DateTime? createdAt,  UserModel? user)  $default,) {final _that = this;
switch (_that) {
case _ReplyModel():
return $default(_that.userId,_that.content,_that.createdAt,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String content,  DateTime? createdAt,  UserModel? user)?  $default,) {final _that = this;
switch (_that) {
case _ReplyModel() when $default != null:
return $default(_that.userId,_that.content,_that.createdAt,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplyModel implements ReplyModel {
  const _ReplyModel({required this.userId, required this.content, this.createdAt, this.user});
  factory _ReplyModel.fromJson(Map<String, dynamic> json) => _$ReplyModelFromJson(json);

@override final  String userId;
@override final  String content;
@override final  DateTime? createdAt;
// Populated fields
@override final  UserModel? user;

/// Create a copy of ReplyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplyModelCopyWith<_ReplyModel> get copyWith => __$ReplyModelCopyWithImpl<_ReplyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplyModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,content,createdAt,user);

@override
String toString() {
  return 'ReplyModel(userId: $userId, content: $content, createdAt: $createdAt, user: $user)';
}


}

/// @nodoc
abstract mixin class _$ReplyModelCopyWith<$Res> implements $ReplyModelCopyWith<$Res> {
  factory _$ReplyModelCopyWith(_ReplyModel value, $Res Function(_ReplyModel) _then) = __$ReplyModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String content, DateTime? createdAt, UserModel? user
});


@override $UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$ReplyModelCopyWithImpl<$Res>
    implements _$ReplyModelCopyWith<$Res> {
  __$ReplyModelCopyWithImpl(this._self, this._then);

  final _ReplyModel _self;
  final $Res Function(_ReplyModel) _then;

/// Create a copy of ReplyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? content = null,Object? createdAt = freezed,Object? user = freezed,}) {
  return _then(_ReplyModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}

/// Create a copy of ReplyModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
