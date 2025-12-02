import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';
import '../../../../shared/ui/widgets/bottom_nav_bar.dart';
import '../../../companies/ui/viewmodels/company_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';
import '../../domain/model/project.dart';
import '../viewmodels/project_view_model.dart';

class CreateProjectView extends StatefulWidget {
  const CreateProjectView({super.key});

  @override
  State<CreateProjectView> createState() => _CreateProjectViewState();
}

class _CreateProjectViewState extends State<CreateProjectView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _requirementController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();

  List<String> _requirements = [];

  void _addRequirement() {
    final text = _requirementController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _requirements.add(text);
        _requirementController.clear();
      });
    }
  }

  void _createProject() async {
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);
    final companyVM = Provider.of<CompanyViewModel>(context, listen: false);
    final userVM = Provider.of<UserViewModel>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      await companyVM.loadCompanies();

      final userId = userVM.currentUser?.id?.toString();

      final company = companyVM.companies.firstWhere(
            (c) => c.userId.toString() == userId,
        orElse: () => throw Exception("No se encontró empresa asociada al usuario"),
      );

      projectVM.createProject(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        companyId: company.id!,
        field: _fieldController.text.trim(),
        budget: double.tryParse(_budgetController.text) ?? 0,
        requirements: _requirements,
      );

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
        centerTitle: false,
        title: const Text(
          'Nuevo Proyecto',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // 👈 SE AGREGÓ AQUÍ
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
                    onPressed: _createProject,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD479),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Crear'),
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
      decoration: _inputDecoration(hint: hint),
      validator: (value) {
        if (isRequirement) {
          if (value!.isEmpty && _requirements.isEmpty) {
            return 'Debe ingresar al menos un requisito';
          }
        } else {
          if (value!.isEmpty) return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
