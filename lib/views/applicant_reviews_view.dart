import 'package:flutter/material.dart';
import '../models/applicant.dart';

class ApplicantReviewsView extends StatelessWidget {
  const ApplicantReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final applicant = ModalRoute.of(context)!.settings.arguments as Applicant;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDDD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6C66E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Reseñas'),
      ),
      body: Column(
        children: [
          // Header con información del postulante
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.white,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFFF6C66E),
                  backgroundImage: applicant.imageUrl.isNotEmpty
                      ? NetworkImage(applicant.imageUrl)
                      : null,
                  child: applicant.imageUrl.isEmpty
                      ? Text(
                          applicant.name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 12),
                Text(
                  applicant.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Lista de reseñas
          Expanded(
            child: applicant.reviews.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text(
                        'Este postulante aún no tiene reseñas',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: applicant.reviews.length,
                    itemBuilder: (context, index) {
                      final review = applicant.reviews[index];
                      return ReviewCard(review: review);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    super.key,
    required this.review,
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
          // Nombre del proyecto
          Text(
            review.projectName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Nombre de la empresa
          Text(
            review.companyName,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          // Comentario
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          // Calificación
          Row(
            children: [
              const Text(
                'Calificación: ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ...List.generate(5, (index) {
                return Icon(
                  index < review.rating.floor()
                      ? Icons.star
                      : (index < review.rating && review.rating % 1 != 0)
                          ? Icons.star_half
                          : Icons.star_border,
                  color: const Color(0xFFF6C66E),
                  size: 20,
                );
              }),
              const SizedBox(width: 4),
              Text(
                review.rating.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

