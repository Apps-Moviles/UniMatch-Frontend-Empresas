import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';
import '../../../../shared/ui/widgets/bottom_nav_bar.dart';
import '../../../projects/domain/model/project.dart';
import '../../../projects/ui/viewmodels/project_view_model.dart';

class EditProjectView extends StatefulWidget {
  final Project project;

  const EditProjectView({super.key, required this.project});

  @override
  State<EditProjectView> createState() => _EditProjectViewState();
}

class _EditProjectViewState extends State<EditProjectView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _budgetController;
  late TextEditingController _fieldController;
  late TextEditingController _requirementController;

  List<String> _requirements = [];

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.project.title);
    _descriptionController = TextEditingController(text: widget.project.description);
    _budgetController =
        TextEditingController(text: widget.project.budget.toString());
    _fieldController = TextEditingController(text: widget.project.field);
    _requirementController = TextEditingController();

    _requirements = List<String>.from(widget.project.requirements);
  }

  void _addRequirement() {
    final text = _requirementController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _requirements.add(text);
        _requirementController.clear();
      });
    }
  }

  void _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);

    final updatedProject = widget.project.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      field: _fieldController.text.trim(),
      budget: double.tryParse(_budgetController.text) ?? 0.0,
      requirements: List<String>.from(_requirements),
    );

    await projectVM.updateProject(updatedProject);

    Navigator.pushNamed(context, AppRoutes.myProjects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Editar Proyecto',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildLabel('Título:'),
              _buildTextField(_titleController, 'Ingrese el título'),

              const SizedBox(height: 16),
              _buildLabel('Descripción:'),
              _buildTextField(_descriptionController, 'Ingrese la descripción', lines: 3),

              const SizedBox(height: 16),
              _buildLabel('Área o campo:'),
              _buildTextField(_fieldController, 'Ingrese el área o campo'),

              const SizedBox(height: 16),
              _buildLabel('Presupuesto (USD):'),
              _buildTextField(_budgetController, 'Ingrese el presupuesto', isNumber: true),

              const SizedBox(height: 16),
              _buildLabel('Requisitos:'),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(_requirementController, 'Agregar requisito', isRequirement: true),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addRequirement,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD479),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Añadir'),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: _requirements.map((req) {
                  return Chip(
                    label: Text(req),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        _requirements.remove(req);
                      });
                    },
                  );
                }).toList(),
              ),


              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C1F2B),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD479),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Guardar cambios'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) =>
      Text(text, style: const TextStyle(fontWeight: FontWeight.bold));

  Widget _buildTextField(TextEditingController controller, String hint,
      {int lines = 1, bool isNumber = false, bool isRequirement = false}) {
    return TextFormField(
      controller: controller,
      maxLines: lines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (isRequirement) {
          return null; // requisitos pueden estar vacíos
        }
        if (value!.isEmpty) return 'Este campo es obligatorio';
        return null;
      },
    );
  }
}
