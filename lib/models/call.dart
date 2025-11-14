class Call {
  final String id;
  final String title;
  final int applicantsCount;
  final DateTime createdAt;
  final String description;
  final String status;

  Call({
    required this.id,
    required this.title,
    required this.applicantsCount,
    required this.createdAt,
    required this.description,
    this.status = 'active',
  });

  String getDaysAgo() {
    final difference = DateTime.now().difference(createdAt);
    final days = difference.inDays;

    if (days == 0) return 'Hoy';
    if (days == 1) return 'Hace 1 día';
    return 'Hace $days días';
  }
}

