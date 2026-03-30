import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_application.dart';

class ApplicationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Apply for job
  Future<void> apply(JobApplication application) async {
    final doc = _firestore.collection('applications').doc();

    await doc.set({
      ...application.toMap(),
      'id': doc.id,
    });
  }

  // Get user applications
  Stream<List<JobApplication>> getUserApplications(String userId) {
    return _firestore
        .collection('applications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobApplication.fromMap(
                  doc.data(),
                  doc.id,
                ))
            .toList());
  }

  // Get all applications (Employer dashboard)
  Stream<List<JobApplication>> getAllApplications() {
    return _firestore
        .collection('applications')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobApplication.fromMap(
                  doc.data(),
                  doc.id,
                ))
            .toList());
  }

  // Update application status
  Future<void> updateStatus(String id, String status) async {
    await _firestore.collection('applications').doc(id).update({
      'status': status,
    });
  }
}