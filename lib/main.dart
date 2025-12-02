import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimatch_empresas/features/users/ui/viewmodels/user_view_model.dart';
import 'package:unimatch_empresas/routes/app_navigation/app_navigation.dart';

import 'features/companies/ui/viewmodels/company_view_model.dart';
import 'features/projects/ui/viewmodels/project_view_model.dart';
import 'features/students/ui/viewmodels/student_view_model.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CompanyViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
        ChangeNotifierProvider(create: (_) => StudentViewModel()),
      ],
      child: const AppNavigation(),
    ),
  );
}
