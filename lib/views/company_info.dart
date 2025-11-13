import 'package:flutter/material.dart';

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la Empresa'),
        backgroundColor: const Color(0xFFF6C66E),
      ),
      backgroundColor: const Color(0xFFF5EDDD),
      body: const Center(
        child: Text('Formulario de modificación de perfil'),
      ),
    );
  }
}
