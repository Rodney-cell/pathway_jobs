import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getPendingGovernmentUsers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'government')
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  Future<void> approveUser(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'status': 'active',
      'approvedAt': Timestamp.now(),
    });
  }

  Future<void> rejectUser(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'status': 'rejected',
      'rejectedAt': Timestamp.now(),
    });
  }
}