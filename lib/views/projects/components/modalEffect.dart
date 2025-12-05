import 'package:flutter/material.dart';
import 'package:unimatch_empresas/views/projects/components/modal.dart';

void showModalDialog(BuildContext context, Widget child) {
  showDialog(
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
