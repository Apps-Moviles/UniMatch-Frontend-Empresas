class Project {
  final int id;
  final String title;
  final String description;
  final int companyId;
  final List<int> studentsSelected;
  final bool isFinished;
  final List<int> postulants;
  final String field;
  final double budget;
  final String createdAt;
  final List<String> requirements;
  final String status;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.companyId,
    this.studentsSelected = const [],
    this.isFinished = false,
    this.postulants = const [],
    required this.field,
    required this.budget,
    required this.createdAt,
    this.requirements = const [],
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: int.parse(json['id']),
      title: json['title'],
      description: json['description'],
      companyId: json['companyId'],
      studentsSelected: List<int>.from(json['studentsSelected'] ?? []),
      isFinished: json['isFinished'] ?? false,
      postulants: List<int>.from(json['postulants'] ?? []),
      field: json['field'],
      budget: (json['budget'] as num).toDouble(),
      createdAt: json['createdAt'],
      requirements: List<String>.from(json['requirements'] ?? []),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'title': title,
      'description': description,
      'companyId': companyId,
      'studentsSelected': studentsSelected,
      'isFinished': isFinished,
      'postulants': postulants,
      'field': field,
      'budget': budget,
      'createdAt': createdAt,
      'requirements': requirements,
      'status': status,
    };
  }

  Project copyWith({
    int? id,
    String? title,
    String? description,
    int? companyId,
    List<int>? studentsSelected,
    bool? isFinished,
    List<int>? postulants,
    String? field,
    double? budget,
    String? createdAt,
    List<String>? requirements,
    String? status,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      companyId: companyId ?? this.companyId,
      studentsSelected: studentsSelected ?? this.studentsSelected,
      isFinished: isFinished ?? this.isFinished,
      postulants: postulants ?? this.postulants,
      field: field ?? this.field,
      budget: budget ?? this.budget,
      createdAt: createdAt ?? this.createdAt,
      requirements: requirements ?? this.requirements,
      status: status ?? this.status,
    );
  }

}
