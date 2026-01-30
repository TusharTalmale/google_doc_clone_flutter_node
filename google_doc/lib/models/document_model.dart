import 'save_state_model.dart';
import 'collaborator_model.dart';
import 'document_stats_model.dart';
import 'page_settings_model.dart';
import 'versioning_model.dart';

class DocumentModel {
  final String id;
  final String title;
  final String ownerId;

  final List<dynamic> content;

  final PageSettingsModel page;
  final List<CollaboratorModel> collaborators;

  final SaveState saveState;
  final VersioningModel versioning;
  final DocumentStatsModel stats;

  final bool isDeleted;
  final DateTime? deletedAt;

  final DateTime createdAt;
  final DateTime updatedAt;

  DocumentModel({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.content,
    required this.page,
    required this.collaborators,
    required this.saveState,
    required this.versioning,
    required this.stats,
    required this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // -------------------------------
  // FROM JSON
  // -------------------------------
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['_id'],
      title: json['title'],
      ownerId: json['ownerId'],

      content: List<dynamic>.from(json['content'] ?? []),

      page: PageSettingsModel.fromJson(json['page'] ?? {}),

      collaborators: (json['collaborators'] as List? ?? [])
          .map((e) => CollaboratorModel.fromJson(e))
          .toList(),

      saveState: SaveState.fromJson(json['saveState'] ?? {}),

      versioning: VersioningModel.fromJson(json['versioning'] ?? {}),

      stats: DocumentStatsModel.fromJson(json['stats'] ?? {}),

      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,

      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // -------------------------------
  // TO JSON
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'ownerId': ownerId,
      'content': content,
      'page': page.toJson(),
      'collaborators': collaborators.map((e) => e.toJson()).toList(),
      'saveState': saveState.toJson(),
      'versioning': versioning.toJson(),
      'stats': stats.toJson(),
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // -------------------------------
  // COPY WITH
  // -------------------------------
  DocumentModel copyWith({
    String? title,
    List<dynamic>? content,
    PageSettingsModel? page,
    List<CollaboratorModel>? collaborators,
    SaveState? saveState,
    VersioningModel? versioning,
    DocumentStatsModel? stats,
    bool? isDeleted,
    DateTime? deletedAt,
    DateTime? updatedAt,
  }) {
    return DocumentModel(
      id: id,
      title: title ?? this.title,
      ownerId: ownerId,
      content: content ?? this.content,
      page: page ?? this.page,
      collaborators: collaborators ?? this.collaborators,
      saveState: saveState ?? this.saveState,
      versioning: versioning ?? this.versioning,
      stats: stats ?? this.stats,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
