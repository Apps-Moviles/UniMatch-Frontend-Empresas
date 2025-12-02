import '../model/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getAllStudents();
  Future<Student> getStudentById(String id);
  Future<Student> createStudent(Student student);
  Future<void> updateStudent(Student student);
  Future<void> deleteStudent(String id);
}
