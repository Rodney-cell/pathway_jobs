import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_application.dart';

class ApplicationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Apply for job
  Future<void> apply(JobApplication application) async {
    await _firestore
        .collection('applications')
        .doc(application.id)
        .set(application.toMap());
  }

  // Get user applications
  Stream<List<JobApplication>> getUserApplications(String userId) {
    return _firestore
        .collection('applications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobApplication.fromMap(doc.data()))
            .toList());
  }

  // Update application status
  Future<void> updateStatus(String id, String status) async {
    await _firestore.collection('applications').doc(id).update({
      'status': status,
    });
  }
}