import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/components/button.dart';
import 'package:unimatch_empresas/views/projects/components/card.dart';

class CreatedProjectModalContent extends StatelessWidget {
  const CreatedProjectModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return UMCard(
      width: 350,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Proyecto creado",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          UMButton(
            width: 130,
            height: 33,
            text: "Aceptar",
            onPressed: () {
              Navigator.pop(context);
            },
            type: ButtonType.secondary,
          ),
        ],
      ),
    );
  }
}
