class JobApplication {
  final String id;
  final String jobId;
  final String userId;
  final String status;
  final DateTime appliedAt;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.status,
    required this.appliedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jobId': jobId,
      'userId': userId,
      'status': status,
      'appliedAt': appliedAt.toIso8601String(),
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      id: map['id'] ?? '',
      jobId: map['jobId'] ?? '',
      userId: map['userId'] ?? '',
      status: map['status'] ?? '',
      appliedAt: DateTime.parse(map['appliedAt']),
    );
  }
}