class InterviewBooking {

  final String id;
  final String applicationId;
  final String status;

  InterviewBooking({
    required this.id,
    required this.applicationId,
    required this.status,
  });

  factory InterviewBooking.fromMap(
      Map<String, dynamic> map,
      String id) {

    return InterviewBooking(
      id: id,
      applicationId: map['applicationId'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'applicationId': applicationId,
      'status': status,
    };
  }
}