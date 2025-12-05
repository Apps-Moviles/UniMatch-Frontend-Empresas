import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/components/card.dart';
import 'package:unimatch_empresas/views/projects/domain/project.dart';
import 'package:unimatch_empresas/views/projects/project_details_view.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';
import 'package:unimatch_empresas/views/projects/widgets/projectStatusPin.dart';

class ProjectView extends StatelessWidget {
  final Project project;

  const ProjectView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return UMCard(
      width: 350,
      height: 100,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailsView(project: project),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: TextStyle(
                  color: textPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Creado el ${project.createdAt}",
                style: TextStyle(
                  color: textSecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          ProjectStatusPin(status: ProjectStatusEnum.inProgress),
        ],
      ),
    );
  }
}
