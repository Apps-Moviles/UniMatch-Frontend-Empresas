import 'package:flutter/material.dart';
import 'package:unimatch_empresas/features/users/data/api/users_api.dart';
import 'package:unimatch_empresas/features/users/data/repositories/user_repository_impl.dart';
import 'package:unimatch_empresas/features/users/domain/model/user.dart';
import 'package:unimatch_empresas/features/companies/domain/repository/company_repository.dart';
import 'package:unimatch_empresas/features/companies/domain/model/company.dart';
import 'package:unimatch_empresas/features/companies/data/api/companies_api.dart';
import 'package:unimatch_empresas/features/companies/data/repositories/company_repository_impl.dart';

class UserViewModel extends ChangeNotifier {
  final _userRepository = UserRepositoryImpl(UsersApi());
  final _companyRepository = CompanyRepositoryImpl(CompaniesApi());

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
      final user = await _userRepository.login(
        email: email,
        password: password,
        role: 'company',
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

  Future<bool> registerCompanyWithUser({
    required String name,
    required String email,
    required String password,
    required String companyName,
    required String sector,
    required String location,
    required String phone,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Paso 1: crear usuario
      final newUser = await _userRepository.createUser(
        User(
          name: name,
          email: email,
          password: password,
          role: 'company',
        ),
      );

      // Paso 2: crear compañía con userId asignado
      final newCompany = Company(
        userId: newUser.id!,
        companyName: companyName,
        sector: sector,
        location: location,
        email: email,
        phone: phone,
      );

      await _companyRepository.createCompany(newCompany);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al registrar la compañía';
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
