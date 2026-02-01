// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentModel {

 String get id; String get title; String get ownerId; List<dynamic> get content;// Quill Delta
 PageSettings get page; List<Collaborator> get collaborators; SaveState? get saveState; Versioning? get versioning; DocumentStats? get stats; bool get isDeleted;@TimestampConverter() DateTime? get deletedAt;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt; bool get isPublic; String get publicAccess; String? get shareableLink; bool get isFavorite; int get revision;
/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentModelCopyWith<DocumentModel> get copyWith => _$DocumentModelCopyWithImpl<DocumentModel>(this as DocumentModel, _$identity);

  /// Serializes this DocumentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.collaborators, collaborators)&&(identical(other.saveState, saveState) || other.saveState == saveState)&&(identical(other.versioning, versioning) || other.versioning == versioning)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.publicAccess, publicAccess) || other.publicAccess == publicAccess)&&(identical(other.shareableLink, shareableLink) || other.shareableLink == shareableLink)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,ownerId,const DeepCollectionEquality().hash(content),page,const DeepCollectionEquality().hash(collaborators),saveState,versioning,stats,isDeleted,deletedAt,createdAt,updatedAt,isPublic,publicAccess,shareableLink,isFavorite,revision);

@override
String toString() {
  return 'DocumentModel(id: $id, title: $title, ownerId: $ownerId, content: $content, page: $page, collaborators: $collaborators, saveState: $saveState, versioning: $versioning, stats: $stats, isDeleted: $isDeleted, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, isPublic: $isPublic, publicAccess: $publicAccess, shareableLink: $shareableLink, isFavorite: $isFavorite, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $DocumentModelCopyWith<$Res>  {
  factory $DocumentModelCopyWith(DocumentModel value, $Res Function(DocumentModel) _then) = _$DocumentModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String ownerId, List<dynamic> content, PageSettings page, List<Collaborator> collaborators, SaveState? saveState, Versioning? versioning, DocumentStats? stats, bool isDeleted,@TimestampConverter() DateTime? deletedAt,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, bool isPublic, String publicAccess, String? shareableLink, bool isFavorite, int revision
});


$PageSettingsCopyWith<$Res> get page;$SaveStateCopyWith<$Res>? get saveState;$VersioningCopyWith<$Res>? get versioning;$DocumentStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class _$DocumentModelCopyWithImpl<$Res>
    implements $DocumentModelCopyWith<$Res> {
  _$DocumentModelCopyWithImpl(this._self, this._then);

  final DocumentModel _self;
  final $Res Function(DocumentModel) _then;

/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? ownerId = null,Object? content = null,Object? page = null,Object? collaborators = null,Object? saveState = freezed,Object? versioning = freezed,Object? stats = freezed,Object? isDeleted = null,Object? deletedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isPublic = null,Object? publicAccess = null,Object? shareableLink = freezed,Object? isFavorite = null,Object? revision = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<dynamic>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as PageSettings,collaborators: null == collaborators ? _self.collaborators : collaborators // ignore: cast_nullable_to_non_nullable
as List<Collaborator>,saveState: freezed == saveState ? _self.saveState : saveState // ignore: cast_nullable_to_non_nullable
as SaveState?,versioning: freezed == versioning ? _self.versioning : versioning // ignore: cast_nullable_to_non_nullable
as Versioning?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DocumentStats?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,publicAccess: null == publicAccess ? _self.publicAccess : publicAccess // ignore: cast_nullable_to_non_nullable
as String,shareableLink: freezed == shareableLink ? _self.shareableLink : shareableLink // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PageSettingsCopyWith<$Res> get page {
  
  return $PageSettingsCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaveStateCopyWith<$Res>? get saveState {
    if (_self.saveState == null) {
    return null;
  }

  return $SaveStateCopyWith<$Res>(_self.saveState!, (value) {
    return _then(_self.copyWith(saveState: value));
  });
}/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VersioningCopyWith<$Res>? get versioning {
    if (_self.versioning == null) {
    return null;
  }

  return $VersioningCopyWith<$Res>(_self.versioning!, (value) {
    return _then(_self.copyWith(versioning: value));
  });
}/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $DocumentStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// Adds pattern-matching-related methods to [DocumentModel].
extension DocumentModelPatterns on DocumentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentModel value)  $default,){
final _that = this;
switch (_that) {
case _DocumentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentModel value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String ownerId,  List<dynamic> content,  PageSettings page,  List<Collaborator> collaborators,  SaveState? saveState,  Versioning? versioning,  DocumentStats? stats,  bool isDeleted, @TimestampConverter()  DateTime? deletedAt, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt,  bool isPublic,  String publicAccess,  String? shareableLink,  bool isFavorite,  int revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentModel() when $default != null:
return $default(_that.id,_that.title,_that.ownerId,_that.content,_that.page,_that.collaborators,_that.saveState,_that.versioning,_that.stats,_that.isDeleted,_that.deletedAt,_that.createdAt,_that.updatedAt,_that.isPublic,_that.publicAccess,_that.shareableLink,_that.isFavorite,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String ownerId,  List<dynamic> content,  PageSettings page,  List<Collaborator> collaborators,  SaveState? saveState,  Versioning? versioning,  DocumentStats? stats,  bool isDeleted, @TimestampConverter()  DateTime? deletedAt, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt,  bool isPublic,  String publicAccess,  String? shareableLink,  bool isFavorite,  int revision)  $default,) {final _that = this;
switch (_that) {
case _DocumentModel():
return $default(_that.id,_that.title,_that.ownerId,_that.content,_that.page,_that.collaborators,_that.saveState,_that.versioning,_that.stats,_that.isDeleted,_that.deletedAt,_that.createdAt,_that.updatedAt,_that.isPublic,_that.publicAccess,_that.shareableLink,_that.isFavorite,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String ownerId,  List<dynamic> content,  PageSettings page,  List<Collaborator> collaborators,  SaveState? saveState,  Versioning? versioning,  DocumentStats? stats,  bool isDeleted, @TimestampConverter()  DateTime? deletedAt, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt,  bool isPublic,  String publicAccess,  String? shareableLink,  bool isFavorite,  int revision)?  $default,) {final _that = this;
switch (_that) {
case _DocumentModel() when $default != null:
return $default(_that.id,_that.title,_that.ownerId,_that.content,_that.page,_that.collaborators,_that.saveState,_that.versioning,_that.stats,_that.isDeleted,_that.deletedAt,_that.createdAt,_that.updatedAt,_that.isPublic,_that.publicAccess,_that.shareableLink,_that.isFavorite,_that.revision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentModel implements DocumentModel {
  const _DocumentModel({required this.id, required this.title, required this.ownerId, final  List<dynamic> content = const [], required this.page, final  List<Collaborator> collaborators = const [], this.saveState, this.versioning, this.stats, this.isDeleted = false, @TimestampConverter() this.deletedAt, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, this.isPublic = false, this.publicAccess = 'view', this.shareableLink, this.isFavorite = false, this.revision = 0}): _content = content,_collaborators = collaborators;
  factory _DocumentModel.fromJson(Map<String, dynamic> json) => _$DocumentModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String ownerId;
 final  List<dynamic> _content;
@override@JsonKey() List<dynamic> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

// Quill Delta
@override final  PageSettings page;
 final  List<Collaborator> _collaborators;
@override@JsonKey() List<Collaborator> get collaborators {
  if (_collaborators is EqualUnmodifiableListView) return _collaborators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collaborators);
}

@override final  SaveState? saveState;
@override final  Versioning? versioning;
@override final  DocumentStats? stats;
@override@JsonKey() final  bool isDeleted;
@override@TimestampConverter() final  DateTime? deletedAt;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override@JsonKey() final  bool isPublic;
@override@JsonKey() final  String publicAccess;
@override final  String? shareableLink;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  int revision;

/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentModelCopyWith<_DocumentModel> get copyWith => __$DocumentModelCopyWithImpl<_DocumentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other._collaborators, _collaborators)&&(identical(other.saveState, saveState) || other.saveState == saveState)&&(identical(other.versioning, versioning) || other.versioning == versioning)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.publicAccess, publicAccess) || other.publicAccess == publicAccess)&&(identical(other.shareableLink, shareableLink) || other.shareableLink == shareableLink)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.revision, revision) || other.revision == revision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,ownerId,const DeepCollectionEquality().hash(_content),page,const DeepCollectionEquality().hash(_collaborators),saveState,versioning,stats,isDeleted,deletedAt,createdAt,updatedAt,isPublic,publicAccess,shareableLink,isFavorite,revision);

@override
String toString() {
  return 'DocumentModel(id: $id, title: $title, ownerId: $ownerId, content: $content, page: $page, collaborators: $collaborators, saveState: $saveState, versioning: $versioning, stats: $stats, isDeleted: $isDeleted, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, isPublic: $isPublic, publicAccess: $publicAccess, shareableLink: $shareableLink, isFavorite: $isFavorite, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$DocumentModelCopyWith<$Res> implements $DocumentModelCopyWith<$Res> {
  factory _$DocumentModelCopyWith(_DocumentModel value, $Res Function(_DocumentModel) _then) = __$DocumentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String ownerId, List<dynamic> content, PageSettings page, List<Collaborator> collaborators, SaveState? saveState, Versioning? versioning, DocumentStats? stats, bool isDeleted,@TimestampConverter() DateTime? deletedAt,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt, bool isPublic, String publicAccess, String? shareableLink, bool isFavorite, int revision
});


@override $PageSettingsCopyWith<$Res> get page;@override $SaveStateCopyWith<$Res>? get saveState;@override $VersioningCopyWith<$Res>? get versioning;@override $DocumentStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class __$DocumentModelCopyWithImpl<$Res>
    implements _$DocumentModelCopyWith<$Res> {
  __$DocumentModelCopyWithImpl(this._self, this._then);

  final _DocumentModel _self;
  final $Res Function(_DocumentModel) _then;

/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? ownerId = null,Object? content = null,Object? page = null,Object? collaborators = null,Object? saveState = freezed,Object? versioning = freezed,Object? stats = freezed,Object? isDeleted = null,Object? deletedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isPublic = null,Object? publicAccess = null,Object? shareableLink = freezed,Object? isFavorite = null,Object? revision = null,}) {
  return _then(_DocumentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<dynamic>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as PageSettings,collaborators: null == collaborators ? _self._collaborators : collaborators // ignore: cast_nullable_to_non_nullable
as List<Collaborator>,saveState: freezed == saveState ? _self.saveState : saveState // ignore: cast_nullable_to_non_nullable
as SaveState?,versioning: freezed == versioning ? _self.versioning : versioning // ignore: cast_nullable_to_non_nullable
as Versioning?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as DocumentStats?,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,publicAccess: null == publicAccess ? _self.publicAccess : publicAccess // ignore: cast_nullable_to_non_nullable
as String,shareableLink: freezed == shareableLink ? _self.shareableLink : shareableLink // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PageSettingsCopyWith<$Res> get page {
  
  return $PageSettingsCopyWith<$Res>(_self.page, (value) {
    return _then(_self.copyWith(page: value));
  });
}/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaveStateCopyWith<$Res>? get saveState {
    if (_self.saveState == null) {
    return null;
  }

  return $SaveStateCopyWith<$Res>(_self.saveState!, (value) {
    return _then(_self.copyWith(saveState: value));
  });
}/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VersioningCopyWith<$Res>? get versioning {
    if (_self.versioning == null) {
    return null;
  }

  return $VersioningCopyWith<$Res>(_self.versioning!, (value) {
    return _then(_self.copyWith(versioning: value));
  });
}/// Create a copy of DocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $DocumentStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}


/// @nodoc
mixin _$Collaborator {

 String get userId; String get role;// owner, editor, viewer, commenter
 String? get color;@TimestampConverter() DateTime? get joinedAt;@TimestampConverter() DateTime? get lastActive; int? get currentSection;
/// Create a copy of Collaborator
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollaboratorCopyWith<Collaborator> get copyWith => _$CollaboratorCopyWithImpl<Collaborator>(this as Collaborator, _$identity);

  /// Serializes this Collaborator to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Collaborator&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.color, color) || other.color == color)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive)&&(identical(other.currentSection, currentSection) || other.currentSection == currentSection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,role,color,joinedAt,lastActive,currentSection);

@override
String toString() {
  return 'Collaborator(userId: $userId, role: $role, color: $color, joinedAt: $joinedAt, lastActive: $lastActive, currentSection: $currentSection)';
}


}

/// @nodoc
abstract mixin class $CollaboratorCopyWith<$Res>  {
  factory $CollaboratorCopyWith(Collaborator value, $Res Function(Collaborator) _then) = _$CollaboratorCopyWithImpl;
@useResult
$Res call({
 String userId, String role, String? color,@TimestampConverter() DateTime? joinedAt,@TimestampConverter() DateTime? lastActive, int? currentSection
});




}
/// @nodoc
class _$CollaboratorCopyWithImpl<$Res>
    implements $CollaboratorCopyWith<$Res> {
  _$CollaboratorCopyWithImpl(this._self, this._then);

  final Collaborator _self;
  final $Res Function(Collaborator) _then;

/// Create a copy of Collaborator
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? role = null,Object? color = freezed,Object? joinedAt = freezed,Object? lastActive = freezed,Object? currentSection = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActive: freezed == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime?,currentSection: freezed == currentSection ? _self.currentSection : currentSection // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Collaborator].
extension CollaboratorPatterns on Collaborator {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Collaborator value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Collaborator() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Collaborator value)  $default,){
final _that = this;
switch (_that) {
case _Collaborator():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Collaborator value)?  $default,){
final _that = this;
switch (_that) {
case _Collaborator() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String role,  String? color, @TimestampConverter()  DateTime? joinedAt, @TimestampConverter()  DateTime? lastActive,  int? currentSection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Collaborator() when $default != null:
return $default(_that.userId,_that.role,_that.color,_that.joinedAt,_that.lastActive,_that.currentSection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String role,  String? color, @TimestampConverter()  DateTime? joinedAt, @TimestampConverter()  DateTime? lastActive,  int? currentSection)  $default,) {final _that = this;
switch (_that) {
case _Collaborator():
return $default(_that.userId,_that.role,_that.color,_that.joinedAt,_that.lastActive,_that.currentSection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String role,  String? color, @TimestampConverter()  DateTime? joinedAt, @TimestampConverter()  DateTime? lastActive,  int? currentSection)?  $default,) {final _that = this;
switch (_that) {
case _Collaborator() when $default != null:
return $default(_that.userId,_that.role,_that.color,_that.joinedAt,_that.lastActive,_that.currentSection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Collaborator implements Collaborator {
  const _Collaborator({required this.userId, required this.role, this.color, @TimestampConverter() this.joinedAt, @TimestampConverter() this.lastActive, this.currentSection});
  factory _Collaborator.fromJson(Map<String, dynamic> json) => _$CollaboratorFromJson(json);

@override final  String userId;
@override final  String role;
// owner, editor, viewer, commenter
@override final  String? color;
@override@TimestampConverter() final  DateTime? joinedAt;
@override@TimestampConverter() final  DateTime? lastActive;
@override final  int? currentSection;

/// Create a copy of Collaborator
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollaboratorCopyWith<_Collaborator> get copyWith => __$CollaboratorCopyWithImpl<_Collaborator>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollaboratorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Collaborator&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.color, color) || other.color == color)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.lastActive, lastActive) || other.lastActive == lastActive)&&(identical(other.currentSection, currentSection) || other.currentSection == currentSection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,role,color,joinedAt,lastActive,currentSection);

@override
String toString() {
  return 'Collaborator(userId: $userId, role: $role, color: $color, joinedAt: $joinedAt, lastActive: $lastActive, currentSection: $currentSection)';
}


}

/// @nodoc
abstract mixin class _$CollaboratorCopyWith<$Res> implements $CollaboratorCopyWith<$Res> {
  factory _$CollaboratorCopyWith(_Collaborator value, $Res Function(_Collaborator) _then) = __$CollaboratorCopyWithImpl;
@override @useResult
$Res call({
 String userId, String role, String? color,@TimestampConverter() DateTime? joinedAt,@TimestampConverter() DateTime? lastActive, int? currentSection
});




}
/// @nodoc
class __$CollaboratorCopyWithImpl<$Res>
    implements _$CollaboratorCopyWith<$Res> {
  __$CollaboratorCopyWithImpl(this._self, this._then);

  final _Collaborator _self;
  final $Res Function(_Collaborator) _then;

/// Create a copy of Collaborator
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? role = null,Object? color = freezed,Object? joinedAt = freezed,Object? lastActive = freezed,Object? currentSection = freezed,}) {
  return _then(_Collaborator(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActive: freezed == lastActive ? _self.lastActive : lastActive // ignore: cast_nullable_to_non_nullable
as DateTime?,currentSection: freezed == currentSection ? _self.currentSection : currentSection // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PageSettings {

 String get size; String get orientation; Margins get margin; String get backgroundColor;
/// Create a copy of PageSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageSettingsCopyWith<PageSettings> get copyWith => _$PageSettingsCopyWithImpl<PageSettings>(this as PageSettings, _$identity);

  /// Serializes this PageSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageSettings&&(identical(other.size, size) || other.size == size)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,orientation,margin,backgroundColor);

@override
String toString() {
  return 'PageSettings(size: $size, orientation: $orientation, margin: $margin, backgroundColor: $backgroundColor)';
}


}

/// @nodoc
abstract mixin class $PageSettingsCopyWith<$Res>  {
  factory $PageSettingsCopyWith(PageSettings value, $Res Function(PageSettings) _then) = _$PageSettingsCopyWithImpl;
@useResult
$Res call({
 String size, String orientation, Margins margin, String backgroundColor
});


$MarginsCopyWith<$Res> get margin;

}
/// @nodoc
class _$PageSettingsCopyWithImpl<$Res>
    implements $PageSettingsCopyWith<$Res> {
  _$PageSettingsCopyWithImpl(this._self, this._then);

  final PageSettings _self;
  final $Res Function(PageSettings) _then;

/// Create a copy of PageSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? size = null,Object? orientation = null,Object? margin = null,Object? backgroundColor = null,}) {
  return _then(_self.copyWith(
size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as String,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as Margins,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PageSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarginsCopyWith<$Res> get margin {
  
  return $MarginsCopyWith<$Res>(_self.margin, (value) {
    return _then(_self.copyWith(margin: value));
  });
}
}


/// Adds pattern-matching-related methods to [PageSettings].
extension PageSettingsPatterns on PageSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageSettings value)  $default,){
final _that = this;
switch (_that) {
case _PageSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PageSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String size,  String orientation,  Margins margin,  String backgroundColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageSettings() when $default != null:
return $default(_that.size,_that.orientation,_that.margin,_that.backgroundColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String size,  String orientation,  Margins margin,  String backgroundColor)  $default,) {final _that = this;
switch (_that) {
case _PageSettings():
return $default(_that.size,_that.orientation,_that.margin,_that.backgroundColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String size,  String orientation,  Margins margin,  String backgroundColor)?  $default,) {final _that = this;
switch (_that) {
case _PageSettings() when $default != null:
return $default(_that.size,_that.orientation,_that.margin,_that.backgroundColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageSettings implements PageSettings {
  const _PageSettings({this.size = 'A4', this.orientation = 'portrait', this.margin = const Margins(), this.backgroundColor = '#FFFFFF'});
  factory _PageSettings.fromJson(Map<String, dynamic> json) => _$PageSettingsFromJson(json);

@override@JsonKey() final  String size;
@override@JsonKey() final  String orientation;
@override@JsonKey() final  Margins margin;
@override@JsonKey() final  String backgroundColor;

/// Create a copy of PageSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageSettingsCopyWith<_PageSettings> get copyWith => __$PageSettingsCopyWithImpl<_PageSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageSettings&&(identical(other.size, size) || other.size == size)&&(identical(other.orientation, orientation) || other.orientation == orientation)&&(identical(other.margin, margin) || other.margin == margin)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,orientation,margin,backgroundColor);

@override
String toString() {
  return 'PageSettings(size: $size, orientation: $orientation, margin: $margin, backgroundColor: $backgroundColor)';
}


}

/// @nodoc
abstract mixin class _$PageSettingsCopyWith<$Res> implements $PageSettingsCopyWith<$Res> {
  factory _$PageSettingsCopyWith(_PageSettings value, $Res Function(_PageSettings) _then) = __$PageSettingsCopyWithImpl;
@override @useResult
$Res call({
 String size, String orientation, Margins margin, String backgroundColor
});


@override $MarginsCopyWith<$Res> get margin;

}
/// @nodoc
class __$PageSettingsCopyWithImpl<$Res>
    implements _$PageSettingsCopyWith<$Res> {
  __$PageSettingsCopyWithImpl(this._self, this._then);

  final _PageSettings _self;
  final $Res Function(_PageSettings) _then;

/// Create a copy of PageSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? size = null,Object? orientation = null,Object? margin = null,Object? backgroundColor = null,}) {
  return _then(_PageSettings(
size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,orientation: null == orientation ? _self.orientation : orientation // ignore: cast_nullable_to_non_nullable
as String,margin: null == margin ? _self.margin : margin // ignore: cast_nullable_to_non_nullable
as Margins,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PageSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MarginsCopyWith<$Res> get margin {
  
  return $MarginsCopyWith<$Res>(_self.margin, (value) {
    return _then(_self.copyWith(margin: value));
  });
}
}


/// @nodoc
mixin _$Margins {

 int get top; int get bottom; int get left; int get right;
/// Create a copy of Margins
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarginsCopyWith<Margins> get copyWith => _$MarginsCopyWithImpl<Margins>(this as Margins, _$identity);

  /// Serializes this Margins to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Margins&&(identical(other.top, top) || other.top == top)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.left, left) || other.left == left)&&(identical(other.right, right) || other.right == right));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,top,bottom,left,right);

@override
String toString() {
  return 'Margins(top: $top, bottom: $bottom, left: $left, right: $right)';
}


}

/// @nodoc
abstract mixin class $MarginsCopyWith<$Res>  {
  factory $MarginsCopyWith(Margins value, $Res Function(Margins) _then) = _$MarginsCopyWithImpl;
@useResult
$Res call({
 int top, int bottom, int left, int right
});




}
/// @nodoc
class _$MarginsCopyWithImpl<$Res>
    implements $MarginsCopyWith<$Res> {
  _$MarginsCopyWithImpl(this._self, this._then);

  final Margins _self;
  final $Res Function(Margins) _then;

/// Create a copy of Margins
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? top = null,Object? bottom = null,Object? left = null,Object? right = null,}) {
  return _then(_self.copyWith(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as int,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as int,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as int,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Margins].
extension MarginsPatterns on Margins {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Margins value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Margins() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Margins value)  $default,){
final _that = this;
switch (_that) {
case _Margins():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Margins value)?  $default,){
final _that = this;
switch (_that) {
case _Margins() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int top,  int bottom,  int left,  int right)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Margins() when $default != null:
return $default(_that.top,_that.bottom,_that.left,_that.right);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int top,  int bottom,  int left,  int right)  $default,) {final _that = this;
switch (_that) {
case _Margins():
return $default(_that.top,_that.bottom,_that.left,_that.right);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int top,  int bottom,  int left,  int right)?  $default,) {final _that = this;
switch (_that) {
case _Margins() when $default != null:
return $default(_that.top,_that.bottom,_that.left,_that.right);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Margins implements Margins {
  const _Margins({this.top = 40, this.bottom = 40, this.left = 40, this.right = 40});
  factory _Margins.fromJson(Map<String, dynamic> json) => _$MarginsFromJson(json);

@override@JsonKey() final  int top;
@override@JsonKey() final  int bottom;
@override@JsonKey() final  int left;
@override@JsonKey() final  int right;

/// Create a copy of Margins
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarginsCopyWith<_Margins> get copyWith => __$MarginsCopyWithImpl<_Margins>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarginsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Margins&&(identical(other.top, top) || other.top == top)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.left, left) || other.left == left)&&(identical(other.right, right) || other.right == right));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,top,bottom,left,right);

@override
String toString() {
  return 'Margins(top: $top, bottom: $bottom, left: $left, right: $right)';
}


}

/// @nodoc
abstract mixin class _$MarginsCopyWith<$Res> implements $MarginsCopyWith<$Res> {
  factory _$MarginsCopyWith(_Margins value, $Res Function(_Margins) _then) = __$MarginsCopyWithImpl;
@override @useResult
$Res call({
 int top, int bottom, int left, int right
});




}
/// @nodoc
class __$MarginsCopyWithImpl<$Res>
    implements _$MarginsCopyWith<$Res> {
  __$MarginsCopyWithImpl(this._self, this._then);

  final _Margins _self;
  final $Res Function(_Margins) _then;

/// Create a copy of Margins
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? top = null,Object? bottom = null,Object? left = null,Object? right = null,}) {
  return _then(_Margins(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as int,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as int,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as int,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SaveState {

 String get status;@TimestampConverter() DateTime? get lastSavedAt;
/// Create a copy of SaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveStateCopyWith<SaveState> get copyWith => _$SaveStateCopyWithImpl<SaveState>(this as SaveState, _$identity);

  /// Serializes this SaveState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveState&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSavedAt, lastSavedAt) || other.lastSavedAt == lastSavedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,lastSavedAt);

@override
String toString() {
  return 'SaveState(status: $status, lastSavedAt: $lastSavedAt)';
}


}

/// @nodoc
abstract mixin class $SaveStateCopyWith<$Res>  {
  factory $SaveStateCopyWith(SaveState value, $Res Function(SaveState) _then) = _$SaveStateCopyWithImpl;
@useResult
$Res call({
 String status,@TimestampConverter() DateTime? lastSavedAt
});




}
/// @nodoc
class _$SaveStateCopyWithImpl<$Res>
    implements $SaveStateCopyWith<$Res> {
  _$SaveStateCopyWithImpl(this._self, this._then);

  final SaveState _self;
  final $Res Function(SaveState) _then;

/// Create a copy of SaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? lastSavedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSavedAt: freezed == lastSavedAt ? _self.lastSavedAt : lastSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SaveState].
extension SaveStatePatterns on SaveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaveState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaveState value)  $default,){
final _that = this;
switch (_that) {
case _SaveState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaveState value)?  $default,){
final _that = this;
switch (_that) {
case _SaveState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status, @TimestampConverter()  DateTime? lastSavedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaveState() when $default != null:
return $default(_that.status,_that.lastSavedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status, @TimestampConverter()  DateTime? lastSavedAt)  $default,) {final _that = this;
switch (_that) {
case _SaveState():
return $default(_that.status,_that.lastSavedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status, @TimestampConverter()  DateTime? lastSavedAt)?  $default,) {final _that = this;
switch (_that) {
case _SaveState() when $default != null:
return $default(_that.status,_that.lastSavedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaveState implements SaveState {
  const _SaveState({this.status = 'saved', @TimestampConverter() this.lastSavedAt});
  factory _SaveState.fromJson(Map<String, dynamic> json) => _$SaveStateFromJson(json);

@override@JsonKey() final  String status;
@override@TimestampConverter() final  DateTime? lastSavedAt;

/// Create a copy of SaveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveStateCopyWith<_SaveState> get copyWith => __$SaveStateCopyWithImpl<_SaveState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaveStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveState&&(identical(other.status, status) || other.status == status)&&(identical(other.lastSavedAt, lastSavedAt) || other.lastSavedAt == lastSavedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,lastSavedAt);

@override
String toString() {
  return 'SaveState(status: $status, lastSavedAt: $lastSavedAt)';
}


}

/// @nodoc
abstract mixin class _$SaveStateCopyWith<$Res> implements $SaveStateCopyWith<$Res> {
  factory _$SaveStateCopyWith(_SaveState value, $Res Function(_SaveState) _then) = __$SaveStateCopyWithImpl;
@override @useResult
$Res call({
 String status,@TimestampConverter() DateTime? lastSavedAt
});




}
/// @nodoc
class __$SaveStateCopyWithImpl<$Res>
    implements _$SaveStateCopyWith<$Res> {
  __$SaveStateCopyWithImpl(this._self, this._then);

  final _SaveState _self;
  final $Res Function(_SaveState) _then;

/// Create a copy of SaveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? lastSavedAt = freezed,}) {
  return _then(_SaveState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,lastSavedAt: freezed == lastSavedAt ? _self.lastSavedAt : lastSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Versioning {

 int get currentVersion;@TimestampConverter() DateTime? get lastSnapshotAt;
/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VersioningCopyWith<Versioning> get copyWith => _$VersioningCopyWithImpl<Versioning>(this as Versioning, _$identity);

  /// Serializes this Versioning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Versioning&&(identical(other.currentVersion, currentVersion) || other.currentVersion == currentVersion)&&(identical(other.lastSnapshotAt, lastSnapshotAt) || other.lastSnapshotAt == lastSnapshotAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentVersion,lastSnapshotAt);

@override
String toString() {
  return 'Versioning(currentVersion: $currentVersion, lastSnapshotAt: $lastSnapshotAt)';
}


}

/// @nodoc
abstract mixin class $VersioningCopyWith<$Res>  {
  factory $VersioningCopyWith(Versioning value, $Res Function(Versioning) _then) = _$VersioningCopyWithImpl;
@useResult
$Res call({
 int currentVersion,@TimestampConverter() DateTime? lastSnapshotAt
});




}
/// @nodoc
class _$VersioningCopyWithImpl<$Res>
    implements $VersioningCopyWith<$Res> {
  _$VersioningCopyWithImpl(this._self, this._then);

  final Versioning _self;
  final $Res Function(Versioning) _then;

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentVersion = null,Object? lastSnapshotAt = freezed,}) {
  return _then(_self.copyWith(
currentVersion: null == currentVersion ? _self.currentVersion : currentVersion // ignore: cast_nullable_to_non_nullable
as int,lastSnapshotAt: freezed == lastSnapshotAt ? _self.lastSnapshotAt : lastSnapshotAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Versioning].
extension VersioningPatterns on Versioning {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Versioning value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Versioning() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Versioning value)  $default,){
final _that = this;
switch (_that) {
case _Versioning():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Versioning value)?  $default,){
final _that = this;
switch (_that) {
case _Versioning() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentVersion, @TimestampConverter()  DateTime? lastSnapshotAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Versioning() when $default != null:
return $default(_that.currentVersion,_that.lastSnapshotAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentVersion, @TimestampConverter()  DateTime? lastSnapshotAt)  $default,) {final _that = this;
switch (_that) {
case _Versioning():
return $default(_that.currentVersion,_that.lastSnapshotAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentVersion, @TimestampConverter()  DateTime? lastSnapshotAt)?  $default,) {final _that = this;
switch (_that) {
case _Versioning() when $default != null:
return $default(_that.currentVersion,_that.lastSnapshotAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Versioning implements Versioning {
  const _Versioning({this.currentVersion = 1, @TimestampConverter() this.lastSnapshotAt});
  factory _Versioning.fromJson(Map<String, dynamic> json) => _$VersioningFromJson(json);

@override@JsonKey() final  int currentVersion;
@override@TimestampConverter() final  DateTime? lastSnapshotAt;

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VersioningCopyWith<_Versioning> get copyWith => __$VersioningCopyWithImpl<_Versioning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VersioningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Versioning&&(identical(other.currentVersion, currentVersion) || other.currentVersion == currentVersion)&&(identical(other.lastSnapshotAt, lastSnapshotAt) || other.lastSnapshotAt == lastSnapshotAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentVersion,lastSnapshotAt);

@override
String toString() {
  return 'Versioning(currentVersion: $currentVersion, lastSnapshotAt: $lastSnapshotAt)';
}


}

/// @nodoc
abstract mixin class _$VersioningCopyWith<$Res> implements $VersioningCopyWith<$Res> {
  factory _$VersioningCopyWith(_Versioning value, $Res Function(_Versioning) _then) = __$VersioningCopyWithImpl;
@override @useResult
$Res call({
 int currentVersion,@TimestampConverter() DateTime? lastSnapshotAt
});




}
/// @nodoc
class __$VersioningCopyWithImpl<$Res>
    implements _$VersioningCopyWith<$Res> {
  __$VersioningCopyWithImpl(this._self, this._then);

  final _Versioning _self;
  final $Res Function(_Versioning) _then;

/// Create a copy of Versioning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentVersion = null,Object? lastSnapshotAt = freezed,}) {
  return _then(_Versioning(
currentVersion: null == currentVersion ? _self.currentVersion : currentVersion // ignore: cast_nullable_to_non_nullable
as int,lastSnapshotAt: freezed == lastSnapshotAt ? _self.lastSnapshotAt : lastSnapshotAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DocumentStats {

 int get totalEdits; int get wordCount; String? get lastEditor;
/// Create a copy of DocumentStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStatsCopyWith<DocumentStats> get copyWith => _$DocumentStatsCopyWithImpl<DocumentStats>(this as DocumentStats, _$identity);

  /// Serializes this DocumentStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStats&&(identical(other.totalEdits, totalEdits) || other.totalEdits == totalEdits)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.lastEditor, lastEditor) || other.lastEditor == lastEditor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalEdits,wordCount,lastEditor);

@override
String toString() {
  return 'DocumentStats(totalEdits: $totalEdits, wordCount: $wordCount, lastEditor: $lastEditor)';
}


}

/// @nodoc
abstract mixin class $DocumentStatsCopyWith<$Res>  {
  factory $DocumentStatsCopyWith(DocumentStats value, $Res Function(DocumentStats) _then) = _$DocumentStatsCopyWithImpl;
@useResult
$Res call({
 int totalEdits, int wordCount, String? lastEditor
});




}
/// @nodoc
class _$DocumentStatsCopyWithImpl<$Res>
    implements $DocumentStatsCopyWith<$Res> {
  _$DocumentStatsCopyWithImpl(this._self, this._then);

  final DocumentStats _self;
  final $Res Function(DocumentStats) _then;

/// Create a copy of DocumentStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalEdits = null,Object? wordCount = null,Object? lastEditor = freezed,}) {
  return _then(_self.copyWith(
totalEdits: null == totalEdits ? _self.totalEdits : totalEdits // ignore: cast_nullable_to_non_nullable
as int,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,lastEditor: freezed == lastEditor ? _self.lastEditor : lastEditor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentStats].
extension DocumentStatsPatterns on DocumentStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentStats value)  $default,){
final _that = this;
switch (_that) {
case _DocumentStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentStats value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalEdits,  int wordCount,  String? lastEditor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentStats() when $default != null:
return $default(_that.totalEdits,_that.wordCount,_that.lastEditor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalEdits,  int wordCount,  String? lastEditor)  $default,) {final _that = this;
switch (_that) {
case _DocumentStats():
return $default(_that.totalEdits,_that.wordCount,_that.lastEditor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalEdits,  int wordCount,  String? lastEditor)?  $default,) {final _that = this;
switch (_that) {
case _DocumentStats() when $default != null:
return $default(_that.totalEdits,_that.wordCount,_that.lastEditor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentStats implements DocumentStats {
  const _DocumentStats({this.totalEdits = 0, this.wordCount = 0, this.lastEditor});
  factory _DocumentStats.fromJson(Map<String, dynamic> json) => _$DocumentStatsFromJson(json);

@override@JsonKey() final  int totalEdits;
@override@JsonKey() final  int wordCount;
@override final  String? lastEditor;

/// Create a copy of DocumentStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentStatsCopyWith<_DocumentStats> get copyWith => __$DocumentStatsCopyWithImpl<_DocumentStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentStats&&(identical(other.totalEdits, totalEdits) || other.totalEdits == totalEdits)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.lastEditor, lastEditor) || other.lastEditor == lastEditor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalEdits,wordCount,lastEditor);

@override
String toString() {
  return 'DocumentStats(totalEdits: $totalEdits, wordCount: $wordCount, lastEditor: $lastEditor)';
}


}

/// @nodoc
abstract mixin class _$DocumentStatsCopyWith<$Res> implements $DocumentStatsCopyWith<$Res> {
  factory _$DocumentStatsCopyWith(_DocumentStats value, $Res Function(_DocumentStats) _then) = __$DocumentStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalEdits, int wordCount, String? lastEditor
});




}
/// @nodoc
class __$DocumentStatsCopyWithImpl<$Res>
    implements _$DocumentStatsCopyWith<$Res> {
  __$DocumentStatsCopyWithImpl(this._self, this._then);

  final _DocumentStats _self;
  final $Res Function(_DocumentStats) _then;

/// Create a copy of DocumentStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalEdits = null,Object? wordCount = null,Object? lastEditor = freezed,}) {
  return _then(_DocumentStats(
totalEdits: null == totalEdits ? _self.totalEdits : totalEdits // ignore: cast_nullable_to_non_nullable
as int,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,lastEditor: freezed == lastEditor ? _self.lastEditor : lastEditor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
