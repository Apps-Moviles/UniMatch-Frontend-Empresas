import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/ui/widgets/bottom_nav_bar.dart';
import '../../../projects/ui/viewmodels/project_view_model.dart';
import '../../../companies/ui/viewmodels/company_view_model.dart';
import '../../../reputations/ui/viewmodels/reputation_view_model.dart';
import '../../../reputations/ui/widgets/reputation_card.dart';
import '../../../reputations/domain/model/reputation.dart';

class StudentReputationsView extends StatefulWidget {
  final int studentId;

  const StudentReputationsView({
    super.key,
    required this.studentId,
  });

  @override
  State<StudentReputationsView> createState() => _StudentReputationsViewState();
}

class _StudentReputationsViewState extends State<StudentReputationsView> {
  bool _isLoaded = false;

  Future<void> _loadData() async {
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);
    final companyVM = Provider.of<CompanyViewModel>(context, listen: false);
    final reputationVM = Provider.of<ReputationViewModel>(context, listen: false);

    await projectVM.loadProjects();
    await companyVM.loadCompanies();
    await reputationVM.loadAll();

    setState(() => _isLoaded = true);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadData);
  }

  @override
  Widget build(BuildContext context) {
    final projectVM = Provider.of<ProjectViewModel>(context);
    final companyVM = Provider.of<CompanyViewModel>(context);
    final reputationVM = Provider.of<ReputationViewModel>(context);

    if (!_isLoaded) {
      return const Scaffold(
        backgroundColor: Color(0xFFF5F0E6),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Filtrar reputaciones del estudiante
    final List<Reputation> reps = reputationVM.reputations
        .where((rep) => rep.studentId == widget.studentId && rep.type == 2)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Reseñas del Estudiante",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ⭐ AGREGADO: Bottom Navigation Bar
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),

      body: reps.isEmpty
          ? const Center(
        child: Text(
          "Este estudiante no tiene reseñas aún.",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reps.length,
        itemBuilder: (context, index) {
          final rep = reps[index];

          // buscar proyecto
          final project = projectVM.getProjectById(rep.projectId);
          final projectName = project?.title ?? "Proyecto desconocido";

          // buscar compañía
          final company =
          companyVM.getCompanyById(project?.companyId ?? 0);
          final companyName =
              company?.companyName ?? "Empresa desconocida";

          return ReputationCard(
            projectName: projectName,
            companyName: companyName,
            comment: rep.comment,
            rating: rep.rating,
          );
        },
      ),
    );
  }
}
