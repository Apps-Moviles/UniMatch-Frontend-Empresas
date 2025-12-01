// lib/features/companies/ui/viewmodels/company_view_model.dart

import 'package:flutter/material.dart';
import 'package:unimatch_empresas/features/companies/data/api/companies_api.dart';
import 'package:unimatch_empresas/features/companies/data/repositories/company_repository_impl.dart';
import 'package:unimatch_empresas/features/companies/domain/model/company.dart';

class CompanyViewModel extends ChangeNotifier {
  final _companyRepository = CompanyRepositoryImpl(CompaniesApi());

  List<Company> _companies = [];
  String? _errorMessage;

  List<Company> get companies => _companies;
  String? get errorMessage => _errorMessage;

  Future<void> loadCompanies() async {
    try {
      _companies = await _companyRepository.getAllCompanies();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar compañías';
      notifyListeners();
    }
  }

  Future<void> createCompany(Company company) async {
    try {
      await _companyRepository.createCompany(company);
      await loadCompanies();
    } catch (e) {
      _errorMessage = 'Error al crear compañía';
      notifyListeners();
    }
  }
}
