import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/job_post.dart';

class JobService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<JobPost>> getJobs() async {

    final snapshot =
        await _firestore.collection('jobs').get();

    return snapshot.docs.map((doc) {
      return JobPost.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Future<void> createJob(JobPost job) async {
    await _firestore.collection('jobs').add(
      job.toMap(),
    );
  }
}