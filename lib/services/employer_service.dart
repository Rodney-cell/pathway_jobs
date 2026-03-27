import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employer_profile.dart';

class EmployerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createEmployer(EmployerProfile employer) async {
    await _firestore
        .collection('employers')
        .doc(employer.uid)
        .set(employer.toMap());
  }

  Future<EmployerProfile?> getEmployer(String uid) async {
    final doc =
        await _firestore.collection('employers').doc(uid).get();

    if (doc.exists) {
      return EmployerProfile.fromMap(doc.data()!);
    }

    return null;
  }

  Future<void> updateEmployer(EmployerProfile employer) async {
    await _firestore
        .collection('employers')
        .doc(employer.uid)
        .update(employer.toMap());
  }
}