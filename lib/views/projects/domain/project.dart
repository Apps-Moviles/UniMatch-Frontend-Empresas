enum ProjectStatusEnum { inProgress, acepted, rejected }

ProjectStatusEnum fromStringToProjectStatusEnum(String status) {
  switch (status) {
    case "inProgress":
      return ProjectStatusEnum.inProgress;
    case "acepted":
      return ProjectStatusEnum.acepted;
    case "rejected":
      return ProjectStatusEnum.rejected;
    default:
      return ProjectStatusEnum.inProgress;
  }
}

class Project {
  final String title;
  final ProjectStatusEnum status;
  final String createdAt;
  final String description;
  final String requirements;
  final String duration;
  final String payment;

  Project({
    required this.description,
    required this.requirements,
    required this.duration,
    required this.payment,
    required this.title,
    required this.status,
    required this.createdAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      status: fromStringToProjectStatusEnum(json['status']),
      description: json['description'],
      requirements: json['requirements'],
      duration: json['duration'],
      payment: json['payment'],
      createdAt: json['createdAt'],
    );
  }
}
