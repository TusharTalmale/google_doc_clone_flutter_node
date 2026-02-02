// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'socket_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocketEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocketEvent()';
}


}

/// @nodoc
class $SocketEventCopyWith<$Res>  {
$SocketEventCopyWith(SocketEvent _, $Res Function(SocketEvent) __);
}


/// Adds pattern-matching-related methods to [SocketEvent].
extension SocketEventPatterns on SocketEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DocumentStateEvent value)?  documentState,TResult Function( YjsUpdateEvent value)?  yjsUpdate,TResult Function( PresenceUpdateEvent value)?  presenceUpdate,TResult Function( CursorUpdateEvent value)?  cursorUpdate,TResult Function( SelectionUpdateEvent value)?  selectionUpdate,TResult Function( SaveStatusEvent value)?  saveStatus,TResult Function( ErrorEvent value)?  error,TResult Function( NewCommentEvent value)?  newComment,TResult Function( ReceiveChangesEvent value)?  receiveChanges,TResult Function( DocumentListUpdateEvent value)?  documentListUpdate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DocumentStateEvent() when documentState != null:
return documentState(_that);case YjsUpdateEvent() when yjsUpdate != null:
return yjsUpdate(_that);case PresenceUpdateEvent() when presenceUpdate != null:
return presenceUpdate(_that);case CursorUpdateEvent() when cursorUpdate != null:
return cursorUpdate(_that);case SelectionUpdateEvent() when selectionUpdate != null:
return selectionUpdate(_that);case SaveStatusEvent() when saveStatus != null:
return saveStatus(_that);case ErrorEvent() when error != null:
return error(_that);case NewCommentEvent() when newComment != null:
return newComment(_that);case ReceiveChangesEvent() when receiveChanges != null:
return receiveChanges(_that);case DocumentListUpdateEvent() when documentListUpdate != null:
return documentListUpdate(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DocumentStateEvent value)  documentState,required TResult Function( YjsUpdateEvent value)  yjsUpdate,required TResult Function( PresenceUpdateEvent value)  presenceUpdate,required TResult Function( CursorUpdateEvent value)  cursorUpdate,required TResult Function( SelectionUpdateEvent value)  selectionUpdate,required TResult Function( SaveStatusEvent value)  saveStatus,required TResult Function( ErrorEvent value)  error,required TResult Function( NewCommentEvent value)  newComment,required TResult Function( ReceiveChangesEvent value)  receiveChanges,required TResult Function( DocumentListUpdateEvent value)  documentListUpdate,}){
final _that = this;
switch (_that) {
case DocumentStateEvent():
return documentState(_that);case YjsUpdateEvent():
return yjsUpdate(_that);case PresenceUpdateEvent():
return presenceUpdate(_that);case CursorUpdateEvent():
return cursorUpdate(_that);case SelectionUpdateEvent():
return selectionUpdate(_that);case SaveStatusEvent():
return saveStatus(_that);case ErrorEvent():
return error(_that);case NewCommentEvent():
return newComment(_that);case ReceiveChangesEvent():
return receiveChanges(_that);case DocumentListUpdateEvent():
return documentListUpdate(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DocumentStateEvent value)?  documentState,TResult? Function( YjsUpdateEvent value)?  yjsUpdate,TResult? Function( PresenceUpdateEvent value)?  presenceUpdate,TResult? Function( CursorUpdateEvent value)?  cursorUpdate,TResult? Function( SelectionUpdateEvent value)?  selectionUpdate,TResult? Function( SaveStatusEvent value)?  saveStatus,TResult? Function( ErrorEvent value)?  error,TResult? Function( NewCommentEvent value)?  newComment,TResult? Function( ReceiveChangesEvent value)?  receiveChanges,TResult? Function( DocumentListUpdateEvent value)?  documentListUpdate,}){
final _that = this;
switch (_that) {
case DocumentStateEvent() when documentState != null:
return documentState(_that);case YjsUpdateEvent() when yjsUpdate != null:
return yjsUpdate(_that);case PresenceUpdateEvent() when presenceUpdate != null:
return presenceUpdate(_that);case CursorUpdateEvent() when cursorUpdate != null:
return cursorUpdate(_that);case SelectionUpdateEvent() when selectionUpdate != null:
return selectionUpdate(_that);case SaveStatusEvent() when saveStatus != null:
return saveStatus(_that);case ErrorEvent() when error != null:
return error(_that);case NewCommentEvent() when newComment != null:
return newComment(_that);case ReceiveChangesEvent() when receiveChanges != null:
return receiveChanges(_that);case DocumentListUpdateEvent() when documentListUpdate != null:
return documentListUpdate(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String base64State)?  documentState,TResult Function( String update)?  yjsUpdate,TResult Function( List<Presence> users)?  presenceUpdate,TResult Function( String userId,  Cursor cursor)?  cursorUpdate,TResult Function( String userId,  String name,  String color,  Selection range)?  selectionUpdate,TResult Function( String status,  DateTime? lastSavedAt)?  saveStatus,TResult Function( String message)?  error,TResult Function( Map<String, dynamic> comment)?  newComment,TResult Function( String documentId,  List<dynamic> delta)?  receiveChanges,TResult Function()?  documentListUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DocumentStateEvent() when documentState != null:
return documentState(_that.base64State);case YjsUpdateEvent() when yjsUpdate != null:
return yjsUpdate(_that.update);case PresenceUpdateEvent() when presenceUpdate != null:
return presenceUpdate(_that.users);case CursorUpdateEvent() when cursorUpdate != null:
return cursorUpdate(_that.userId,_that.cursor);case SelectionUpdateEvent() when selectionUpdate != null:
return selectionUpdate(_that.userId,_that.name,_that.color,_that.range);case SaveStatusEvent() when saveStatus != null:
return saveStatus(_that.status,_that.lastSavedAt);case ErrorEvent() when error != null:
return error(_that.message);case NewCommentEvent() when newComment != null:
return newComment(_that.comment);case ReceiveChangesEvent() when receiveChanges != null:
return receiveChanges(_that.documentId,_that.delta);case DocumentListUpdateEvent() when documentListUpdate != null:
return documentListUpdate();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String base64State)  documentState,required TResult Function( String update)  yjsUpdate,required TResult Function( List<Presence> users)  presenceUpdate,required TResult Function( String userId,  Cursor cursor)  cursorUpdate,required TResult Function( String userId,  String name,  String color,  Selection range)  selectionUpdate,required TResult Function( String status,  DateTime? lastSavedAt)  saveStatus,required TResult Function( String message)  error,required TResult Function( Map<String, dynamic> comment)  newComment,required TResult Function( String documentId,  List<dynamic> delta)  receiveChanges,required TResult Function()  documentListUpdate,}) {final _that = this;
switch (_that) {
case DocumentStateEvent():
return documentState(_that.base64State);case YjsUpdateEvent():
return yjsUpdate(_that.update);case PresenceUpdateEvent():
return presenceUpdate(_that.users);case CursorUpdateEvent():
return cursorUpdate(_that.userId,_that.cursor);case SelectionUpdateEvent():
return selectionUpdate(_that.userId,_that.name,_that.color,_that.range);case SaveStatusEvent():
return saveStatus(_that.status,_that.lastSavedAt);case ErrorEvent():
return error(_that.message);case NewCommentEvent():
return newComment(_that.comment);case ReceiveChangesEvent():
return receiveChanges(_that.documentId,_that.delta);case DocumentListUpdateEvent():
return documentListUpdate();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String base64State)?  documentState,TResult? Function( String update)?  yjsUpdate,TResult? Function( List<Presence> users)?  presenceUpdate,TResult? Function( String userId,  Cursor cursor)?  cursorUpdate,TResult? Function( String userId,  String name,  String color,  Selection range)?  selectionUpdate,TResult? Function( String status,  DateTime? lastSavedAt)?  saveStatus,TResult? Function( String message)?  error,TResult? Function( Map<String, dynamic> comment)?  newComment,TResult? Function( String documentId,  List<dynamic> delta)?  receiveChanges,TResult? Function()?  documentListUpdate,}) {final _that = this;
switch (_that) {
case DocumentStateEvent() when documentState != null:
return documentState(_that.base64State);case YjsUpdateEvent() when yjsUpdate != null:
return yjsUpdate(_that.update);case PresenceUpdateEvent() when presenceUpdate != null:
return presenceUpdate(_that.users);case CursorUpdateEvent() when cursorUpdate != null:
return cursorUpdate(_that.userId,_that.cursor);case SelectionUpdateEvent() when selectionUpdate != null:
return selectionUpdate(_that.userId,_that.name,_that.color,_that.range);case SaveStatusEvent() when saveStatus != null:
return saveStatus(_that.status,_that.lastSavedAt);case ErrorEvent() when error != null:
return error(_that.message);case NewCommentEvent() when newComment != null:
return newComment(_that.comment);case ReceiveChangesEvent() when receiveChanges != null:
return receiveChanges(_that.documentId,_that.delta);case DocumentListUpdateEvent() when documentListUpdate != null:
return documentListUpdate();case _:
  return null;

}
}

}

/// @nodoc


class DocumentStateEvent implements SocketEvent {
  const DocumentStateEvent({required this.base64State});
  

 final  String base64State;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStateEventCopyWith<DocumentStateEvent> get copyWith => _$DocumentStateEventCopyWithImpl<DocumentStateEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStateEvent&&(identical(other.base64State, base64State) || other.base64State == base64State));
}


@override
int get hashCode => Object.hash(runtimeType,base64State);

@override
String toString() {
  return 'SocketEvent.documentState(base64State: $base64State)';
}


}

/// @nodoc
abstract mixin class $DocumentStateEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $DocumentStateEventCopyWith(DocumentStateEvent value, $Res Function(DocumentStateEvent) _then) = _$DocumentStateEventCopyWithImpl;
@useResult
$Res call({
 String base64State
});




}
/// @nodoc
class _$DocumentStateEventCopyWithImpl<$Res>
    implements $DocumentStateEventCopyWith<$Res> {
  _$DocumentStateEventCopyWithImpl(this._self, this._then);

  final DocumentStateEvent _self;
  final $Res Function(DocumentStateEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? base64State = null,}) {
  return _then(DocumentStateEvent(
base64State: null == base64State ? _self.base64State : base64State // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class YjsUpdateEvent implements SocketEvent {
  const YjsUpdateEvent({required this.update});
  

 final  String update;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YjsUpdateEventCopyWith<YjsUpdateEvent> get copyWith => _$YjsUpdateEventCopyWithImpl<YjsUpdateEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YjsUpdateEvent&&(identical(other.update, update) || other.update == update));
}


@override
int get hashCode => Object.hash(runtimeType,update);

@override
String toString() {
  return 'SocketEvent.yjsUpdate(update: $update)';
}


}

/// @nodoc
abstract mixin class $YjsUpdateEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $YjsUpdateEventCopyWith(YjsUpdateEvent value, $Res Function(YjsUpdateEvent) _then) = _$YjsUpdateEventCopyWithImpl;
@useResult
$Res call({
 String update
});




}
/// @nodoc
class _$YjsUpdateEventCopyWithImpl<$Res>
    implements $YjsUpdateEventCopyWith<$Res> {
  _$YjsUpdateEventCopyWithImpl(this._self, this._then);

  final YjsUpdateEvent _self;
  final $Res Function(YjsUpdateEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? update = null,}) {
  return _then(YjsUpdateEvent(
update: null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PresenceUpdateEvent implements SocketEvent {
  const PresenceUpdateEvent({required final  List<Presence> users}): _users = users;
  

 final  List<Presence> _users;
 List<Presence> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresenceUpdateEventCopyWith<PresenceUpdateEvent> get copyWith => _$PresenceUpdateEventCopyWithImpl<PresenceUpdateEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresenceUpdateEvent&&const DeepCollectionEquality().equals(other._users, _users));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'SocketEvent.presenceUpdate(users: $users)';
}


}

/// @nodoc
abstract mixin class $PresenceUpdateEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $PresenceUpdateEventCopyWith(PresenceUpdateEvent value, $Res Function(PresenceUpdateEvent) _then) = _$PresenceUpdateEventCopyWithImpl;
@useResult
$Res call({
 List<Presence> users
});




}
/// @nodoc
class _$PresenceUpdateEventCopyWithImpl<$Res>
    implements $PresenceUpdateEventCopyWith<$Res> {
  _$PresenceUpdateEventCopyWithImpl(this._self, this._then);

  final PresenceUpdateEvent _self;
  final $Res Function(PresenceUpdateEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? users = null,}) {
  return _then(PresenceUpdateEvent(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<Presence>,
  ));
}


}

/// @nodoc


class CursorUpdateEvent implements SocketEvent {
  const CursorUpdateEvent({required this.userId, required this.cursor});
  

 final  String userId;
 final  Cursor cursor;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CursorUpdateEventCopyWith<CursorUpdateEvent> get copyWith => _$CursorUpdateEventCopyWithImpl<CursorUpdateEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CursorUpdateEvent&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}


@override
int get hashCode => Object.hash(runtimeType,userId,cursor);

@override
String toString() {
  return 'SocketEvent.cursorUpdate(userId: $userId, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $CursorUpdateEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $CursorUpdateEventCopyWith(CursorUpdateEvent value, $Res Function(CursorUpdateEvent) _then) = _$CursorUpdateEventCopyWithImpl;
@useResult
$Res call({
 String userId, Cursor cursor
});


$CursorCopyWith<$Res> get cursor;

}
/// @nodoc
class _$CursorUpdateEventCopyWithImpl<$Res>
    implements $CursorUpdateEventCopyWith<$Res> {
  _$CursorUpdateEventCopyWithImpl(this._self, this._then);

  final CursorUpdateEvent _self;
  final $Res Function(CursorUpdateEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? cursor = null,}) {
  return _then(CursorUpdateEvent(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Cursor,
  ));
}

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CursorCopyWith<$Res> get cursor {
  
  return $CursorCopyWith<$Res>(_self.cursor, (value) {
    return _then(_self.copyWith(cursor: value));
  });
}
}

/// @nodoc


class SelectionUpdateEvent implements SocketEvent {
  const SelectionUpdateEvent({required this.userId, required this.name, required this.color, required this.range});
  

 final  String userId;
 final  String name;
 final  String color;
 final  Selection range;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectionUpdateEventCopyWith<SelectionUpdateEvent> get copyWith => _$SelectionUpdateEventCopyWithImpl<SelectionUpdateEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectionUpdateEvent&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,userId,name,color,range);

@override
String toString() {
  return 'SocketEvent.selectionUpdate(userId: $userId, name: $name, color: $color, range: $range)';
}


}

/// @nodoc
abstract mixin class $SelectionUpdateEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $SelectionUpdateEventCopyWith(SelectionUpdateEvent value, $Res Function(SelectionUpdateEvent) _then) = _$SelectionUpdateEventCopyWithImpl;
@useResult
$Res call({
 String userId, String name, String color, Selection range
});


$SelectionCopyWith<$Res> get range;

}
/// @nodoc
class _$SelectionUpdateEventCopyWithImpl<$Res>
    implements $SelectionUpdateEventCopyWith<$Res> {
  _$SelectionUpdateEventCopyWithImpl(this._self, this._then);

  final SelectionUpdateEvent _self;
  final $Res Function(SelectionUpdateEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? color = null,Object? range = null,}) {
  return _then(SelectionUpdateEvent(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as Selection,
  ));
}

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectionCopyWith<$Res> get range {
  
  return $SelectionCopyWith<$Res>(_self.range, (value) {
    return _then(_self.copyWith(range: value));
  });
}
}

/// @nodoc


class SaveStatusEvent implements SocketEvent {
  const SaveStatusEvent({required this.status, this.lastSavedAt});
  

 final  String status;
 final  DateTime? lastSavedAt;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveStatusEventCopyWith<SaveStatusEvent> get copyWith => _$SaveStatusEventCopyWithImpl<SaveStatusEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveStatusEvent&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSavedAt, lastSavedAt) || other.lastSavedAt == lastSavedAt));
}


@override
int get hashCode => Object.hash(runtimeType,status,lastSavedAt);

@override
String toString() {
  return 'SocketEvent.saveStatus(status: $status, lastSavedAt: $lastSavedAt)';
}


}

/// @nodoc
abstract mixin class $SaveStatusEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $SaveStatusEventCopyWith(SaveStatusEvent value, $Res Function(SaveStatusEvent) _then) = _$SaveStatusEventCopyWithImpl;
@useResult
$Res call({
 String status, DateTime? lastSavedAt
});




}
/// @nodoc
class _$SaveStatusEventCopyWithImpl<$Res>
    implements $SaveStatusEventCopyWith<$Res> {
  _$SaveStatusEventCopyWithImpl(this._self, this._then);

  final SaveStatusEvent _self;
  final $Res Function(SaveStatusEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lastSavedAt = freezed,}) {
  return _then(SaveStatusEvent(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSavedAt: freezed == lastSavedAt ? _self.lastSavedAt : lastSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class ErrorEvent implements SocketEvent {
  const ErrorEvent({required this.message});
  

 final  String message;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorEventCopyWith<ErrorEvent> get copyWith => _$ErrorEventCopyWithImpl<ErrorEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorEvent&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SocketEvent.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $ErrorEventCopyWith(ErrorEvent value, $Res Function(ErrorEvent) _then) = _$ErrorEventCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorEventCopyWithImpl<$Res>
    implements $ErrorEventCopyWith<$Res> {
  _$ErrorEventCopyWithImpl(this._self, this._then);

  final ErrorEvent _self;
  final $Res Function(ErrorEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorEvent(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NewCommentEvent implements SocketEvent {
  const NewCommentEvent({required final  Map<String, dynamic> comment}): _comment = comment;
  

 final  Map<String, dynamic> _comment;
 Map<String, dynamic> get comment {
  if (_comment is EqualUnmodifiableMapView) return _comment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_comment);
}


/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewCommentEventCopyWith<NewCommentEvent> get copyWith => _$NewCommentEventCopyWithImpl<NewCommentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewCommentEvent&&const DeepCollectionEquality().equals(other._comment, _comment));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_comment));

@override
String toString() {
  return 'SocketEvent.newComment(comment: $comment)';
}


}

/// @nodoc
abstract mixin class $NewCommentEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $NewCommentEventCopyWith(NewCommentEvent value, $Res Function(NewCommentEvent) _then) = _$NewCommentEventCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> comment
});




}
/// @nodoc
class _$NewCommentEventCopyWithImpl<$Res>
    implements $NewCommentEventCopyWith<$Res> {
  _$NewCommentEventCopyWithImpl(this._self, this._then);

  final NewCommentEvent _self;
  final $Res Function(NewCommentEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? comment = null,}) {
  return _then(NewCommentEvent(
comment: null == comment ? _self._comment : comment // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class ReceiveChangesEvent implements SocketEvent {
  const ReceiveChangesEvent({required this.documentId, required final  List<dynamic> delta}): _delta = delta;
  

 final  String documentId;
 final  List<dynamic> _delta;
 List<dynamic> get delta {
  if (_delta is EqualUnmodifiableListView) return _delta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_delta);
}


/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveChangesEventCopyWith<ReceiveChangesEvent> get copyWith => _$ReceiveChangesEventCopyWithImpl<ReceiveChangesEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveChangesEvent&&(identical(other.documentId, documentId) || other.documentId == documentId)&&const DeepCollectionEquality().equals(other._delta, _delta));
}


@override
int get hashCode => Object.hash(runtimeType,documentId,const DeepCollectionEquality().hash(_delta));

@override
String toString() {
  return 'SocketEvent.receiveChanges(documentId: $documentId, delta: $delta)';
}


}

/// @nodoc
abstract mixin class $ReceiveChangesEventCopyWith<$Res> implements $SocketEventCopyWith<$Res> {
  factory $ReceiveChangesEventCopyWith(ReceiveChangesEvent value, $Res Function(ReceiveChangesEvent) _then) = _$ReceiveChangesEventCopyWithImpl;
@useResult
$Res call({
 String documentId, List<dynamic> delta
});




}
/// @nodoc
class _$ReceiveChangesEventCopyWithImpl<$Res>
    implements $ReceiveChangesEventCopyWith<$Res> {
  _$ReceiveChangesEventCopyWithImpl(this._self, this._then);

  final ReceiveChangesEvent _self;
  final $Res Function(ReceiveChangesEvent) _then;

/// Create a copy of SocketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? documentId = null,Object? delta = null,}) {
  return _then(ReceiveChangesEvent(
documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,delta: null == delta ? _self._delta : delta // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

/// @nodoc


class DocumentListUpdateEvent implements SocketEvent {
  const DocumentListUpdateEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentListUpdateEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SocketEvent.documentListUpdate()';
}


}




// dart format on
