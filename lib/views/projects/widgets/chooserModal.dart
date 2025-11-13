import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/components/button.dart';
import 'package:unimatch_empresas/views/projects/components/card.dart';

class ChooserModalContent extends StatelessWidget {
  const ChooserModalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return UMCard(
      width: 350,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¿Estas Seguro?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UMButton(
                width: 130,
                height: 33,
                text: "Cancelar",
                onPressed: () {
                  Navigator.pop(context);
                },
                type: ButtonType.primary,
              ),
              UMButton(
                width: 130,
                height: 33,
                text: "Aceptar",
                onPressed: () {
                  Navigator.pop(context, true);
                },
                type: ButtonType.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
