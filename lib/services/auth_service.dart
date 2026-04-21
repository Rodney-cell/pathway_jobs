import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 📡 AUTH STATE STREAM
  Stream<User?> get userStream => _auth.authStateChanges();

  // 🔐 EMAIL LOGIN
  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "An unknown login error occurred.";
    }
  }

  // 🆕 REGISTER USER (FINAL CLEAN VERSION)
  Future<UserCredential> register(
    String email,
    String password,
  ) async {
    // 1. Create the user in Firebase Authentication
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. Create empty user profile (NO ROLE YET)
    // This ensures the RoleRouter will redirect to MainDashboard (Role Picker)
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return userCredential;
  }

  // 👤 GET USER PROFILE DATA
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      return doc.data();
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
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

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Force Google users to pick a role by not setting one here
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
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
      'updatedAt': FieldValue.serverTimestamp(),
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
