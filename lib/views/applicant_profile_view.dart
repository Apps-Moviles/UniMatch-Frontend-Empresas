import 'package:flutter/material.dart';
import '../models/applicant.dart';

class ApplicantProfileView extends StatelessWidget {
  const ApplicantProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final applicant = args['applicant'] as Applicant;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDDD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6C66E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Perfil del Postulante'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Imagen de perfil
            CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xFFF6C66E),
              backgroundImage: applicant.imageUrl.isNotEmpty
                  ? NetworkImage(applicant.imageUrl)
                  : null,
              child: applicant.imageUrl.isEmpty
                  ? Text(
                      applicant.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            // Nombre
            Text(
              applicant.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Calificación
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFFF6C66E),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  applicant.rating.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Información del postulante
            _buildInfoRow(
              icon: Icons.cake,
              label: 'Fecha de nacimiento',
              value: applicant.formattedBirthDate,
            ),
            const SizedBox(height: 20),
            _buildInfoRow(
              icon: Icons.location_on,
              label: 'Ciudad (País)',
              value: applicant.fullLocation,
            ),
            const SizedBox(height: 20),
            _buildInfoRow(
              icon: Icons.school,
              label: 'Carrera',
              value: applicant.career,
            ),
            const SizedBox(height: 20),
            _buildInfoRow(
              icon: Icons.email,
              label: 'Email',
              value: applicant.email,
            ),
            const SizedBox(height: 20),
            _buildInfoRow(
              icon: Icons.phone,
              label: 'Celular',
              value: applicant.phone,
            ),
            const SizedBox(height: 32),
            // Botones
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/applicant-reviews',
                        arguments: applicant,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFF6C66E), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ver reseñas',
                      style: TextStyle(
                        color: Color(0xFFF6C66E),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showAcceptDialog(context, applicant.name);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF6C66E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFF6C66E),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showAcceptDialog(BuildContext context, String applicantName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Postulante aceptado',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Has aceptado a $applicantName para esta convocatoria.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar diálogo
                Navigator.of(context).pop(); // Volver a la lista de postulantes
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF6C66E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}

