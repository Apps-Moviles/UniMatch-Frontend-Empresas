import 'package:flutter/material.dart';
import '../../data/api/student_api.dart';
import '../../data/repository/student_repository_impl.dart';
import '../../domain/model/student.dart';
import '../../domain/repository/student_repository.dart';

class StudentViewModel extends ChangeNotifier {
  final StudentRepository _repository = StudentRepositoryImpl(StudentApi());

  List<Student> _students = [];
  List<Student> get students => _students;

  Student? _selectedStudent;
  Student? get selectedStudent => _selectedStudent;

  Future<void> loadStudents() async {
    _students = await _repository.getAllStudents();
    notifyListeners();
  }

  Future<void> fetchStudentById(String id) async {
    _selectedStudent = await _repository.getStudentById(id);
    notifyListeners();
  }

  Future<void> createStudent(Student student) async {
    final newStudent = await _repository.createStudent(student);
    _students.add(newStudent);
    notifyListeners();
  }

  Future<void> updateStudent(Student student) async {
    await _repository.updateStudent(student);
    final index = _students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      _students[index] = student;
      notifyListeners();
    }
  }

  Future<void> deleteStudent(String id) async {
    await _repository.deleteStudent(id);
    _students.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
