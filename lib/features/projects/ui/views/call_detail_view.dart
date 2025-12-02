import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../students/domain/model/student.dart';
import '../../../students/ui/viewmodels/student_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';
import '../../domain/model/project.dart';
import '../widgets/student_card.dart';
import '../../../student_postulations/ui/viewmodels/student_postulation_view_model.dart';
import '../../../projects/ui/viewmodels/project_view_model.dart';

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
    final postulationVM = Provider.of<StudentPostulationViewModel>(context, listen: false);

    Future.wait([
      studentVM.loadStudents(),
      userVM.loadUsers(),
      postulationVM.loadPostulations(),
    ]).then((_) => _applyFilters());
  }

  void _applyFilters() {
    final studentVM = Provider.of<StudentViewModel>(context, listen: false);
    final postulantIds = widget.project.postulants;

    final students = studentVM.students.where((student) {
      final matchesPostulant = postulantIds.contains(student.id);
      final matchesCareer = careerFilter.isEmpty ||
          student.career.toLowerCase().contains(careerFilter.toLowerCase());
      final matchesRating = ratingFilter == null || student.rating >= ratingFilter!;
      return matchesPostulant && matchesCareer && matchesRating;
    }).toList();

    setState(() {
      filteredStudents = students;
    });
  }

  String getStudentName(int userId) {
    final userVM = Provider.of<UserViewModel>(context, listen: false);
    try {
      final user = userVM.users.firstWhere((u) => u.id == userId);
      return user.name;
    } catch (_) {
      return 'Nombre desconocido';
    }
  }

  String getStudentEmail(int userId) {
    final userVM = Provider.of<UserViewModel>(context, listen: false);
    try {
      final user = userVM.users.firstWhere((u) => u.id == userId);
      return user.email;
    } catch (_) {
      return 'Correo desconocido';
    }
  }

  Future<void> _finalizarConvocatoria() async {
    final postVM = Provider.of<StudentPostulationViewModel>(context, listen: false);
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);

    // Asegurar que tenemos la versión más reciente del proyecto
    await projectVM.loadProjects();
    final project = projectVM.projects.firstWhere((p) => p.id == widget.project.id);

    try {
      // 1. Aceptar todos los seleccionados
      for (final selectedId in project.studentsSelected) {
        await postVM.acceptPostulation(selectedId, project.id);
      }

      // 2. Rechazar los no seleccionados
      for (final postulantId in project.postulants) {
        if (!project.studentsSelected.contains(postulantId)) {
          await postVM.rejectPostulation(postulantId, project.id);
        }
      }

      // 3. Actualizar estado del proyecto sin perder la lista
      final updatedProject = project.copyWith(
        status: "activo",
      );

      await projectVM.updateProject(updatedProject);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Convocatoria finalizada correctamente")),
        );
        Navigator.pushNamed(context, AppRoutes.calls);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al finalizar: $e")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          widget.project.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                      child: Text(rating == null ? 'Todas' : '${rating.toString()}+'),
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
              child: Column(
                children: [
                  Expanded(
                    child: filteredStudents.isEmpty
                        ? const Center(child: Text("No hay postulantes que coincidan"))
                        : ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];
                        final name = getStudentName(student.userId);
                        final email = getStudentEmail(student.userId);

                        return StudentCard(
                          student: student,
                          studentName: name,
                          studentEmail: email,
                          projectId: widget.project.id,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _finalizarConvocatoria,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD479),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Finalizar convocatoria"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
