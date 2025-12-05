import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unimatch_empresas/features/projects/domain/model/project.dart';
import 'package:unimatch_empresas/shared/network/api_client.dart';

class ProjectApi {
  /// GET /projects
  Future<List<Project>> fetchProjects() async {
    final http.Response response = await ApiClient.get('/projects');

    if (response.statusCode != 200) {
      throw Exception('Error al obtener proyectos: ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;

    return jsonList
        .map((item) => Project.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// POST /projects
  Future<Project> createProject(Project project) async {
    final http.Response response = await ApiClient.post(
      '/projects',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(project.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear proyecto: ${response.statusCode}');
    }

    final Map<String, dynamic> json =
    jsonDecode(response.body) as Map<String, dynamic>;

    return Project.fromJson(json);
  }

  /// PUT /projects/:id
  Future<void> updateProject(Project project) async {
    final http.Response response = await ApiClient.put(
      '/projects/${project.id}',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(project.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar proyecto: ${response.statusCode}');
    }
  }

  /// DELETE /projects/:id
  Future<void> deleteProject(int id) async {
    final http.Response response = await ApiClient.delete('/projects/$id');

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar proyecto: ${response.statusCode}');
    }
  }
}
