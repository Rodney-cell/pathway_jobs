import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationService {
  static Future<void> registerUser({
    required String email,
    required String password,
    required String role,
  }) async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await firestore.collection('users').doc(credential.user!.uid).set({
      'email': email,
      'role': role,
      'status': role == 'jobseeker' ? 'active' : 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}