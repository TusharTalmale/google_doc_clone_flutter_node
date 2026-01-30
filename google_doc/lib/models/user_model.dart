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


// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String? profilePic;
//   final String provider;
//   final bool isEmailVerified;
//   final bool isBlocked;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.profilePic,
//     required this.provider,
//     required this.isEmailVerified,
//     required this.isBlocked,
//   });

//   // ---------- FROM JSON ----------
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['_id'] ?? json['id'],
//       name: json['name'],
//       email: json['email'],
//       profilePic: json['profilePic'],
//       provider: json['provider'] ?? 'local',
//       isEmailVerified: json['isEmailVerified'] ?? true,
//       isBlocked: json['isBlocked'] ?? false,
//     );
//   }

//   // ---------- TO JSON ----------
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'email': email,
//       'profilePic': profilePic,
//       'provider': provider,
//       'isEmailVerified': isEmailVerified,
//       'isBlocked': isBlocked,
//     };
//   }

//   // ---------- COPY ----------
//   UserModel copyWith({
//     String? id,
//     String? name,
//     String? email,
//     String? profilePic,
//     String? provider,
//     bool? isEmailVerified,
//     bool? isBlocked,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       profilePic: profilePic ?? this.profilePic,
//       provider: provider ?? this.provider,
//       isEmailVerified: isEmailVerified ?? this.isEmailVerified,
//       isBlocked: isBlocked ?? this.isBlocked,
//     );
//   }
// }
