import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_post.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create Job
  Future<void> createJob(JobPost job) async {
    await _firestore
        .collection('jobs')
        .doc(job.id)
        .set(job.toMap());
  }

  // Get All Jobs
  Stream<List<JobPost>> getJobs() {
    return _firestore
        .collection('jobs')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => JobPost.fromMap(doc.data())).toList());
  }

  // Get Jobs by Employer
  Stream<List<JobPost>> getJobsByEmployer(String employerId) {
    return _firestore
        .collection('jobs')
        .where('postedBy', isEqualTo: employerId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => JobPost.fromMap(doc.data())).toList());
  }

  // Delete Job
  Future<void> deleteJob(String jobId) async {
    await _firestore.collection('jobs').doc(jobId).delete();
  }

  // Update Job
  Future<void> updateJob(JobPost job) async {
    await _firestore
        .collection('jobs')
        .doc(job.id)
        .update(job.toMap());
  }
}