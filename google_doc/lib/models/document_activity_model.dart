import 'package:google_doc/models/user_model.dart';

class DocumentActivityModel {
  final String id;
  final String action;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final UserModel user;

  DocumentActivityModel({
    required this.id,
    required this.action,
    required this.metadata,
    required this.createdAt,
    required this.user,
  });

  factory DocumentActivityModel.fromJson(Map<String, dynamic> json) {
    return DocumentActivityModel(
      id: json['_id'],
      action: json['action'],
      metadata: json['metadata'] ?? {},
      createdAt: DateTime.parse(json['createdAt']),
      user: UserModel.fromJson(json['userId']),
    );
  }
}
