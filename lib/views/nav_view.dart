import 'package:flutter/material.dart';

class NavView extends StatelessWidget {
  final int currentIndex;
  const NavView({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1B1E2C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),

      padding: const EdgeInsets.only(top: 10),

      child: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Color(0xFFF6C66E),
        unselectedItemColor: Colors.white70,

        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, "/calls");
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, "/company");
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
    );
  }
}
