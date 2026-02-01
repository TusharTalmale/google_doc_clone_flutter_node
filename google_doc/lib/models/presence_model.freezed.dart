// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presence_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Presence {

 String get userId; String get name; String get color; Cursor? get cursor; Selection? get selection; bool get typing; DateTime? get lastActive;
/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresenceCopyWith<Presence> get copyWith => _$PresenceCopyWithImpl<Presence>(this as Presence, _$identity);

  /// Serializes this Presence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Presence&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.typing, typing) || other.typing == typing)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,color,cursor,selection,typing,lastActive);

@override
String toString() {
  return 'Presence(userId: $userId, name: $name, color: $color, cursor: $cursor, selection: $selection, typing: $typing, lastActive: $lastActive)';
}


}

/// @nodoc
abstract mixin class $PresenceCopyWith<$Res>  {
  factory $PresenceCopyWith(Presence value, $Res Function(Presence) _then) = _$PresenceCopyWithImpl;
@useResult
$Res call({
 String userId, String name, String color, Cursor? cursor, Selection? selection, bool typing, DateTime? lastActive
});


$CursorCopyWith<$Res>? get cursor;$SelectionCopyWith<$Res>? get selection;

}
/// @nodoc
class _$PresenceCopyWithImpl<$Res>
    implements $PresenceCopyWith<$Res> {
  _$PresenceCopyWithImpl(this._self, this._then);

  final Presence _self;
  final $Res Function(Presence) _then;

/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = null,Object? color = null,Object? cursor = freezed,Object? selection = freezed,Object? typing = null,Object? lastActive = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Cursor?,selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection?,typing: null == typing ? _self.typing : typing // ignore: cast_nullable_to_non_nullable
as bool,lastActive: freezed == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CursorCopyWith<$Res>? get cursor {
    if (_self.cursor == null) {
    return null;
  }

  return $CursorCopyWith<$Res>(_self.cursor!, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionCopyWith<$Res>? get selection {
    if (_self.selection == null) {
    return null;
  }

  return $SelectionCopyWith<$Res>(_self.selection!, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}


/// Adds pattern-matching-related methods to [Presence].
extension PresencePatterns on Presence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Presence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Presence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Presence value)  $default,){
final _that = this;
switch (_that) {
case _Presence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Presence value)?  $default,){
final _that = this;
switch (_that) {
case _Presence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String name,  String color,  Cursor? cursor,  Selection? selection,  bool typing,  DateTime? lastActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Presence() when $default != null:
return $default(_that.userId,_that.name,_that.color,_that.cursor,_that.selection,_that.typing,_that.lastActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String name,  String color,  Cursor? cursor,  Selection? selection,  bool typing,  DateTime? lastActive)  $default,) {final _that = this;
switch (_that) {
case _Presence():
return $default(_that.userId,_that.name,_that.color,_that.cursor,_that.selection,_that.typing,_that.lastActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String name,  String color,  Cursor? cursor,  Selection? selection,  bool typing,  DateTime? lastActive)?  $default,) {final _that = this;
switch (_that) {
case _Presence() when $default != null:
return $default(_that.userId,_that.name,_that.color,_that.cursor,_that.selection,_that.typing,_that.lastActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Presence implements Presence {
  const _Presence({required this.userId, required this.name, required this.color, this.cursor, this.selection, this.typing = false, this.lastActive});
  factory _Presence.fromJson(Map<String, dynamic> json) => _$PresenceFromJson(json);

@override final  String userId;
@override final  String name;
@override final  String color;
@override final  Cursor? cursor;
@override final  Selection? selection;
@override@JsonKey() final  bool typing;
@override final  DateTime? lastActive;

/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresenceCopyWith<_Presence> get copyWith => __$PresenceCopyWithImpl<_Presence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Presence&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.typing, typing) || other.typing == typing)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,color,cursor,selection,typing,lastActive);

@override
String toString() {
  return 'Presence(userId: $userId, name: $name, color: $color, cursor: $cursor, selection: $selection, typing: $typing, lastActive: $lastActive)';
}


}

/// @nodoc
abstract mixin class _$PresenceCopyWith<$Res> implements $PresenceCopyWith<$Res> {
  factory _$PresenceCopyWith(_Presence value, $Res Function(_Presence) _then) = __$PresenceCopyWithImpl;
@override @useResult
$Res call({
 String userId, String name, String color, Cursor? cursor, Selection? selection, bool typing, DateTime? lastActive
});


@override $CursorCopyWith<$Res>? get cursor;@override $SelectionCopyWith<$Res>? get selection;

}
/// @nodoc
class __$PresenceCopyWithImpl<$Res>
    implements _$PresenceCopyWith<$Res> {
  __$PresenceCopyWithImpl(this._self, this._then);

  final _Presence _self;
  final $Res Function(_Presence) _then;

/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? color = null,Object? cursor = freezed,Object? selection = freezed,Object? typing = null,Object? lastActive = freezed,}) {
  return _then(_Presence(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Cursor?,selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection?,typing: null == typing ? _self.typing : typing // ignore: cast_nullable_to_non_nullable
as bool,lastActive: freezed == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CursorCopyWith<$Res>? get cursor {
    if (_self.cursor == null) {
    return null;
  }

  return $CursorCopyWith<$Res>(_self.cursor!, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}/// Create a copy of Presence
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionCopyWith<$Res>? get selection {
    if (_self.selection == null) {
    return null;
  }

  return $SelectionCopyWith<$Res>(_self.selection!, (value) {
    return _then(_self.copyWith(selection: value));
  });
}
}


/// @nodoc
mixin _$Cursor {

 int get index; int get length;
/// Create a copy of Cursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CursorCopyWith<Cursor> get copyWith => _$CursorCopyWithImpl<Cursor>(this as Cursor, _$identity);

  /// Serializes this Cursor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cursor&&(identical(other.index, index) || other.index == index)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,length);

@override
String toString() {
  return 'Cursor(index: $index, length: $length)';
}


}

/// @nodoc
abstract mixin class $CursorCopyWith<$Res>  {
  factory $CursorCopyWith(Cursor value, $Res Function(Cursor) _then) = _$CursorCopyWithImpl;
@useResult
$Res call({
 int index, int length
});




}
/// @nodoc
class _$CursorCopyWithImpl<$Res>
    implements $CursorCopyWith<$Res> {
  _$CursorCopyWithImpl(this._self, this._then);

  final Cursor _self;
  final $Res Function(Cursor) _then;

/// Create a copy of Cursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? length = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Cursor].
extension CursorPatterns on Cursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cursor value)  $default,){
final _that = this;
switch (_that) {
case _Cursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cursor value)?  $default,){
final _that = this;
switch (_that) {
case _Cursor() when $default != null:
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
case _Cursor() when $default != null:
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
case _Cursor():
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
case _Cursor() when $default != null:
return $default(_that.index,_that.length);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cursor implements Cursor {
  const _Cursor({required this.index, required this.length});
  factory _Cursor.fromJson(Map<String, dynamic> json) => _$CursorFromJson(json);

@override final  int index;
@override final  int length;

/// Create a copy of Cursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CursorCopyWith<_Cursor> get copyWith => __$CursorCopyWithImpl<_Cursor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CursorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cursor&&(identical(other.index, index) || other.index == index)&&(identical(other.length, length) || other.length == length));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,length);

@override
String toString() {
  return 'Cursor(index: $index, length: $length)';
}


}

/// @nodoc
abstract mixin class _$CursorCopyWith<$Res> implements $CursorCopyWith<$Res> {
  factory _$CursorCopyWith(_Cursor value, $Res Function(_Cursor) _then) = __$CursorCopyWithImpl;
@override @useResult
$Res call({
 int index, int length
});




}
/// @nodoc
class __$CursorCopyWithImpl<$Res>
    implements _$CursorCopyWith<$Res> {
  __$CursorCopyWithImpl(this._self, this._then);

  final _Cursor _self;
  final $Res Function(_Cursor) _then;

/// Create a copy of Cursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? length = null,}) {
  return _then(_Cursor(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Selection {

 int get index; int get length; String? get color;
/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionCopyWith<Selection> get copyWith => _$SelectionCopyWithImpl<Selection>(this as Selection, _$identity);

  /// Serializes this Selection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Selection&&(identical(other.index, index) || other.index == index)&&(identical(other.length, length) || other.length == length)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,length,color);

@override
String toString() {
  return 'Selection(index: $index, length: $length, color: $color)';
}


}

/// @nodoc
abstract mixin class $SelectionCopyWith<$Res>  {
  factory $SelectionCopyWith(Selection value, $Res Function(Selection) _then) = _$SelectionCopyWithImpl;
@useResult
$Res call({
 int index, int length, String? color
});




}
/// @nodoc
class _$SelectionCopyWithImpl<$Res>
    implements $SelectionCopyWith<$Res> {
  _$SelectionCopyWithImpl(this._self, this._then);

  final Selection _self;
  final $Res Function(Selection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? length = null,Object? color = freezed,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Selection].
extension SelectionPatterns on Selection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Selection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Selection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Selection value)  $default,){
final _that = this;
switch (_that) {
case _Selection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Selection value)?  $default,){
final _that = this;
switch (_that) {
case _Selection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  int length,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that.index,_that.length,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  int length,  String? color)  $default,) {final _that = this;
switch (_that) {
case _Selection():
return $default(_that.index,_that.length,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  int length,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _Selection() when $default != null:
return $default(_that.index,_that.length,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Selection implements Selection {
  const _Selection({required this.index, required this.length, this.color});
  factory _Selection.fromJson(Map<String, dynamic> json) => _$SelectionFromJson(json);

@override final  int index;
@override final  int length;
@override final  String? color;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectionCopyWith<_Selection> get copyWith => __$SelectionCopyWithImpl<_Selection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Selection&&(identical(other.index, index) || other.index == index)&&(identical(other.length, length) || other.length == length)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,index,length,color);

@override
String toString() {
  return 'Selection(index: $index, length: $length, color: $color)';
}


}

/// @nodoc
abstract mixin class _$SelectionCopyWith<$Res> implements $SelectionCopyWith<$Res> {
  factory _$SelectionCopyWith(_Selection value, $Res Function(_Selection) _then) = __$SelectionCopyWithImpl;
@override @useResult
$Res call({
 int index, int length, String? color
});




}
/// @nodoc
class __$SelectionCopyWithImpl<$Res>
    implements _$SelectionCopyWith<$Res> {
  __$SelectionCopyWithImpl(this._self, this._then);

  final _Selection _self;
  final $Res Function(_Selection) _then;

/// Create a copy of Selection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? length = null,Object? color = freezed,}) {
  return _then(_Selection(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
