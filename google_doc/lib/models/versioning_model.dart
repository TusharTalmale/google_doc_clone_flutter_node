class VersioningModel {
  final int currentVersion;
  final DateTime? lastSnapshotAt;

  VersioningModel({
    required this.currentVersion,
    this.lastSnapshotAt,
  });

  factory VersioningModel.fromJson(Map<String, dynamic> json) {
    return VersioningModel(
      currentVersion: json['currentVersion'] ?? 1,
      lastSnapshotAt: json['lastSnapshotAt'] != null
          ? DateTime.parse(json['lastSnapshotAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentVersion': currentVersion,
      'lastSnapshotAt': lastSnapshotAt?.toIso8601String(),
    };
  }
}
