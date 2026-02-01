import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_doc/utils/json_converters.dart';
import 'package:hive/hive.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
abstract class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    required String id,
    required String title,
    required String ownerId,
    @Default([]) List<dynamic> content, // Quill Delta
    required PageSettings page,
    @Default([]) List<Collaborator> collaborators,
    SaveState? saveState,
    Versioning? versioning,
    DocumentStats? stats,
    @Default(false) bool isDeleted,
    @TimestampConverter() DateTime? deletedAt,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @Default(false) bool isPublic,
    @Default('view') String publicAccess,
    String? shareableLink,
    @Default(false) bool isFavorite,
    @Default(0) int revision,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);
}

@freezed
abstract class Collaborator with _$Collaborator {
  const factory Collaborator({
    required String userId,
    required String role, // owner, editor, viewer, commenter
    String? color,
    @TimestampConverter() DateTime? joinedAt,
    @TimestampConverter() DateTime? lastActive,
    int? currentSection,
  }) = _Collaborator;

  factory Collaborator.fromJson(Map<String, dynamic> json) =>
      _$CollaboratorFromJson(json);
}

@freezed
abstract class PageSettings with _$PageSettings {
  const factory PageSettings({
    @Default('A4') String size,
    @Default('portrait') String orientation,
    @Default( Margins()) Margins margin,
    @Default('#FFFFFF') String backgroundColor,
  }) = _PageSettings;

  factory PageSettings.fromJson(Map<String, dynamic> json) =>
      _$PageSettingsFromJson(json);
}

@freezed
abstract class Margins with _$Margins {
  const factory Margins({
    @Default(40) int top,
    @Default(40) int bottom,
    @Default(40) int left,
    @Default(40) int right,
  }) = _Margins;

  factory Margins.fromJson(Map<String, dynamic> json) =>
      _$MarginsFromJson(json);
}

@freezed
abstract class SaveState with _$SaveState {
  const factory SaveState({
    @Default('saved') String status,
    @TimestampConverter() DateTime? lastSavedAt,
  }) = _SaveState;

  factory SaveState.fromJson(Map<String, dynamic> json) =>
      _$SaveStateFromJson(json);
}

@freezed
abstract class Versioning with _$Versioning {
  const factory Versioning({
    @Default(1) int currentVersion,
    @TimestampConverter() DateTime? lastSnapshotAt,
  }) = _Versioning;

  factory Versioning.fromJson(Map<String, dynamic> json) =>
      _$VersioningFromJson(json);
}

@freezed
abstract class DocumentStats with _$DocumentStats {
  const factory DocumentStats({
    @Default(0) int totalEdits,
    @Default(0) int wordCount,
    String? lastEditor,
  }) = _DocumentStats;

  factory DocumentStats.fromJson(Map<String, dynamic> json) =>
      _$DocumentStatsFromJson(json);
}

// @freezed
// class FavoriteInfo with _$FavoriteInfo {
//   const factory FavoriteInfo({
//     required String userId,
//     DateTime? addedAt,
//   }) = _FavoriteInfo;

//   factory FavoriteInfo.fromJson(Map<String, dynamic> json) =>
//       _$FavoriteInfoFromJson(json);
// }

// // For creating/updating
// @freezed
// class DocumentUpdate with _$DocumentUpdate {
//   const DocumentUpdate._();
//   const factory DocumentUpdate({
//     String? title,
//     List<dynamic>? content,
//     PageSettings? page,
//   }) = _DocumentUpdate;

//   Map<String, dynamic> toJson() => {
//         if (title != null) 'title': title,
//         if (content != null) 'content': content,
//         if (page != null) 'page': page!.toJson(),
//       };
// }

class DocumentModelAdapter extends TypeAdapter<DocumentModel> {
  @override
  final int typeId = 0;

  @override
  DocumentModel read(BinaryReader reader) {
    return DocumentModel.fromJson(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, DocumentModel obj) {
    writer.writeMap(obj.toJson());
  }
}