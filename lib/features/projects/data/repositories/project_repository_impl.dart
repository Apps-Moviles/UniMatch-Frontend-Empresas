import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../shared/network/api_config.dart';
import '../../domain/model/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../api/project_api.dart';

class ProjectRepositoryImpl implements IProjectRepository {
  final ProjectApi api;
  final http.Client client = http.Client();

  ProjectRepositoryImpl(this.api);

  @override
  Future<List<Project>> getAll() => api.fetchProjects();

  @override
  Future<Project> create(Project project) async {
    final response = await client.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      final List<dynamic> projects = jsonDecode(response.body);

      // Paso 1: Obtener el ID máximo actual
      int maxId = projects
          .map((p) => int.tryParse(p['id'].toString()) ?? 0)
          .fold(0, (a, b) => a > b ? a : b);

      // Paso 2: Crear nuevo proyecto con ID + 1
      final newProject = project.copyWith(id: (maxId + 1));

      // Paso 3: Guardar en el JSON
      final postResponse = await client.post(
        Uri.parse('$baseUrl/projects'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(newProject.toJson()),
      );

      if (postResponse.statusCode == 201) {
        return Project.fromJson(jsonDecode(postResponse.body));
      } else {
        throw Exception('Error al crear proyecto');
      }
    } else {
      throw Exception('Error al obtener proyectos');
    }
  }

  @override
  Future<void> delete(int id) => api.deleteProject(id);

  @override
  Future<void> update(Project project) => api.updateProject(project);
}
