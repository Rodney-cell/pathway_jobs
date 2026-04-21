import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 📡 AUTH STATE STREAM
  Stream<User?> get userStream => _auth.authStateChanges();

  // 🔐 EMAIL LOGIN (UPDATED VERSION)
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

  // 🆕 REGISTER USER (FIXED VERSION)
  Future<UserCredential> register(
    String email,
    String password,
  ) async {
    // 1. Create the user in Firebase Authentication
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. Automatically create the Firestore Profile
    await saveUserRole(
      userCredential.user!.uid,
      'jobseeker', // Default role
      'active',    // Default status
    );

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
      'createdAt': FieldValue.serverTimestamp(),
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
