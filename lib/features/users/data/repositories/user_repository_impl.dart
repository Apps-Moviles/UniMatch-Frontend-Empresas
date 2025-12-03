// lib/features/users/data/repositories/user_repository_impl.dart

import 'dart:convert';

import 'package:http/http.dart' as client;
import 'package:unimatch_empresas/features/users/data/api/users_api.dart';
import 'package:unimatch_empresas/features/users/domain/repository/user_repository.dart';
import 'package:unimatch_empresas/features/users/domain/model/user.dart';

import '../../../../shared/network/api_config.dart';

class UserRepositoryImpl implements UserRepository {
  final UsersApi _api;

  UserRepositoryImpl(this._api);

  @override
  Future<User?> login({
    required String email,
    required String password,
    required String role,
  }) async {
    // Llamamos al endpoint /users?email=...&password=...&role=...
    final users = await _api.getUsers(
      email: email,
      password: password,
      role: role,
    );

    if (users.isEmpty) {
      return null;
    }

    // En nuestro modelo, debería retornar siempre máximo 1,
    // pero por si acaso, devolvemos el primero.
    return users.first;
  }

  @override
  Future<User> createUser(User user) async {
    final response = await client.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);

      // Paso 1: Buscar el ID más alto
      int maxId = users
          .map((u) => int.tryParse(u['id'].toString()) ?? 0)
          .fold(0, (a, b) => a > b ? a : b);

      // Paso 2: Crear un nuevo usuario con ID incrementado
      final newUser = user.copyWith(id: (maxId + 1));

      // Paso 3: Guardar en la base de datos (json)
      final postResponse = await client.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newUser.toJson()),
      );

      if (postResponse.statusCode == 201) {
        return User.fromJson(jsonDecode(postResponse.body));
      } else {
        throw Exception('Error al crear usuario');
      }
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }


  @override
  Future<User?> getUserById(int id) {
    return _api.getUserById(id);
  }

  @override
  Future<List<User>> getAllUsers() async {   // 👈 NUEVO
    return _api.getAllUsers();
  }

  @override
  Future<User> updateUser(User user) async {
    return await _api.updateUser(user);
  }

}
