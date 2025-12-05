class Reputation {
  final int? id;
  final int studentId;
  final int projectId;
  final double rating;
  final String comment;
  final int type; // 1 = company → student, 2 = student → company

  const Reputation({
    this.id,
    required this.studentId,
    required this.projectId,
    required this.rating,
    required this.comment,
    required this.type,
  });

  factory Reputation.fromJson(Map<String, dynamic> json) {
    return Reputation(
      id: int.tryParse(json['id'].toString()),
      studentId: int.tryParse(json['studentId'].toString())!,
      projectId: int.tryParse(json['projectId'].toString())!,
      rating: double.tryParse(json['rating'].toString())!,
      comment: json['comment'] as String,
      type: int.tryParse(json['type'].toString())!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      'studentId': studentId,
      'projectId': projectId,
      'rating': rating,
      'comment': comment,
      'type': type,
    };
  }

  Reputation copyWith({
    int? id,
    int? studentId,
    int? projectId,
    double? rating,
    String? comment,
    int? type,
  }) {
    return Reputation(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      projectId: projectId ?? this.projectId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      type: type ?? this.type,
    );
  }


}
