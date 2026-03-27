class JobPost {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String salary;
  final String type;
  final String postedBy;
  final DateTime createdAt;

  JobPost({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    required this.salary,
    required this.type,
    required this.postedBy,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'description': description,
      'salary': salary,
      'type': type,
      'postedBy': postedBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory JobPost.fromMap(Map<String, dynamic> map) {
    return JobPost(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      salary: map['salary'] ?? '',
      type: map['type'] ?? '',
      postedBy: map['postedBy'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}