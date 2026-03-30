class JobApplication {

  final String id;
  final String jobId;
  final String userId;
  final String status;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.status,
  });

  factory JobApplication.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return JobApplication(
      id: id,
      jobId: map['jobId'] ?? '',
      userId: map['userId'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'userId': userId,
      'status': status,
    };
  }
}