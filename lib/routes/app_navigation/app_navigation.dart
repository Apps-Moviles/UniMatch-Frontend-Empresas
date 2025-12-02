// lib/routes/app_navigation/app_navigation.dart

import 'package:flutter/material.dart';
import 'package:unimatch_empresas/routes/app_routes.dart';
import 'package:unimatch_empresas/features/users/ui/views/login_view.dart';
import 'package:unimatch_empresas/features/projects/ui/views/my_projects_view.dart';

import '../../features/companies/ui/views/edit_profile_view.dart';
import '../../features/projects/domain/model/project.dart';
import '../../features/projects/ui/views/call_detail_view.dart';
import '../../features/projects/ui/views/create_project_view.dart';
import '../../features/projects/ui/views/edit_project_view.dart';
import '../../features/projects/ui/views/postulant_detail_view.dart';
import '../../features/projects/ui/views/project_detail_view.dart';
import '../../features/users/ui/views/landing_view.dart';
import '../../features/users/ui/views/register_view.dart';

import 'package:unimatch_empresas/features/projects/ui/views/calls_view.dart';
import 'package:unimatch_empresas/features/companies/ui/views/profile_view.dart';

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
        AppRoutes.myProjects: (context) => const MyProjectsView(),
        AppRoutes.register: (context) => const RegisterView(),
        AppRoutes.calls: (context) => const CallsView(),
        AppRoutes.profile: (context) => const ProfileView(),
        AppRoutes.createProject: (context) => const CreateProjectView(),

        AppRoutes.projectDetail: (context) {
          final project = ModalRoute.of(context)!.settings.arguments as Project;
          return ProjectDetailView(project: project);
        },

        AppRoutes.editProject: (context) {
          final project = ModalRoute.of(context)!.settings.arguments as Project;
          return EditProjectView(project: project);
        },

        AppRoutes.callDetail: (context) {
          final project = ModalRoute.of(context)!.settings.arguments as Project;
          return CallDetailView(project: project);
        },

        AppRoutes.editProfile: (context) => const EditProfileView(),

        AppRoutes.postulantDetail: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return PostulantDetailView(
            student: args['student'],
            userName: args['userName'],
            userEmail: args['userEmail'],
            projectId: args['projectId'],
          );
        },


      },


    );
  }
}
