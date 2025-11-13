import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/company_info.dart';
import 'package:unimatch_empresas/views/projects/projects_view.dart';
import 'views/landing_view.dart';
import 'views/login_view.dart';
import 'views/company_view.dart';
import 'views/calls_view.dart';
import 'views/call_detail_view.dart';
import 'views/applicant_profile_view.dart';
import 'views/applicant_reviews_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingScreen(),
        '/login': (context) => const LoginView(),
        '/company': (context) => const CompanyView(),
        '/edit-company': (context) => const CompanyInfo(),
        '/calls': (context) => const CallsView(),
        '/projects': (context) => const ProjectsView(),
        '/call-detail': (context) => const CallDetailView(),
        '/applicant-profile': (context) => const ApplicantProfileView(),
        '/applicant-reviews': (context) => const ApplicantReviewsView(),
      },
    );
  }
}
