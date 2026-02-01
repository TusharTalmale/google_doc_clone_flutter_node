import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_doc/models/user_model.dart';

part 'version_model.freezed.dart';
part 'version_model.g.dart';

@freezed
abstract class VersionModel with _$VersionModel {
  const factory VersionModel({
    required String id,
    required String documentId,
    required int versionNumber,
    required List<dynamic> snapshot,
    String? createdBy,
    @Default('auto') String reason,
    DateTime? savedAt,
    
    // Populated fields
    UserModel? creator,
  }) = _VersionModel;

  factory VersionModel.fromJson(Map<String, dynamic> json) =>
      _$VersionModelFromJson(json);
}