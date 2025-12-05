import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';

enum ButtonType { primary, secondary }

class UMButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;

  const UMButton({
    super.key,
    this.width = 200,
    this.height = 30,
    this.type = ButtonType.primary,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: type == ButtonType.primary
              ? buttonPrimaryColor
              : buttonSecondaryColor,
          padding: const EdgeInsets.all(0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: type == ButtonType.primary
                ? textContrastColor
                : textSecondaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
