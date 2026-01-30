class SaveState {
  final String status;
  final DateTime? lastSavedAt;

  SaveState({
    required this.status,
    this.lastSavedAt,
  });

  factory SaveState.fromJson(Map<String, dynamic> json) {
    return SaveState(
      status: json['status'] ?? 'saved',
      lastSavedAt: json['lastSavedAt'] != null
          ? DateTime.parse(json['lastSavedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'lastSavedAt': lastSavedAt?.toIso8601String(),
    };
  }
}
