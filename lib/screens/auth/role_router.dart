import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Screens
import 'package:pathway_jobs/screens/auth/login_screen.dart';
import 'package:pathway_jobs/screens/main/main_dashboard.dart';

class RoleRouter extends StatelessWidget {
  const RoleRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 🔄 Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // ❌ Not logged in
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // ✅ Logged in → ALWAYS go to Role Picker
        return const MainDashboard();
      },
    );
  }
}