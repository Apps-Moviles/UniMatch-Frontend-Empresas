import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimatch_empresas/features/users/ui/viewmodels/user_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyNameController = TextEditingController();
  final sectorController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 32),
                Image.asset('assets/logo_unimatch_claro.png', height: 100),
                const SizedBox(height: 16),
                _buildTextField(nameController, 'Nombre'),
                _buildTextField(emailController, 'Email'),
                _buildTextField(passwordController, 'Contraseña', obscure: true),
                _buildTextField(companyNameController, 'Nombre de la compañía'),
                Row(
                  children: [
                    Expanded(child: _buildTextField(sectorController, 'Sector')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField(locationController, 'Ubicación')),
                  ],
                ),
                _buildTextField(phoneController, 'Número de celular'),
                const SizedBox(height: 16),
                if (errorMessage != null)
                  Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                        errorMessage = null;
                      });

                      final success = await userViewModel.registerCompanyWithUser(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        companyName: companyNameController.text.trim(),
                        sector: sectorController.text.trim(),
                        location: locationController.text.trim(),
                        phone: phoneController.text.trim(),
                      );

                      if (success) {
                        if (mounted) {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      } else {
                        setState(() {
                          errorMessage = userViewModel.errorMessage;
                          isLoading = false;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD479),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Register', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: '¿Ya tienes una cuenta? ',
                      children: [
                        TextSpan(
                          text: 'Inicia Sesión',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }
}
