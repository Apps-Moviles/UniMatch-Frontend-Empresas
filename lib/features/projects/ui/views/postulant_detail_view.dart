import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../students/domain/model/student.dart';
import '../../../projects/ui/viewmodels/project_view_model.dart';
import '../../../student_postulations/ui/viewmodels/student_postulation_view_model.dart';

class PostulantDetailView extends StatelessWidget {
  final Student student;
  final String userName;
  final String userEmail;
  final int projectId;

  const PostulantDetailView({
    super.key,
    required this.student,
    required this.userName,
    required this.userEmail,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    final projectVM = Provider.of<ProjectViewModel>(context, listen: false);
    final project = projectVM.projects.firstWhere((p) => p.id == projectId);

    final alreadyAccepted = project.studentsSelected.contains(student.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F0E6),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            // FOTO
            CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(
                student.profilePicture.isNotEmpty
                    ? student.profilePicture
                    : 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              ),
            ),
            const SizedBox(height: 16),

            // NOMBRE
            Text(
              userName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            // RATING
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 28),
                const SizedBox(width: 6),
                Text(
                  student.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // INFO DETALLADA
            _infoLine("Fecha de Nacimiento", student.birthdate),
            _infoLine("Ciudad/Pais", "${student.city}, ${student.country}"),
            _infoLine("Carrera", student.career),
            _infoLine("Email", userEmail),
            _infoLine("Celular", student.phoneNumber),

            const SizedBox(height: 30),

            // BOTÓN ACEPTAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: alreadyAccepted
                    ? null
                    : () async {
                  final postVM = Provider.of<StudentPostulationViewModel>(context, listen: false);

                  try {
                    // Paso 1: Aceptar la postulación
                    await postVM.acceptPostulation(student.id, projectId);

                    // Paso 2: Añadir studentId al studentsSelected del proyecto
                    project.studentsSelected.add(student.id);
                    await projectVM.updateProject(project);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Postulante aceptado correctamente")),
                      );
                      Navigator.pop(context); // volver a la vista anterior
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al aceptar: $e")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: alreadyAccepted ? Colors.grey : const Color(0xFFFFD479),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(alreadyAccepted ? "Ya aceptado" : "Aceptar"),
              ),
            ),

            const SizedBox(height: 12),

            // BOTÓN VER RESEÑAS (a implementar luego)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Ver Reseñas"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
