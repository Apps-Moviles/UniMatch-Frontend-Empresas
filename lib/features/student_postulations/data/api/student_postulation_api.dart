import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/network/api_client.dart';
import '../../domain/model/student_postulation.dart';

class StudentPostulationApi {
  Future<List<StudentPostulation>> getAll() async {
    final response = await ApiClient.get('/studentPostulations');

    final List decoded = jsonDecode(response.body);
    return decoded.map((e) => StudentPostulation.fromJson(e)).toList();
  }

  Future<StudentPostulation> create(StudentPostulation postulation) async {
    final response = await ApiClient.post(
      '/studentPostulations',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postulation.toJson()),
    );

    return StudentPostulation.fromJson(jsonDecode(response.body));
  }

  Future<StudentPostulation> update(int id, StudentPostulation postulation) async {
    final response = await ApiClient.put(
      '/studentPostulations/$id',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postulation.toJson()),
    );

    return StudentPostulation.fromJson(jsonDecode(response.body));
  }
}
