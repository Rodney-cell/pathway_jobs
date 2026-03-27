class JobPost {

  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;

  JobPost({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
  });

  factory JobPost.fromMap(Map<String, dynamic> map, String id) {
    return JobPost(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      salary: map['salary'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'salary': salary,
    };
  }
}