class Student {
  final int id;
  final int userId;
  final String birthdate;
  final String city;
  final String country;
  final String career;
  final String phoneNumber;
  final String portfolioLink;
  final String aboutMe;
  final double rating;
  final String profilePicture;
  final List<int> endedProjects;

  Student({
    required this.id,
    required this.userId,
    required this.birthdate,
    required this.city,
    required this.country,
    required this.career,
    required this.phoneNumber,
    required this.portfolioLink,
    required this.aboutMe,
    required this.rating,
    required this.profilePicture,
    required this.endedProjects,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: int.parse(json['id'].toString()),
      userId: json['userId'],
      birthdate: json['birthdate'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      career: json['career'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      portfolioLink: json['portfolioLink'] ?? '',
      aboutMe: json['aboutMe'] ?? '',
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : (json['rating'] as num).toDouble(),
      profilePicture: json['profilePicture'] ?? '',
      endedProjects: (json['endedProjects'] as List<dynamic>? ?? [])
          .map((e) => int.tryParse(e.toString()) ?? 0)
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'birthdate': birthdate,
      'city': city,
      'country': country,
      'career': career,
      'phoneNumber': phoneNumber,
      'portfolioLink': portfolioLink,
      'aboutMe': aboutMe,
      'rating': rating,
      'profilePicture': profilePicture,
      'endedProjects': endedProjects,
    };
  }
}
