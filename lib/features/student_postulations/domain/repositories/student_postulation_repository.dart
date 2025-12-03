import '../model/student_postulation.dart';

abstract class StudentPostulationRepository {
  Future<List<StudentPostulation>> getAll();
  Future<StudentPostulation> create(StudentPostulation postulation);
  Future<StudentPostulation> update(int id, StudentPostulation postulation);
}
