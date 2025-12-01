// lib/routes/app_navigation/app_navigation.dart

import 'package:flutter/material.dart';
import 'package:unimatch_empresas/routes/app_routes.dart';
import 'package:unimatch_empresas/features/users/ui/views/login_view.dart';
import 'package:unimatch_empresas/features/companies/ui/views/company_dashboard_view.dart';

import '../../features/users/ui/views/landing_view.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.landing,
      routes: {
        AppRoutes.landing: (context) => const LandingView(),
        AppRoutes.login: (context) => const LoginView(),
        AppRoutes.companyDashboard: (context) => const CompanyDashboardView(),
      },

      // Luego podemos configurar theme global aquí
    );
  }
}
