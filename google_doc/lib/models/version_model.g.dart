// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VersionModel _$VersionModelFromJson(Map<String, dynamic> json) =>
    _VersionModel(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      versionNumber: (json['versionNumber'] as num).toInt(),
      snapshot: json['snapshot'] as List<dynamic>,
      createdBy: json['createdBy'] as String?,
      reason: json['reason'] as String? ?? 'auto',
      savedAt: json['savedAt'] == null
          ? null
          : DateTime.parse(json['savedAt'] as String),
      creator: json['creator'] == null
          ? null
          : UserModel.fromJson(json['creator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VersionModelToJson(_VersionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'versionNumber': instance.versionNumber,
      'snapshot': instance.snapshot,
      'createdBy': instance.createdBy,
      'reason': instance.reason,
      'savedAt': instance.savedAt?.toIso8601String(),
      'creator': instance.creator,
    };
