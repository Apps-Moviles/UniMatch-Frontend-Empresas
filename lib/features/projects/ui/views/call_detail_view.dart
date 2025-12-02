import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../students/domain/model/student.dart';
import '../../../students/ui/viewmodels/student_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';
import '../../domain/model/project.dart';
import '../widgets/student_card.dart';

class CallDetailView extends StatefulWidget {
  final Project project;

  const CallDetailView({super.key, required this.project});

  @override
  State<CallDetailView> createState() => _CallDetailViewState();
}

class _CallDetailViewState extends State<CallDetailView> {
  String careerFilter = '';
  double? ratingFilter;
  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final studentVM = Provider.of<StudentViewModel>(context, listen: false);
    final userVM = Provider.of<UserViewModel>(context, listen: false);
    Future.wait([
      studentVM.loadStudents(),
      userVM.loadUsers()
    ]).then((_) => _applyFilters());
  }

  void _applyFilters() {
    final studentVM = Provider.of<StudentViewModel>(context, listen: false);

    final postulantIds = widget.project.postulants;

    final students = studentVM.students.where((student) {
      final matchesPostulant = postulantIds.contains(student.id.toString());
      final matchesCareer = careerFilter.isEmpty ||
          student.career.toLowerCase().contains(careerFilter.toLowerCase());
      final matchesRating =
          ratingFilter == null || student.rating >= ratingFilter!;
      return matchesPostulant && matchesCareer && matchesRating;
    }).toList();

    setState(() {
      filteredStudents = students;
    });
  }

  String getStudentName(String? userId) {
    final userVM = Provider.of<UserViewModel>(context, listen: false);

    try {
      final id = int.tryParse(userId ?? "");
      if (id == null) return 'Nombre desconocido';

      final user = userVM.users.firstWhere((u) => u.id == id);
      return user.name;
    } catch (e) {
      return 'Nombre desconocido';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.project.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Carrera',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        careerFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<double>(
                    value: ratingFilter,
                    hint: const Text('Calificación'),
                    items: [null, 2.0, 3.0, 4.0, 4.5]
                        .map((rating) => DropdownMenuItem(
                      value: rating,
                      child: Text(rating == null
                          ? 'Todas'
                          : '${rating.toString()}+'),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        ratingFilter = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD479),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Filtrar'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredStudents.isEmpty
                  ? const Center(child: Text("No hay postulantes que coincidan"))
                  : ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];
                  final name = getStudentName(student.userId);
                  return StudentCard(student: student, studentName: name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
