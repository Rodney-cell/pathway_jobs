class InterviewBooking {
  final String id;
  final String jobId;
  final String applicantId;
  final String employerId;
  final DateTime interviewDate;
  final String status;

  InterviewBooking({
    required this.id,
    required this.jobId,
    required this.applicantId,
    required this.employerId,
    required this.interviewDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jobId': jobId,
      'applicantId': applicantId,
      'employerId': employerId,
      'interviewDate': interviewDate.toIso8601String(),
      'status': status,
    };
  }

  factory InterviewBooking.fromMap(Map<String, dynamic> map) {
    return InterviewBooking(
      id: map['id'] ?? '',
      jobId: map['jobId'] ?? '',
      applicantId: map['applicantId'] ?? '',
      employerId: map['employerId'] ?? '',
      interviewDate: DateTime.parse(map['interviewDate']),
      status: map['status'] ?? '',
    );
  }
}