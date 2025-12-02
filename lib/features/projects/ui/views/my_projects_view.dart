import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'package:unimatch_empresas/shared/ui/widgets/bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';
import '../../../companies/ui/viewmodels/company_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';
import '../../domain/model/project.dart';
import '../viewmodels/project_view_model.dart';
import '../widgets/project_card.dart';

class MyProjectsView extends StatefulWidget {
  const MyProjectsView({super.key});

  @override
  State<MyProjectsView> createState() => _MyProjectsViewState();
}

class _MyProjectsViewState extends State<MyProjectsView> {
  bool _isLoading = true;
  bool _isInitialized = false;
  List<Project> _userProjects = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// Se ejecuta al volver desde otra pantalla
    if (!_isInitialized) {
      _isInitialized = true;
      _loadData();
    } else {
      _loadData(); // 🔥 Recarga cuando regresas
    }
  }

  Future<void> _loadData() async {
    final companyVM = Provider.of<CompanyViewModel>(context, listen: false);
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);
    final userVM = Provider.of<UserViewModel>(context, listen: false);

    setState(() => _isLoading = true);

    await companyVM.loadCompanies();
    await projectVM.loadProjects();

    final userId = userVM.currentUser?.id;
    final company = companyVM.companies.firstWhereOrNull(
          (c) => c.userId == userId,
    );

    if (company != null) {
      setState(() {
        _userProjects = projectVM.projects
            .where((p) => p.companyId == company.id)
            .toList();
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text(
          'Mis Proyectos',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.createProject);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD479),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Nuevo Proyecto'),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _userProjects.isEmpty
                ? const Center(child: Text("No hay proyectos creados aún"))
                : ListView.builder(
              itemCount: _userProjects.length,
              itemBuilder: (context, index) {
                final project = _userProjects[index];
                return ProjectCard(
                  project: project,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.projectDetail,
                      arguments: project,
                    ).then((_) {
                      _loadData(); // 🔥 Refresca al regresar
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
