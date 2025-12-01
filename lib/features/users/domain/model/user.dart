// lib/features/users/domain/model/user.dart

class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String role; // "student" o "company"

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.tryParse(json['id'].toString()),
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
