import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unimatch_empresas/shared/network/api_config.dart';
import 'package:unimatch_empresas/shared/network/api_client.dart';
import '../../domain/model/student.dart';

class StudentApi {
  /// GET /students
  Future<List<Student>> getAllStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/students'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener estudiantes");
    }
  }

  /// GET /students/:id
  Future<Student> getStudentById(String id) async {
    final http.Response response = await ApiClient.get('/students/$id');

    if (response.statusCode != 200) {
      throw Exception('Error al obtener estudiante por id: ${response.statusCode}');
    }

    final Map<String, dynamic> json =
    jsonDecode(response.body) as Map<String, dynamic>;

    return Student.fromJson(json);
  }


  /// POST /students
  Future<Student> createStudent(Student student) async {
    final http.Response response = await ApiClient.post(
      '/students',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear estudiante: ${response.statusCode}');
    }

    final Map<String, dynamic> json =
    jsonDecode(response.body) as Map<String, dynamic>;

    return Student.fromJson(json);
  }

  /// PUT /students/:id
  Future<void> updateStudent(Student student) async {
    final http.Response response = await ApiClient.put(
      '/students/${student.id}',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar estudiante');
    }
  }

  /// DELETE /students/:id
  Future<void> deleteStudent(String id) async {
    final http.Response response = await ApiClient.delete('/students/$id');

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar estudiante');
    }
  }
}
