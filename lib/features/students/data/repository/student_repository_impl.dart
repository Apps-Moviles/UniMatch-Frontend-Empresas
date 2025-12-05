import '../../domain/model/student.dart';
import '../../domain/repository/student_repository.dart';
import '../api/student_api.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentApi api;

  StudentRepositoryImpl(this.api);

  @override
  Future<List<Student>> getAllStudents() => api.getAllStudents();

  @override
  Future<Student> getStudentById(String id) => api.getStudentById(id);

  @override
  Future<Student> createStudent(Student student) => api.createStudent(student);

  @override
  Future<void> updateStudent(Student student) => api.updateStudent(student);

  @override
  Future<void> deleteStudent(String id) => api.deleteStudent(id);
}
