import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/nav_view.dart';
import 'package:unimatch_empresas/views/projects/components/button.dart';
import 'package:unimatch_empresas/views/projects/components/card.dart';
import 'package:unimatch_empresas/views/projects/components/modal.dart';
import 'package:unimatch_empresas/views/projects/domain/project.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';
import 'package:unimatch_empresas/views/projects/widgets/savedProjectModal.dart';

class ProjectEditView extends StatefulWidget {
  final Project project;

  // form
  final TextEditingController titleInputController = TextEditingController();
  final TextEditingController descriptionInputController =
      TextEditingController();
  final TextEditingController requirementsInputController =
      TextEditingController();

  ProjectEditView({super.key, required this.project}) {
    titleInputController.text = project.title;
    requirementsInputController.text = project.requirements;
    descriptionInputController.text = project.description;
  }

  @override
  State<ProjectEditView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProjectEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Editar Projecto"),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: textPrimaryColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBar: NavView(currentIndex: 0),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ////////////////////////////////////////////////////////////////////////////////////
                  ////////////////////////////////////////////////////////////////////////////////////
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Titulo:",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      UMCard(
                        width: 350,
                        height: 40,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Center(
                          child: TextField(
                            style: const TextStyle(fontSize: 16),
                            controller: widget.titleInputController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  ////////////////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 10),

                  ////////////////////////////////////////////////////////////////////////////////////
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Descripción:",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      UMCard(
                        width: 350,
                        height: 150,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Center(
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 16,
                              color: textSecondaryColor,
                            ),
                            controller: widget.descriptionInputController,
                            textInputAction: TextInputAction.newline,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ////////////////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 10),

                  ////////////////////////////////////////////////////////////////////////////////////
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Requisitos:",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      UMCard(
                        width: 350,
                        height: 180,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 16,
                            color: textSecondaryColor,
                          ),
                          controller: widget.requirementsInputController,
                          textInputAction: TextInputAction.newline,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ////////////////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 20),

                  ////////////////////////////////////////////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UMButton(
                        width: 150,
                        text: "Cancelar",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 20),
                      UMButton(
                        width: 150,
                        text: "Guardar",
                        type: ButtonType.secondary,
                        onPressed: () async {
                          await UMModal.show(
                            context,
                            SavedProjectModalContent(),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
