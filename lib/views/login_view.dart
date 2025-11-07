import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void validarLogin() {
    String user = emailController.text.trim();
    String pass = passwordController.text.trim();

    if (user == "admin" && pass == "admin") {
      Navigator.pushReplacementNamed(context, '/company');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario o contraseña incorrecta"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 120, color: Colors.black),
            const SizedBox(height: 20),
            const Text(
              "UNIMATCH",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            // Campo email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Ingrese email",
                labelStyle: const TextStyle(color: Colors.black54),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campo contraseña
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Ingrese Contraseña",
                labelStyle: TextStyle(color: Colors.black54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Botón Login
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF6C66E),
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: validarLogin,
              child: const Text("Login", style: TextStyle(color: Colors.black)),
            ),

            const SizedBox(height: 20),
            const Text(
              "No tienes una cuenta?  Registrate",
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
