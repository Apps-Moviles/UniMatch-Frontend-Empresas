import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../shared/ui/widgets/bottom_nav_bar.dart';
import '../../domain/model/project.dart';
import '../viewmodels/project_view_model.dart';

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _deleteProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
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
