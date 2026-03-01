import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobAlertService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> createAlert(String title, String keyword) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('job_alerts').add({
      'title': title,
      'keyword': keyword,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> myAlerts() {
    final user = _auth.currentUser;
    return _firestore
        .collection('job_alerts')
        .where('userId', isEqualTo: user!.uid)
        .snapshots();
  }
}