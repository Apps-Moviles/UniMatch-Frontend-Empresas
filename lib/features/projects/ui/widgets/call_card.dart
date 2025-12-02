import 'package:flutter/material.dart';
import '../../domain/model/project.dart';

class CallCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap; // 👈 Callback para navegación

  const CallCard({
    super.key,
    required this.project,
    this.onTap,
  });

  String getRelativeTime(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays >= 1) {
      return 'Hace ${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours >= 1) {
      return 'Hace ${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
    } else {
      return 'Hace ${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 👈 Ahora sí es clickeable
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TÍTULO
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            /// INFO: POSTULANTES + TIEMPO
            Row(
              children: [
                /// BADGE: CANTIDAD DE POSTULANTES
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE0A3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${project.postulants.length} postulantes',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFF3B3B3B),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// FECHA RELATIVA
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      getRelativeTime(DateTime.parse(project.createdAt)),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
