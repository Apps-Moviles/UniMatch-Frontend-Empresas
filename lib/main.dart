import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimatch_empresas/features/users/ui/viewmodels/user_view_model.dart';
import 'package:unimatch_empresas/routes/app_navigation/app_navigation.dart';

import 'features/companies/ui/viewmodels/company_view_model.dart';
import 'features/projects/ui/viewmodels/project_view_model.dart';
import 'features/reputations/data/api/reputation_api.dart';
import 'features/reputations/data/repository/reputation_repository_impl.dart';
import 'features/reputations/ui/viewmodels/reputation_view_model.dart';
import 'features/student_postulations/data/api/student_postulation_api.dart';
import 'features/student_postulations/data/repositories/student_postulation_repository_impl.dart';
import 'features/student_postulations/ui/viewmodels/student_postulation_view_model.dart';
import 'features/students/data/api/student_api.dart';
import 'features/students/data/repository/student_repository_impl.dart';
import 'features/students/ui/viewmodels/student_view_model.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CompanyViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectViewModel()),
        ChangeNotifierProvider(create: (_) => StudentViewModel()),

        ChangeNotifierProvider(
          create: (_) => StudentPostulationViewModel(
            StudentPostulationRepositoryImpl(
              StudentPostulationApi(),
            ),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => ReputationViewModel(
            ReputationRepositoryImpl(ReputationApi()),
            StudentRepositoryImpl(StudentApi()),
          ),
        ),
      ],
      child: const AppNavigation(),
    ),
  );
}
