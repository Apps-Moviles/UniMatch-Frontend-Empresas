// lib/features/users/data/api/users_api.dart

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unimatch_empresas/features/users/domain/model/user.dart';
import 'package:unimatch_empresas/shared/network/api_client.dart';

import '../../../../shared/network/api_config.dart';

class UsersApi {

  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener usuarios");
    }
  }


  Future<List<User>> getUsers({
    String? email,
    String? password,
    String? role,
  }) async {
    final Map<String, dynamic> queryParams = {};

    if (email != null) queryParams['email'] = email;
    if (password != null) queryParams['password'] = password;
    if (role != null) queryParams['role'] = role;

    final http.Response response = await ApiClient.get(
      '/users',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener usuarios: ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

    return jsonList
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// POST /users para crear un nuevo usuario.
  Future<User> createUser(User user) async {
    final http.Response response = await ApiClient.post(
      '/users',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear usuario: ${response.statusCode}');
    }

    final Map<String, dynamic> json =
    jsonDecode(response.body) as Map<String, dynamic>;

    return User.fromJson(json);
  }

  /// GET /users/:id
  Future<User?> getUserById(int id) async {
    final http.Response response = await ApiClient.get('/users/$id');

    if (response.statusCode == 404) {
      return null;
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Error al obtener usuario por id: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> json =
    jsonDecode(response.body) as Map<String, dynamic>;

    return User.fromJson(json);
  }
}
