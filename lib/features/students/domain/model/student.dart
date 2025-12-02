class Student {
  final String id;
  final String userId;
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
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      birthdate: json['birthdate'],
      city: json['city'],
      country: json['country'],
      career: json['career'],
      phoneNumber: json['phoneNumber'],
      portfolioLink: json['portfolioLink'],
      aboutMe: json['aboutMe'],
      rating: (json['rating'] as num).toDouble(),
      profilePicture: json['profilePicture'],
      endedProjects: List<int>.from(json['endedProjects']),
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
