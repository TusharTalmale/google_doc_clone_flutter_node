// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Presence _$PresenceFromJson(Map<String, dynamic> json) => _Presence(
  userId: json['userId'] as String,
  name: json['name'] as String,
  color: json['color'] as String,
  cursor: json['cursor'] == null
      ? null
      : Cursor.fromJson(json['cursor'] as Map<String, dynamic>),
  selection: json['selection'] == null
      ? null
      : Selection.fromJson(json['selection'] as Map<String, dynamic>),
  typing: json['typing'] as bool? ?? false,
  lastActive: json['lastActive'] == null
      ? null
      : DateTime.parse(json['lastActive'] as String),
);

Map<String, dynamic> _$PresenceToJson(_Presence instance) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'color': instance.color,
  'cursor': instance.cursor,
  'selection': instance.selection,
  'typing': instance.typing,
  'lastActive': instance.lastActive?.toIso8601String(),
};

_Cursor _$CursorFromJson(Map<String, dynamic> json) => _Cursor(
  index: (json['index'] as num).toInt(),
  length: (json['length'] as num).toInt(),
);

Map<String, dynamic> _$CursorToJson(_Cursor instance) => <String, dynamic>{
  'index': instance.index,
  'length': instance.length,
};

_Selection _$SelectionFromJson(Map<String, dynamic> json) => _Selection(
  index: (json['index'] as num).toInt(),
  length: (json['length'] as num).toInt(),
  color: json['color'] as String?,
);

Map<String, dynamic> _$SelectionToJson(_Selection instance) =>
    <String, dynamic>{
      'index': instance.index,
      'length': instance.length,
      'color': instance.color,
    };
