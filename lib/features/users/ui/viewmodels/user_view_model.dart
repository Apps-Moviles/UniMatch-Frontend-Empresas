import 'package:flutter/material.dart';
import 'package:unimatch_empresas/features/users/data/api/users_api.dart';
import 'package:unimatch_empresas/features/users/data/repositories/user_repository_impl.dart';
import 'package:unimatch_empresas/features/users/domain/model/user.dart';

class UserViewModel extends ChangeNotifier {
  final _repository = UserRepositoryImpl(UsersApi());

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _repository.login(
        email: email,
        password: password,
        role: 'company', // Importante: debe ser empresa
      );

      if (user != null) {
        _currentUser = user;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Credenciales inválidas o rol incorrecto';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error de conexión';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
