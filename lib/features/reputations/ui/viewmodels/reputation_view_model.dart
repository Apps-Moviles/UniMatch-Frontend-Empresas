import 'package:flutter/material.dart';
import '../../../reputations/domain/model/reputation.dart';
import '../../../reputations/domain/repository/reputation_repository.dart';
import '../../../students/domain/model/student.dart';
import '../../../students/domain/repository/student_repository.dart';
import '../../../projects/domain/model/project.dart';

class ReputationViewModel extends ChangeNotifier {
  final ReputationRepository repository;
  final StudentRepository studentRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Reputation> _cache = [];
  List<Reputation> get reputations => _cache;

  ReputationViewModel(
      this.repository,
      this.studentRepository,
      );


  Future<void> loadAll() async {
    _isLoading = true;
    notifyListeners();

    _cache = await repository.getAllReputations();

    _isLoading = false;
    notifyListeners();
  }


  Future<List<Reputation>> getReputationsByStudentId(int studentId) async {
    return await repository.getReputationsByStudentId(studentId);
  }

  Future<List<Reputation>> getReputationsByProjectId(int projectId) async {
    return await repository.getReputationsByProjectId(projectId);
  }


  Future<Reputation> createReputation(Reputation reputation) async {
    final created = await repository.createReputation(reputation);
    _cache.add(created);
    notifyListeners();
    return created;
  }


  Future<void> _updateStudentRating(int studentId) async {
    // Obtener todas las reputaciones previas
    final reps = await repository.getReputationsByStudentId(studentId);

    if (reps.isEmpty) return;

    // Calcular promedio
    final avg = reps.map((r) => r.rating).reduce((a, b) => a + b) / reps.length;

    // Traer al estudiante actual
    final student = await studentRepository.getStudentById(studentId.toString());

    if (student == null) return;

    // Crear nuevo objeto actualizado
    final updatedStudent = student.copyWith(rating: avg);

    // Guardarlo en db.json
    await studentRepository.updateStudent(updatedStudent);
  }


  Future<void> createReputationsForProject({
    required Project project,
    required List<Student> students,
    required Future<Reputation?> Function(Student student) openForm,
  }) async {

    for (final student in students) {
      final Reputation? rep = await openForm(student);

      if (rep == null) {
        throw Exception(
          'Debes calificar a todos los estudiantes antes de finalizar el proyecto.',
        );
      }

      // 1. Guardar reputación
      await createReputation(rep);

      // 2. Actualizar promedio del estudiante
      await _updateStudentRating(student.id!);

      // 3. MARCAR PROYECTO COMO COMPLETADO PARA ESE ESTUDIANTE (FALTABA)
      await _markProjectAsEnded(student.id!, project.id!);
    }
  }


  Future<void> _markProjectAsEnded(int studentId, int projectId) async {
    final student = await studentRepository.getStudentById(studentId.toString());

    if (student == null) return;

    final List<int> ended = List.from(student.endedProjects);

    if (!ended.contains(projectId)) {
      ended.add(projectId);
    }

    final updated = student.copyWith(endedProjects: ended);

    await studentRepository.updateStudent(updated);
  }

}
