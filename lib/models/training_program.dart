class TrainingProgram {
  final String id;
  final String title;
  final String provider;
  final String description;
  final String duration;
  final String location;
  final DateTime createdAt;

  TrainingProgram({
    required this.id,
    required this.title,
    required this.provider,
    required this.description,
    required this.duration,
    required this.location,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'provider': provider,
      'description': description,
      'duration': duration,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TrainingProgram.fromMap(Map<String, dynamic> map) {
    return TrainingProgram(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      provider: map['provider'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? '',
      location: map['location'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}