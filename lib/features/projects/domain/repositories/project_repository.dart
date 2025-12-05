import '../model/project.dart';

abstract class IProjectRepository {
  Future<List<Project>> getAll();
  Future<Project> create(Project project);
  Future<void> update(Project project);
  Future<void> delete(int id);
}
