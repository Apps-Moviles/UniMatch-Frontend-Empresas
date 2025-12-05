import 'package:flutter/material.dart';
import 'package:unimatch_empresas/routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (ModalRoute.of(context)?.settings.name != AppRoutes.myProjects) {
          Navigator.pushReplacementNamed(context, AppRoutes.myProjects);
        }
        break;
      case 1:
        if (ModalRoute.of(context)?.settings.name != AppRoutes.calls) {
          Navigator.pushReplacementNamed(context, AppRoutes.calls);
        }
        break;
      case 2:
        if (ModalRoute.of(context)?.settings.name != AppRoutes.profile) {
          Navigator.pushReplacementNamed(context, AppRoutes.profile);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      backgroundColor: const Color(0xFF1C1F2B),
      selectedItemColor: const Color(0xFFFFD479),
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
      ],
    );
  }
}
