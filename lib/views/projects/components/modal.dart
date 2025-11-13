import 'package:flutter/material.dart';

class UMModal extends StatefulWidget {
  final BuildContext context;
  final Widget child;

  const UMModal({super.key, required this.context, required this.child});

  @override
  State<UMModal> createState() => _MyWidgetState();

  // ignore: unused_element
  static Future<dynamic> show(BuildContext context, Widget child) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [UMModal(context: context, child: child)],
        ),
      ),
    );
  }
}

class _MyWidgetState extends State<UMModal> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
