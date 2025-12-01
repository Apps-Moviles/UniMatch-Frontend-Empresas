// lib/features/users/data/repositories/user_repository_impl.dart

import 'package:unimatch_empresas/features/users/data/api/users_api.dart';
import 'package:unimatch_empresas/features/users/domain/repository/user_repository.dart';
import 'package:unimatch_empresas/features/users/domain/model/user.dart';

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
  Future<User> createUser(User user) {
    return _api.createUser(user);
  }

  @override
  Future<User?> getUserById(int id) {
    return _api.getUserById(id);
  }
}
