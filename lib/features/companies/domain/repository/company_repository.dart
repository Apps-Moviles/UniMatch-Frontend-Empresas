import 'package:unimatch_empresas/features/companies/domain/model/company.dart';

abstract class CompanyRepository {
  Future<Company> createCompany(Company company);
  Future<Company?> getCompanyByUserId(int userId);
  Future<List<Company>> getAllCompanies();
}
