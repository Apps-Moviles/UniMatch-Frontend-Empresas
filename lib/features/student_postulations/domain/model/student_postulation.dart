class StudentPostulation {
  final int? id;
  final int studentId;
  final int projectId;
  final String status; // "Pendiente", "Aceptado", "Rechazado"
  final String date;

  StudentPostulation({
    this.id,
    required this.studentId,
    required this.projectId,
    required this.status,
    required this.date,
  });

  factory StudentPostulation.fromJson(Map<String, dynamic> json) {
    return StudentPostulation(
      id: int.tryParse(json['id'].toString()),
      studentId: json['studentId'],
      projectId: json['projectId'],
      status: json['status'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id?.toString(),
      "studentId": studentId,
      "projectId": projectId,
      "status": status,
      "date": date,
    };
  }
}
