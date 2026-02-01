// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    _DocumentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      ownerId: json['ownerId'] as String,
      content: json['content'] as List<dynamic>? ?? const [],
      page: PageSettings.fromJson(json['page'] as Map<String, dynamic>),
      collaborators:
          (json['collaborators'] as List<dynamic>?)
              ?.map((e) => Collaborator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      saveState: json['saveState'] == null
          ? null
          : SaveState.fromJson(json['saveState'] as Map<String, dynamic>),
      versioning: json['versioning'] == null
          ? null
          : Versioning.fromJson(json['versioning'] as Map<String, dynamic>),
      stats: json['stats'] == null
          ? null
          : DocumentStats.fromJson(json['stats'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedAt: const TimestampConverter().fromJson(json['deletedAt']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      isPublic: json['isPublic'] as bool? ?? false,
      publicAccess: json['publicAccess'] as String? ?? 'view',
      shareableLink: json['shareableLink'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      revision: (json['revision'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DocumentModelToJson(_DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'ownerId': instance.ownerId,
      'content': instance.content,
      'page': instance.page,
      'collaborators': instance.collaborators,
      'saveState': instance.saveState,
      'versioning': instance.versioning,
      'stats': instance.stats,
      'isDeleted': instance.isDeleted,
      'deletedAt': const TimestampConverter().toJson(instance.deletedAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'isPublic': instance.isPublic,
      'publicAccess': instance.publicAccess,
      'shareableLink': instance.shareableLink,
      'isFavorite': instance.isFavorite,
      'revision': instance.revision,
    };

_Collaborator _$CollaboratorFromJson(Map<String, dynamic> json) =>
    _Collaborator(
      userId: json['userId'] as String,
      role: json['role'] as String,
      color: json['color'] as String?,
      joinedAt: const TimestampConverter().fromJson(json['joinedAt']),
      lastActive: const TimestampConverter().fromJson(json['lastActive']),
      currentSection: (json['currentSection'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CollaboratorToJson(_Collaborator instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'role': instance.role,
      'color': instance.color,
      'joinedAt': const TimestampConverter().toJson(instance.joinedAt),
      'lastActive': const TimestampConverter().toJson(instance.lastActive),
      'currentSection': instance.currentSection,
    };

_PageSettings _$PageSettingsFromJson(Map<String, dynamic> json) =>
    _PageSettings(
      size: json['size'] as String? ?? 'A4',
      orientation: json['orientation'] as String? ?? 'portrait',
      margin: json['margin'] == null
          ? const Margins()
          : Margins.fromJson(json['margin'] as Map<String, dynamic>),
      backgroundColor: json['backgroundColor'] as String? ?? '#FFFFFF',
    );

Map<String, dynamic> _$PageSettingsToJson(_PageSettings instance) =>
    <String, dynamic>{
      'size': instance.size,
      'orientation': instance.orientation,
      'margin': instance.margin,
      'backgroundColor': instance.backgroundColor,
    };

_Margins _$MarginsFromJson(Map<String, dynamic> json) => _Margins(
  top: (json['top'] as num?)?.toInt() ?? 40,
  bottom: (json['bottom'] as num?)?.toInt() ?? 40,
  left: (json['left'] as num?)?.toInt() ?? 40,
  right: (json['right'] as num?)?.toInt() ?? 40,
);

Map<String, dynamic> _$MarginsToJson(_Margins instance) => <String, dynamic>{
  'top': instance.top,
  'bottom': instance.bottom,
  'left': instance.left,
  'right': instance.right,
};

_SaveState _$SaveStateFromJson(Map<String, dynamic> json) => _SaveState(
  status: json['status'] as String? ?? 'saved',
  lastSavedAt: const TimestampConverter().fromJson(json['lastSavedAt']),
);

Map<String, dynamic> _$SaveStateToJson(_SaveState instance) =>
    <String, dynamic>{
      'status': instance.status,
      'lastSavedAt': const TimestampConverter().toJson(instance.lastSavedAt),
    };

_Versioning _$VersioningFromJson(Map<String, dynamic> json) => _Versioning(
  currentVersion: (json['currentVersion'] as num?)?.toInt() ?? 1,
  lastSnapshotAt: const TimestampConverter().fromJson(json['lastSnapshotAt']),
);

Map<String, dynamic> _$VersioningToJson(
  _Versioning instance,
) => <String, dynamic>{
  'currentVersion': instance.currentVersion,
  'lastSnapshotAt': const TimestampConverter().toJson(instance.lastSnapshotAt),
};

_DocumentStats _$DocumentStatsFromJson(Map<String, dynamic> json) =>
    _DocumentStats(
      totalEdits: (json['totalEdits'] as num?)?.toInt() ?? 0,
      wordCount: (json['wordCount'] as num?)?.toInt() ?? 0,
      lastEditor: json['lastEditor'] as String?,
    );

Map<String, dynamic> _$DocumentStatsToJson(_DocumentStats instance) =>
    <String, dynamic>{
      'totalEdits': instance.totalEdits,
      'wordCount': instance.wordCount,
      'lastEditor': instance.lastEditor,
    };
