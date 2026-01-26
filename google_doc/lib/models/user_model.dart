class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? token;

  UserModel({required this.id, required this.email, this.name, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] != null
        ? json['user'] as Map<String, dynamic>
        : json;
    return UserModel(
      id: user['id'] ?? user['_id'] ?? '',
      email: user['email'] ?? '',
      name: user['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'token': token,
  };

  UserModel copyWith({String? id, String? email, String? name, String? token}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }
}
