import 'package:unimatch_empresas/features/users/domain/model/user.dart';

/// Contrato del repositorio de usuarios.
/// Aquí NO sabemos si usa http, db local, etc.
/// Solo definimos qué operaciones de negocio necesitamos.
abstract class UserRepository {
  /// Login básico:
  /// Busca un usuario con email, password y role en el backend.
  /// - Si encuentra uno -> retorna User.
  /// - Si no encuentra -> retorna null.
  Future<User?> login({
    required String email,
    required String password,
    required String role, // "company" en nuestro caso
  });

  /// Opcional (para más adelante): registrar un usuario.
  Future<User> createUser(User user);

  /// Opcional: obtener usuario por id.
  Future<User?> getUserById(int id);

  Future<List<User>> getAllUsers();

  Future<User> updateUser(User user);

}
