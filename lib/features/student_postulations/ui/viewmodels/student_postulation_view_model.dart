import 'package:flutter/material.dart';
import '../../domain/model/student_postulation.dart';
import '../../domain/repositories/student_postulation_repository.dart';

class StudentPostulationViewModel extends ChangeNotifier {
  final StudentPostulationRepository repository;

  StudentPostulationViewModel(this.repository);

  List<StudentPostulation> _postulations = [];
  List<StudentPostulation> get postulations => _postulations;

  Future<void> loadPostulations() async {
    _postulations = await repository.getAll();
    notifyListeners();
  }

  Future<StudentPostulation> acceptPostulation(int studentId, int projectId) async {
    return await updatePostulationStatus(
      studentId: studentId,
      projectId: projectId,
      status: "Aceptado",
    );
  }

  Future<void> setPostulationPending(int studentId, int projectId) async {
    await updatePostulationStatus(
      studentId: studentId,
      projectId: projectId,
      status: "Pendiente",
    );
  }

  Future<void> rejectPostulation(int studentId, int projectId) async {
    await updatePostulationStatus(
      studentId: studentId,
      projectId: projectId,
      status: "Rechazada",
    );
  }

  /// ✅ NUEVA FUNCIÓN GENÉRICA
  Future<StudentPostulation> updatePostulationStatus({
    required int studentId,
    required int projectId,
    required String status,
  }) async {
    final existing = _postulations.firstWhere(
          (p) => p.studentId == studentId && p.projectId == projectId,
      orElse: () => throw Exception("No se encontró la postulación para actualizar"),
    );

    final updated = StudentPostulation(
      id: existing.id,
      studentId: studentId,
      projectId: projectId,
      status: status,
      date: DateTime.now().toIso8601String().split("T")[0],
    );

    final result = await repository.update(existing.id!, updated);
    await loadPostulations();
    return result;
  }
}
