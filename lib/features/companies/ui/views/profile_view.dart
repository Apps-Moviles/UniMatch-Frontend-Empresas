import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimatch_empresas/shared/ui/widgets/bottom_nav_bar.dart';
import '../../../../routes/app_routes.dart';
import '../../../companies/domain/model/company.dart';
import '../../../companies/ui/viewmodels/company_view_model.dart';
import '../../../users/ui/viewmodels/user_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);
    final companyVM = Provider.of<CompanyViewModel>(context);

    final user = userVM.currentUser;
    final userIdInt = user?.id;

    final company = companyVM.companies.firstWhere(
          (c) => c.userId == userIdInt,
      orElse: () => Company(
        id: 0,
        userId: 0,
        companyName: 'Empresa no encontrada',
        sector: '',
        location: '',
        email: '',
        phone: '',
        rating: 0.0,
        profilePicture: '',
        description: '',
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        leading: const SizedBox(),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Mi Empresa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Imagen del logo
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                company.profilePicture.isNotEmpty
                    ? company.profilePicture
                    : 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              ),
            ),
            const SizedBox(height: 12),

            // Nombre de la empresa
            Text(
              company.companyName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Calificación
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(
                  company.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Datos
            infoItem('Encargado', '${user?.name ?? 'Desconocido'}'),
            infoItem('Ciudad/País', company.location),
            infoItem('Enfoque', company.sector),
            infoItem('Email', '${user?.email ?? ''}'),
            infoItem('Celular', company.phone),
            const SizedBox(height: 24),

            // Botón modificar perfil
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.editProfile);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD479),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Modificar perfil'),
            ),
            const SizedBox(height: 12),

            // Botón cerrar sesión
            ElevatedButton(
              onPressed: () {
                userVM.logout();
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.landing, (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C1F2B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
