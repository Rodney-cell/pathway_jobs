import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // 🔐 EMAIL LOGIN
  Future<UserCredential> login(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  // 🆕 REGISTER USER
  Future<UserCredential> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user != null) {
        await FirestoreService().createUserDocument(user);
      }

      return result;
    } catch (e) {
      throw Exception("Registration failed: ${e.toString()}");
    }
  }

  // 🔵 GOOGLE SIGN-IN (SAFE VERSION)
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn();

      if (googleUser == null) {
        print("User cancelled login");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        print("ERROR: ID Token is NULL");
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      // 🔥 Create Firestore record if new user
      if (user != null) {
        await FirestoreService().createUserDocument(user);
      }

      return user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("Logout error: $e");
    }
  }

  // 👤 GET CURRENT USER
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}