// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  token: json['token'] as String?,
  profilePic: json['profilePic'] as String?,
  provider: json['provider'] as String? ?? 'local',
  isEmailVerified: json['isEmailVerified'] as bool? ?? true,
  isBlocked: json['isBlocked'] as bool? ?? false,
  preferences: json['preferences'] == null
      ? null
      : UserPreferences.fromJson(json['preferences'] as Map<String, dynamic>),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'token': instance.token,
      'profilePic': instance.profilePic,
      'provider': instance.provider,
      'isEmailVerified': instance.isEmailVerified,
      'isBlocked': instance.isBlocked,
      'preferences': instance.preferences,
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
    };

_UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    _UserPreferences(
      theme: json['theme'] as String? ?? 'light',
      fontSize: (json['fontSize'] as num?)?.toInt() ?? 14,
      fontFamily: json['fontFamily'] as String? ?? 'Inter',
    );

Map<String, dynamic> _$UserPreferencesToJson(_UserPreferences instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'fontSize': instance.fontSize,
      'fontFamily': instance.fontFamily,
    };
