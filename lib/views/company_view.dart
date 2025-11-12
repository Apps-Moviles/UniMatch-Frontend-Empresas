import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/company_info.dart';
import 'nav_view.dart';

class CompanyView extends StatelessWidget {
  const CompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EDDD),
      bottomNavigationBar: const NavView(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mi Empresa",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Imagen circular
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/.png"),
            ),
            const SizedBox(height: 15),

            const Text(
              "Mi empresa",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // Estrellas y rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 22),
                SizedBox(width: 4),
                Text("4.9", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 20),

            // Info
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Encargado: ", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 4),
                  Text("Ciudad/País: Lima, Perú", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 4),
                  Text("Enfoque: ", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 4),
                  Text(
                    "Email: ",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 4),
                  Text("Celular: ", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Botón Modificar Perfil
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF6C66E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(180, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompanyInfo()),
                );
              },
              child: const Text("Modificar perfil", style: TextStyle(color: Colors.black)),
            ),

            const SizedBox(height: 20),

            // Cerrar sesión
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(180, 40),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: const Text("Cerrar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
