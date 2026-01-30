class PresenceUserModel {
  final String userId;
  final String name;
  final String color;
  final Map<String, dynamic>? cursor;
  final bool typing;

  PresenceUserModel({
    required this.userId,
    required this.name,
    required this.color,
    this.cursor,
    required this.typing,
  });

  factory PresenceUserModel.fromJson(Map<String, dynamic> json) {
    return PresenceUserModel(
      userId: json['userId'],
      name: json['name'],
      color: json['color'],
      cursor: json['cursor'],
      typing: json['typing'] ?? false,
    );
  }
}
