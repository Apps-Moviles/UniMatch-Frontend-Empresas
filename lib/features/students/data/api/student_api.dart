import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/model/student.dart';

class StudentApi {
  final String baseUrl = "http://localhost:3000/students";

  Future<List<Student>> getAllStudents() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar estudiantes");
    }
  }

  Future<Student> getStudentById(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Estudiante no encontrado");
    }
  }

  Future<Student> createStudent(Student student) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(student.toJson()),
    );
    if (response.statusCode == 201) {
      return Student.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear estudiante");
    }
  }

  Future<void> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse("$baseUrl/${student.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(student.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Error al actualizar estudiante");
    }
  }

  Future<void> deleteStudent(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode != 200) {
      throw Exception("Error al eliminar estudiante");
    }
  }
}
