import '../../domain/model/student_postulation.dart';
import '../../domain/repositories/student_postulation_repository.dart';
import '../api/student_postulation_api.dart';


class StudentPostulationRepositoryImpl implements StudentPostulationRepository {
  final StudentPostulationApi api;

  StudentPostulationRepositoryImpl(this.api);

  @override
  Future<List<StudentPostulation>> getAll() {
    return api.getAll();
  }

  @override
  Future<StudentPostulation> create(StudentPostulation postulation) {
    return api.create(postulation);
  }

  @override
  Future<StudentPostulation> update(int id, StudentPostulation postulation) {
    return api.update(id, postulation);
  }
}
