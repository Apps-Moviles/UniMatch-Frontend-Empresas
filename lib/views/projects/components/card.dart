import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/styles/colors.dart';

class UMCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final EdgeInsets padding;

  const UMCard({
    super.key,
    required this.child,
    this.onPressed,
    this.width = 300,
    this.height = 300,
    this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 20),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: onPressed != null
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: cardBackgroundColor,
                side: BorderSide(color: cardShadowColor, width: 2),
                shadowColor: cardShadowColor,
              ),
              child: Padding(padding: padding, child: child),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cardShadowColor, width: 2),
              ),
              child: Padding(padding: padding, child: child),
            ),
    );
  }
}
