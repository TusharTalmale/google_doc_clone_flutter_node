class DocumentVersionModel {
  final String id;
  final int versionNumber;
  final List<dynamic> snapshot;
  final String createdBy;
  final String reason;
  final DateTime savedAt;

  DocumentVersionModel({
    required this.id,
    required this.versionNumber,
    required this.snapshot,
    required this.createdBy,
    required this.reason,
    required this.savedAt,
  });

  factory DocumentVersionModel.fromJson(Map<String, dynamic> json) {
    return DocumentVersionModel(
      id: json['_id'],
      versionNumber: json['versionNumber'],
      snapshot: json['snapshot'],
      createdBy: json['createdBy'],
      reason: json['reason'],
      savedAt: DateTime.parse(json['savedAt']),
    );
  }
}
