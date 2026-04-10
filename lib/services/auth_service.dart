import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 📡 AUTH STATE STREAM - Listens for login/logout automatically
  Stream<User?> get userStream => _auth.authStateChanges();

  // 🔐 EMAIL LOGIN with specific error handling
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "An unknown login error occurred.";
    }
  }

  // 🆕 REGISTER USER
  Future<UserCredential> register(
    String email,
    String password,
  ) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 🔵 GOOGLE SIGN-IN
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Create document only if it's a new user
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await saveUserRole(userCredential.user!.uid, 'jobseeker', 'active');
      }

      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // 🔥 SAVE USER ROLE
  Future<void> saveUserRole(String uid, String role, String status) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'role': role,
      'status': status,
      'createdAt': FieldValue.serverTimestamp(), // Better than Timestamp.now()
    }, SetOptions(merge: true));
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
    ]);
  }
}
