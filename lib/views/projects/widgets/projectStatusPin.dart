import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/domain/project.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';

String fromStatusToString(ProjectStatusEnum status) {
  switch (status) {
    case ProjectStatusEnum.inProgress:
      return "En progreso";
    case ProjectStatusEnum.acepted:
      return "Acpetado";
    case ProjectStatusEnum.rejected:
      return "Rechazado";
  }
}

Color fromStatusToBackgroundColor(ProjectStatusEnum status) {
  switch (status) {
    case ProjectStatusEnum.inProgress:
      return flagPrimaryColor;
    case ProjectStatusEnum.acepted:
      return flagPrimaryColor;
    case ProjectStatusEnum.rejected:
      return flagPrimaryColor;
  }
}

class ProjectStatusPin extends StatelessWidget {
  final ProjectStatusEnum status;

  const ProjectStatusPin({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        color: fromStatusToBackgroundColor(status),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          fromStatusToString(status),
          style: const TextStyle(color: textContrastColor, fontSize: 12,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
