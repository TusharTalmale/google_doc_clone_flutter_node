class DocumentStatsModel {
  final int totalEdits;
  final int wordCount;
  final String? lastEditor;

  DocumentStatsModel({
    required this.totalEdits,
    required this.wordCount,
    this.lastEditor,
  });

  factory DocumentStatsModel.fromJson(Map<String, dynamic> json) {
    return DocumentStatsModel(
      totalEdits: json['totalEdits'] ?? 0,
      wordCount: json['wordCount'] ?? 0,
      lastEditor: json['lastEditor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEdits': totalEdits,
      'wordCount': wordCount,
      'lastEditor': lastEditor,
    };
  }
}
