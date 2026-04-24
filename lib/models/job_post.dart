class JobPost {
  final String id;
  final String title;
  final String company;
  final String companyDescription; // ✅ NEW FIELD
  final String location;
  final String salary;
  final bool isFeatured;

  JobPost({
    required this.id,
    required this.title,
    required this.company,
    required this.companyDescription, // ✅ REQUIRED
    required this.location,
    required this.salary,
    this.isFeatured = false,
  });

  factory JobPost.fromMap(Map<String, dynamic> map, String id) {
    return JobPost(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      companyDescription: map['companyDescription'] ?? '', // ✅ READ FROM FIRESTORE
      location: map['location'] ?? '',
      salary: map['salary'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'companyDescription': companyDescription, // ✅ SAVE TO FIRESTORE
      'location': location,
      'salary': salary,
      'isFeatured': isFeatured,
    };
  }
}