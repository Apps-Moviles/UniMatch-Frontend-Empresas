import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimatch_empresas/features/users/ui/viewmodels/user_view_model.dart';
import 'package:unimatch_empresas/routes/app_navigation/app_navigation.dart';

import 'features/companies/ui/viewmodels/company_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CompanyViewModel()),
      ],
      child: const AppNavigation(),
    ),
  );
}
