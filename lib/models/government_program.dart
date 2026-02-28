class GovernmentProgram {
  final String id;
  final String title;
  final String description;

  GovernmentProgram({
    required this.id,
    required this.title,
    required this.description,
  });

  factory GovernmentProgram.fromMap(String id, Map<String, dynamic> data) {
    return GovernmentProgram(
      id: id,
      title: data['title'],
      description: data['description'],
    );
  }
}