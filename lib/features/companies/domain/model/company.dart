class Company {
  final int? id;
  final int? userId;
  final String companyName;
  final String sector;
  final String location;
  final String email;
  final String phone;
  final double rating;
  final String profilePicture;
  final String description;

  const Company({
    this.id,
    this.userId,
    required this.companyName,
    required this.sector,
    required this.location,
    required this.email,
    required this.phone,
    this.rating = 0.0,
    this.profilePicture = '',
    this.description = '',
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: int.tryParse(json['id'].toString()),
      userId: int.tryParse(json['userId'].toString()),
      companyName: json['companyName'] ?? '',
      sector: json['sector'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      profilePicture: json['profilePicture'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      if (userId != null) 'userId': userId,
      'companyName': companyName,
      'sector': sector,
      'location': location,
      'email': email,
      'phone': phone,
      'rating': rating,
      'profilePicture': profilePicture,
      'description': description,
    };
  }

  Company copyWith({
    int? id,
    int? userId,
    String? companyName,
    String? sector,
    String? location,
    String? email,
    String? phone,
    double? rating,
    String? profilePicture,
    String? description,
  }) {
    return Company(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      sector: sector ?? this.sector,
      location: location ?? this.location,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      rating: rating ?? this.rating,
      profilePicture: profilePicture ?? this.profilePicture,
      description: description ?? this.description,
    );
  }
}
