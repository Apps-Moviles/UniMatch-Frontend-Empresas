import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unimatch_empresas/features/companies/domain/model/company.dart';
import 'package:unimatch_empresas/shared/network/api_client.dart';

class CompaniesApi {
  Future<Company> createCompany(Company company) async {
    final response = await ApiClient.post(
      '/companies',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear compañía');
    }

    return Company.fromJson(jsonDecode(response.body));
  }

  Future<Company?> getCompanyByUserId(int userId) async {
    final response = await ApiClient.get('/companies', queryParameters: {
      'userId': userId.toString(),
    });

    if (response.statusCode != 200) {
      throw Exception('Error al buscar compañía');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);

    if (jsonList.isEmpty) return null;

    return Company.fromJson(jsonList.first);
  }

  Future<List<Company>> getAllCompanies() async {
    final response = await ApiClient.get('/companies');

    if (response.statusCode != 200) {
      throw Exception('Error al obtener compañías');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList
        .map((item) => Company.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Company> updateCompany(Company company) async {
    final response = await ApiClient.put(
      '/companies/${company.id}',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar compañía');
    }

    return Company.fromJson(jsonDecode(response.body));
  }

}
