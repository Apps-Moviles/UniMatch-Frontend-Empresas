class Applicant {
  final String id;
  final String name;
  final String career;
  final double rating;
  final String email;
  final String phone;
  final String city;
  final String country;
  final DateTime birthDate;
  final String imageUrl;
  final List<Review> reviews;

  Applicant({
    required this.id,
    required this.name,
    required this.career,
    required this.rating,
    required this.email,
    required this.phone,
    required this.city,
    required this.country,
    required this.birthDate,
    required this.imageUrl,
    this.reviews = const [],
  });

  String get fullLocation => '$city, $country';

  String get formattedBirthDate {
    return '${birthDate.day.toString().padLeft(2, '0')}/${birthDate.month.toString().padLeft(2, '0')}/${birthDate.year}';
  }
}

class Review {
  final String id;
  final String projectName;
  final String companyName;
  final String comment;
  final double rating;
  final DateTime date;

  Review({
    required this.id,
    required this.projectName,
    required this.companyName,
    required this.comment,
    required this.rating,
    required this.date,
  });
}

