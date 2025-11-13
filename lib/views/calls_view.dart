import 'package:flutter/material.dart';
import '../models/call.dart';
import 'nav_view.dart';

class CallsView extends StatefulWidget {
  const CallsView({super.key});

  @override
  State<CallsView> createState() => _CallsViewState();
}

class _CallsViewState extends State<CallsView> {
  // Datos de ejemplo - reemplazar con llamadas a API
  final List<Call> calls = [
    Call(
      id: '1',
      title: 'Desarrollador Flutter Junior',
      applicantsCount: 15,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Buscamos desarrollador Flutter con experiencia',
    ),
    Call(
      id: '2',
      title: 'Diseñador UI/UX',
      applicantsCount: 8,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      description: 'Diseñador con experiencia en aplicaciones móviles',
    ),
    Call(
      id: '3',
      title: 'Backend Developer',
      applicantsCount: 23,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      description: 'Desarrollador backend con Node.js',
    ),
    Call(
      id: '4',
      title: 'QA Automation',
      applicantsCount: 10,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      description: 'Ingeniero de pruebas automatizadas',
    ),
    Call(
      id: '5',
      title: 'DevOps Engineer',
      applicantsCount: 12,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      description: 'Experiencia en CI/CD y Kubernetes',
    ),
    Call(
      id: '6',
      title: 'Data Analyst',
      applicantsCount: 5,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      description: 'Analista de datos con SQL y Python',
    ),
    Call(
      id: '7',
      title: 'Project Manager',
      applicantsCount: 18,
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
      description: 'Gestor de proyectos con metodologías ágiles',
    ),
    Call(
      id: '8',
      title: 'Mobile QA',
      applicantsCount: 7,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      description: 'Pruebas en dispositivos iOS y Android',
    ),
    Call(
      id: '9',
      title: 'Fullstack Developer',
      applicantsCount: 30,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Experiencia en React y Node.js',
    ),
    Call(
      id: '10',
      title: 'Product Designer',
      applicantsCount: 9,
      createdAt: DateTime.now().subtract(const Duration(days: 11)),
      description: 'Diseño de productos digitales',
    ),
    Call(
      id: '11',
      title: 'AI/ML Engineer',
      applicantsCount: 14,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      description: 'Modelos de aprendizaje automático',
    ),
    Call(
      id: '12',
      title: 'Soporte Técnico',
      applicantsCount: 6,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      description: 'Atención y soporte a usuarios',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convocatorias'),
        backgroundColor: const Color(0xFFF6C66E),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFFF5EDDD),
      body: calls.isEmpty
          ? const Center(
        child: Text(
          'No hay convocatorias publicadas',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: calls.length,
        itemBuilder: (context, index) {
          return CallCard(
            call: calls[index],
            onTap: () {
              // Navegar a detalle de convocatoria
              Navigator.pushNamed(
                context,
                '/call-detail',
                arguments: calls[index],
              );
            },
          );
        },
      ),
      bottomNavigationBar: const NavView(currentIndex: 1),
    );
  }
}

// Widget CallCard
class CallCard extends StatelessWidget {
  final Call call;
  final VoidCallback? onTap;

  const CallCard({
    super.key,
    required this.call,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                call.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6C66E).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${call.applicantsCount} postulantes',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B6F47),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    call.getDaysAgo(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

