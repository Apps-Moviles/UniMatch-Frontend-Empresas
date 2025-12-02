import 'package:flutter/material.dart';
import '../../../students/domain/model/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final String studentName;

  const StudentCard({super.key, required this.student, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Imagen del estudiante
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(student.profilePicture.isNotEmpty
                ? student.profilePicture
                : 'https://i.ibb.co/TgFvYzX/default-profile.png'),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  student.career,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(student.rating.toStringAsFixed(1)),
                  ],
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    // Acción "Ver más"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD479),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Ver más"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
