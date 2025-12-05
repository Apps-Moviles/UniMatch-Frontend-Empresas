import 'package:flutter/material.dart';
import '../models/call.dart';
import '../models/applicant.dart';

class CallDetailView extends StatefulWidget {
  const CallDetailView({super.key});

  @override
  State<CallDetailView> createState() => _CallDetailViewState();
}

class _CallDetailViewState extends State<CallDetailView> {
  String? selectedCareerFilter;
  double? selectedRatingFilter;

  // Datos de ejemplo - reemplazar con llamadas a API
  final List<Applicant> applicants = [
    Applicant(
      id: '1',
      name: 'María García López',
      career: 'Ingeniería de Sistemas',
      rating: 4.5,
      email: 'maria.garcia@email.com',
      phone: '+51 987654321',
      city: 'Lima',
      country: 'Perú',
      birthDate: DateTime(2000, 5, 15),
      imageUrl: '',
      reviews: [
        Review(
          id: '1',
          projectName: 'Sistema de Gestión Empresarial',
          companyName: 'Tech Solutions SAC',
          comment: 'Excelente trabajo, muy profesional y cumplió con todos los plazos establecidos.',
          rating: 5.0,
          date: DateTime.now().subtract(const Duration(days: 30)),
        ),
        Review(
          id: '2',
          projectName: 'App Móvil de Ventas',
          companyName: 'Digital Peru',
          comment: 'Buen desempeño en el desarrollo. Mostró iniciativa y creatividad.',
          rating: 4.0,
          date: DateTime.now().subtract(const Duration(days: 60)),
        ),
      ],
    ),
    Applicant(
      id: '2',
      name: 'Carlos Mendoza Ruiz',
      career: 'Ingeniería de Software',
      rating: 3.5,
      email: 'carlos.mendoza@email.com',
      phone: '+51 912345678',
      city: 'Arequipa',
      country: 'Perú',
      birthDate: DateTime(1999, 8, 22),
      imageUrl: '',
      reviews: [
        Review(
          id: '3',
          projectName: 'Portal Web Corporativo',
          companyName: 'Web Masters',
          comment: 'Cumplió con las expectativas del proyecto.',
          rating: 3.5,
          date: DateTime.now().subtract(const Duration(days: 45)),
        ),
      ],
    ),
    Applicant(
      id: '3',
      name: 'Ana Sofía Torres',
      career: 'Ciencias de la Computación',
      rating: 4.8,
      email: 'ana.torres@email.com',
      phone: '+51 998877665',
      city: 'Cusco',
      country: 'Perú',
      birthDate: DateTime(2001, 3, 10),
      imageUrl: '',
      reviews: [
        Review(
          id: '4',
          projectName: 'Sistema de Inventario',
          companyName: 'Innovatech',
          comment: 'Excepcional, superó nuestras expectativas. Muy recomendada.',
          rating: 5.0,
          date: DateTime.now().subtract(const Duration(days: 20)),
        ),
        Review(
          id: '5',
          projectName: 'Dashboard Analytics',
          companyName: 'Data Corp',
          comment: 'Excelente comunicación y habilidades técnicas sobresalientes.',
          rating: 4.5,
          date: DateTime.now().subtract(const Duration(days: 50)),
        ),
      ],
    ),
    Applicant(
      id: '4',
      name: 'Luis Alberto Pérez',
      career: 'Ingeniería de Sistemas',
      rating: 4.2,
      email: 'luis.perez@email.com',
      phone: '+51 955443322',
      city: 'Trujillo',
      country: 'Perú',
      birthDate: DateTime(1998, 11, 5),
      imageUrl: '',
      reviews: [],
    ),
    Applicant(
      id: '5',
      name: 'Patricia Flores Vega',
      career: 'Ingeniería de Software',
      rating: 3.8,
      email: 'patricia.flores@email.com',
      phone: '+51 977665544',
      city: 'Lima',
      country: 'Perú',
      birthDate: DateTime(2000, 7, 18),
      imageUrl: '',
      reviews: [
        Review(
          id: '6',
          projectName: 'E-commerce Platform',
          companyName: 'Shop Online',
          comment: 'Buen trabajo en general, cumplió con los requisitos.',
          rating: 4.0,
          date: DateTime.now().subtract(const Duration(days: 35)),
        ),
      ],
    ),
  ];

  List<String> get careers {
    return applicants.map((a) => a.career).toSet().toList();
  }

  List<Applicant> get filteredApplicants {
    return applicants.where((applicant) {
      bool matchesCareer = selectedCareerFilter == null ||
          applicant.career == selectedCareerFilter;
      bool matchesRating = selectedRatingFilter == null ||
          applicant.rating >= selectedRatingFilter!;
      return matchesCareer && matchesRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final call = ModalRoute.of(context)!.settings.arguments as Call;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDDD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6C66E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(call.title),
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrar postulantes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Carrera',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        initialValue: selectedCareerFilter,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Todas'),
                          ),
                          ...careers.map((career) => DropdownMenuItem(
                            value: career,
                            child: Text(career),
                          )),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCareerFilter = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<double>(
                        decoration: const InputDecoration(
                          labelText: 'Calificación mínima',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        initialValue: selectedRatingFilter,
                        items: const [
                          DropdownMenuItem(
                            value: null,
                            child: Text('Todas'),
                          ),
                          DropdownMenuItem(
                            value: 4.0,
                            child: Text('4.0+'),
                          ),
                          DropdownMenuItem(
                            value: 4.5,
                            child: Text('4.5+'),
                          ),
                          DropdownMenuItem(
                            value: 5.0,
                            child: Text('5.0'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedRatingFilter = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Lista de postulantes
          Expanded(
            child: filteredApplicants.isEmpty
                ? const Center(
                    child: Text(
                      'No hay postulantes con estos filtros',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredApplicants.length,
                    itemBuilder: (context, index) {
                      return ApplicantCard(
                        applicant: filteredApplicants[index],
                        onViewMore: () {
                          Navigator.pushNamed(
                            context,
                            '/applicant-profile',
                            arguments: {
                              'applicant': filteredApplicants[index],
                              'callId': call.id,
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ApplicantCard extends StatelessWidget {
  final Applicant applicant;
  final VoidCallback onViewMore;

  const ApplicantCard({
    super.key,
    required this.applicant,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            applicant.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            applicant.career,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFF6C66E),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                applicant.rating.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onViewMore,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF6C66E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ver más'),
            ),
          ),
        ],
      ),
    );
  }
}

