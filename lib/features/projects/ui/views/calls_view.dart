import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'package:unimatch_empresas/shared/ui/widgets/bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';
import '../../../companies/ui/viewmodels/company_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';
import '../../domain/model/project.dart';
import '../viewmodels/project_view_model.dart';
import '../widgets/call_card.dart';

class CallsView extends StatefulWidget {
  const CallsView({super.key});

  @override
  State<CallsView> createState() => _CallsViewState();
}

class _CallsViewState extends State<CallsView> {
  bool _isLoading = true;
  bool _isInitialized = false;
  List<Project> _callProjects = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _loadData();
    } else {
      _loadData();
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
        _callProjects = projectVM.projects.where((p) =>
        p.companyId == company.id &&
            p.status.toLowerCase() == "en revisión"
        ).toList();
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        title: const Text(
          'Convocatorias',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: _callProjects.isEmpty
            ? const Center(child: Text("No hay convocatorias activas"))
            : ListView.builder(
          itemCount: _callProjects.length,
          itemBuilder: (context, index) {
            final project = _callProjects[index];
            return CallCard(
              project: project,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.callDetail,
                  arguments: project,
                );
              },
            );
          },

        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }
}
