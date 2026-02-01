// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      userId: json['userId'] as String,
      anchor: Anchor.fromJson(json['anchor'] as Map<String, dynamic>),
      content: json['content'] as String,
      resolved: json['resolved'] as bool? ?? false,
      resolvedBy: json['resolvedBy'] as String?,
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => ReplyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      type: json['type'] as String? ?? 'comment',
      suggestedDelta: json['suggestedDelta'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'userId': instance.userId,
      'anchor': instance.anchor,
      'content': instance.content,
      'resolved': instance.resolved,
      'resolvedBy': instance.resolvedBy,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'replies': instance.replies,
      'type': instance.type,
      'suggestedDelta': instance.suggestedDelta,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'user': instance.user,
    };

_Anchor _$AnchorFromJson(Map<String, dynamic> json) => _Anchor(
  index: (json['index'] as num).toInt(),
  length: (json['length'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AnchorToJson(_Anchor instance) => <String, dynamic>{
  'index': instance.index,
  'length': instance.length,
};

_ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => _ReplyModel(
  userId: json['userId'] as String,
  content: json['content'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ReplyModelToJson(_ReplyModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'user': instance.user,
    };
