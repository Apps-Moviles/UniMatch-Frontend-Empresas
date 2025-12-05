import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/ui/widgets/bottom_nav_bar.dart';
import '../../../students/ui/viewmodels/student_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';
import '../../../reputations/ui/viewmodels/reputation_view_model.dart';
import '../../../students/domain/model/student.dart';
import '../../../reputations/domain/model/reputation.dart';
import '../../domain/model/project.dart';
import '../viewmodels/project_view_model.dart';
import '../../../reputations/ui/widgets/reputation_form_popup.dart';

class ProjectDetailView extends StatefulWidget {
  final Project project;

  const ProjectDetailView({super.key, required this.project});

  @override
  State<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  late Project project;

  @override
  void initState() {
    super.initState();
    project = widget.project;
  }

  Future<void> _goToEdit() async {
    final updated = await Navigator.pushNamed(
      context,
      AppRoutes.editProject,
      arguments: project,
    );

    if (updated is Project) {
      setState(() {
        project = updated;
      });
    }
  }

  void _deleteProject() async {
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de que deseas eliminar este proyecto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await projectVM.deleteProject(project.id!);
      Navigator.pushNamed(context, AppRoutes.myProjects);
    }
  }

  Future<void> _finalizeProject() async {
    final studentVM = Provider.of<StudentViewModel>(context, listen: false);
    final userVM = Provider.of<UserViewModel>(context, listen: false);
    final reputationVM = Provider.of<ReputationViewModel>(context, listen: false);
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);

    // 1. Obtener estudiantes seleccionados
    final selectedStudentIds = project.studentsSelected;

    if (selectedStudentIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No hay estudiantes seleccionados.")),
      );
      return;
    }

    // 2. Cargar estudiantes completos
    final List<Student> students = [];
    for (final id in selectedStudentIds) {
      final student = await studentVM.getStudentById(id.toString());
      if (student != null) {
        students.add(student);
      }
    }

    if (students.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo cargar la información de los estudiantes.")),
      );
      return;
    }

    // 3. Función openForm para el ViewModel (un popup por estudiante)
    Future<Reputation?> openForm(Student student) async {
      // obtener nombre del user asociado
      final user = await userVM.getUserById(student.userId.toString());
      final String studentName = user?.name ?? "Estudiante";

      return await showDialog<Reputation?>(
        context: context,
        barrierDismissible: false, // obligatorio calificar
        builder: (_) => ReputationFormPopup(
          student: student,
          project: project,
          studentName: studentName,
        ),
      );
    }

    // 4. Crear reputaciones + actualizar rating + endedProjects
    await reputationVM.createReputationsForProject(
      project: project,
      students: students,
      openForm: openForm,
    );

    // 5. Actualizar estado del proyecto a "finalizado"
    final updatedProject = project.copyWith(status: "finalizado");
    await projectVM.updateProject(updatedProject);

    // 6. Navegar a MyProjects
    if (!mounted) return;
    Navigator.pushNamed(context, AppRoutes.myProjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          project.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Descripción:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              Text(project.description),
              const SizedBox(height: 16),

              if (project.requirements.isNotEmpty) ...[
                const Text(
                  'Requisitos:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 4),
                ...project.requirements.map((req) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 14)),
                    Expanded(child: Text(req)),
                  ],
                )),
                const SizedBox(height: 16),
              ],

              const Text(
                'Pago:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text('${project.budget} dólares'),
              const SizedBox(height: 16),

              const Text(
                'Estado:',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(project.status),
              const SizedBox(height: 32),

              if (project.status.toLowerCase() == "activo") ...[
                Center(
                  child: ElevatedButton(
                    onPressed: _finalizeProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C1F2B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Finalizar Proyecto",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _deleteProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C1F2B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Eliminar'),
                  ),
                  ElevatedButton(
                    onPressed: _goToEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD479),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Editar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
