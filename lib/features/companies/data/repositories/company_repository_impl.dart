import 'package:unimatch_empresas/features/companies/data/api/companies_api.dart';
import 'package:unimatch_empresas/features/companies/domain/model/company.dart';
import 'package:unimatch_empresas/features/companies/domain/repository/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompaniesApi _api;

  CompanyRepositoryImpl(this._api);

  @override
  Future<Company> createCompany(Company company) async {
    // 1. Obtener todas las compañías actuales
    final currentCompanies = await getAllCompanies();

    // 2. Calcular el próximo ID
    final maxId = currentCompanies
        .map((c) => c.id ?? 0)
        .reduce((a, b) => a > b ? a : b);

    final nextId = maxId + 1;

    // 3. Crear copia con ID asignado
    final companyWithId = company.copyWith(id: nextId);

    // 4. POST enviando el ID (como string en json)
    return await _api.createCompany(companyWithId);
  }


  @override
  Future<Company?> getCompanyByUserId(int userId) {
    return _api.getCompanyByUserId(userId);
  }

  @override
  Future<List<Company>> getAllCompanies() {
    return _api.getAllCompanies();
  }
}
