import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/model/project.dart';
import '../../data/repositories/project_repository_impl.dart';
import '../../data/api/project_api.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectRepositoryImpl repository = ProjectRepositoryImpl(ProjectApi());
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  Future<void> loadProjects() async {
    _projects = await repository.getAll();
    notifyListeners();
  }

  Future<void> createProject({
    required String title,
    required String description,
    required int companyId,
    required String field,
    required double budget,
    required List<String> requirements,
  }) async {
    final id = _generateNextId();
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final newProject = Project(
      id: id,
      title: title,
      description: description,
      companyId: companyId,
      studentsSelected: [],
      isFinished: false,
      postulants: [],
      field: field,
      budget: budget,
      createdAt: date,
      requirements: requirements,
      status: 'en revisión',
    );

    await repository.create(newProject);
    await loadProjects();
  }

  Future<void> updateProject(Project project) async {
    await repository.update(project);
    await loadProjects();
  }

  Future<void> deleteProject(int id) async {
    await repository.delete(id);
    await loadProjects();
  }

  int _generateNextId() {
    if (_projects.isEmpty) return 1;
    final ids = _projects.map((p) => p.id).toList()..sort();
    return ids.last + 1;
  }

  Future<void> addSelectedStudent(int projectId, int studentId) async {
    final projectIndex = _projects.indexWhere((p) => p.id == projectId);
    if (projectIndex == -1) return;

    final project = _projects[projectIndex];
    if (!project.studentsSelected.contains(studentId)) {
      final updated = project.copyWith(
        studentsSelected: [...project.studentsSelected, studentId],
      );
      _projects[projectIndex] = updated;
      notifyListeners();
    }
  }

  Future<void> removeSelectedStudent(int projectId, int studentId) async {
    final projectIndex = _projects.indexWhere((p) => p.id == projectId);
    if (projectIndex == -1) return;

    final project = _projects[projectIndex];
    final updatedList = List<int>.from(project.studentsSelected)..remove(studentId);
    final updated = project.copyWith(
      studentsSelected: updatedList,
    );
    _projects[projectIndex] = updated;
    notifyListeners();
  }

}
