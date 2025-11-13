import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/nav_view.dart';
import 'package:unimatch_empresas/views/projects/components/button.dart';
import 'package:unimatch_empresas/views/projects/components/modal.dart';
import 'package:unimatch_empresas/views/projects/domain/project.dart';
import 'package:unimatch_empresas/views/projects/project_edit_view.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';
import 'package:unimatch_empresas/views/projects/widgets/chooserModal.dart';
import 'package:unimatch_empresas/views/projects/widgets/eliminatedProjectModal.dart';

class ProjectDetailsView extends StatelessWidget {
  final Project project;

  const ProjectDetailsView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textPrimaryColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBar: NavView(currentIndex: 0),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////////////////////////////////////////////////////////////////////////
              ////////////////////////////////////////////////////////////////////////////////////
              Text(
                "Descripción:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              Text(
                project.description,
                style: TextStyle(fontSize: 14, color: textSecondaryColor),
              ),

              ////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 10),

              ////////////////////////////////////////////////////////////////////////////////////
              Text(
                "Requerimientos:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                project.requirements,
                style: TextStyle(fontSize: 14, color: textSecondaryColor),
              ),

              ////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 10),

              ////////////////////////////////////////////////////////////////////////////////////
              Text(
                "Duración:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              Text(
                project.duration,
                style: TextStyle(fontSize: 14, color: textSecondaryColor),
              ),

              ////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 10),

              ////////////////////////////////////////////////////////////////////////////////////
              Text(
                "Pago:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
              ),
              Text(
                project.payment,
                style: TextStyle(fontSize: 14, color: textSecondaryColor),
              ),

              ////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 35),

              ////////////////////////////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UMButton(
                    width: 130,
                    height: 33,
                    text: "Eliminar",
                    onPressed: () async {
                      bool isOk =
                          await UMModal.show(
                            context,
                            const ChooserModalContent(),
                          ) ??
                          false;
                      if (!isOk) return;

                      await UMModal.show(
                        context,
                        const EliminatedProjectModalContent(),
                      );

                      Navigator.pop(context);
                    },
                    type: ButtonType.primary,
                  ),
                  SizedBox(width: 100),
                  UMButton(
                    width: 130,
                    height: 33,
                    text: "Editar",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProjectEditView(project: project),
                        ),
                      );
                    },
                    type: ButtonType.secondary,
                  ),
                ],
              ),

              ////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 10),

              ////////////////////////////////////////////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
