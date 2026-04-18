import 'package:cloud_firestore/cloud_firestore.dart';
// Use the package import to ensure the compiler sees the correct model
import 'package:pathway_jobs/models/interview_booking.dart';

class InterviewService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createInterview(InterviewBooking interview) async {
    await _firestore
        .collection('interviews')
        .doc(interview.id)
        .set(interview.toMap());
  }

  Stream<List<InterviewBooking>> getInterviews(String userId) {
    return _firestore
        .collection('interviews')
        .where('applicantId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => InterviewBooking.fromMap(
                  doc.data(), // Argument 1
                  doc.id,     // Argument 2
                ))
            .toList());
  }
}
