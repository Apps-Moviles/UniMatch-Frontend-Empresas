import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/nav_view.dart';
import 'package:unimatch_empresas/views/projects/components/button.dart';
import 'package:unimatch_empresas/views/projects/components/modal.dart';
import 'package:unimatch_empresas/views/projects/domain/project.dart';
import 'package:unimatch_empresas/views/projects/mocks/projects.mock.dart';
import 'package:unimatch_empresas/views/projects/project_create_view.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';
import 'package:unimatch_empresas/views/projects/widgets/chooserModal.dart';
import 'package:unimatch_empresas/views/projects/widgets/projectView.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProjectsView> {
  final List<Project> projects = mockedProjects;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Mis Projectos'),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: textPrimaryColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBar: NavView(currentIndex: 0),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: UMButton(
                width: 180,
                height: 40,
                text: "Nuevo Projecto",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectCreateView(),
                    ),
                  );
                },
                type: ButtonType.secondary,
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 30);
                },
                controller: scrollController,
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectView(project: projects[index]);
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
