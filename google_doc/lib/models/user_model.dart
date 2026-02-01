import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    String? token,
    String? profilePic,
    @Default('local') String provider,
    @Default(true) bool isEmailVerified,
    @Default(false) bool isBlocked,
    UserPreferences? preferences,
    DateTime? lastActiveAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default('light') String theme,
    @Default(14) int fontSize,
    @Default('Inter') String fontFamily,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}