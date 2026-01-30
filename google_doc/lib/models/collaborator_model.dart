class CollaboratorModel {
  final String userId;
  final String role;
  final String color;
  final DateTime joinedAt;
  final DateTime lastActive;

  CollaboratorModel({
    required this.userId,
    required this.role,
    required this.color,
    required this.joinedAt,
    required this.lastActive,
  });

  factory CollaboratorModel.fromJson(Map<String, dynamic> json) {
    return CollaboratorModel(
      userId: json['userId'],
      role: json['role'],
      color: json['color'] ?? '#2196f3',
      joinedAt: DateTime.parse(json['joinedAt']),
      lastActive: DateTime.parse(json['lastActive']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'color': color,
      'joinedAt': joinedAt.toIso8601String(),
      'lastActive': lastActive.toIso8601String(),
    };
  }

  CollaboratorModel copyWith({
    String? role,
    String? color,
    DateTime? lastActive,
  }) {
    return CollaboratorModel(
      userId: userId,
      role: role ?? this.role,
      color: color ?? this.color,
      joinedAt: joinedAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}
