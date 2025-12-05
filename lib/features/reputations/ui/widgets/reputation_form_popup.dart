import 'package:flutter/material.dart';
import '../../../students/domain/model/student.dart';
import '../../../projects/domain/model/project.dart';
import '../../domain/model/reputation.dart';

class ReputationFormPopup extends StatefulWidget {
  final Student student;
  final Project project;
  final String studentName; // ← añadido

  const ReputationFormPopup({
    super.key,
    required this.student,
    required this.project,
    required this.studentName,
  });

  @override
  State<ReputationFormPopup> createState() => _ReputationFormPopupState();
}

class _ReputationFormPopupState extends State<ReputationFormPopup> {
  double rating = 0.0;
  final TextEditingController commentController = TextEditingController();
  String? errorMessage;

  void _save() {
    final comment = commentController.text.trim();

    if (rating < 0 || rating > 5) {
      setState(() => errorMessage = "La calificación debe estar entre 0 y 5.");
      return;
    }

    if (comment.isEmpty) {
      setState(() => errorMessage = "Debe escribir un comentario.");
      return;
    }

    final rep = Reputation(
      id: null,
      studentId: widget.student.id!,
      projectId: widget.project.id!,
      rating: rating,
      comment: comment,
      type: 1,
    );

    Navigator.pop(context, rep);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Calificar a ${widget.studentName}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calificación actual del estudiante: ${widget.student.rating}",
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 16),

            const Text(
              "Nueva Puntuación (0 - 5)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Ej: 4.5",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (val) {
                rating = double.tryParse(val) ?? 0;
              },
            ),

            const SizedBox(height: 16),

            const Text(
              "Comentario",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: commentController,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Describe tu evaluación",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            if (errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              )
            ]
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text("Cancelar", style: TextStyle(color: Colors.black54)),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
