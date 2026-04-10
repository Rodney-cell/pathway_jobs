import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

// Dashboards
import '../jobseeker/jobseeker_dashboard.dart';
import '../dashboard/employer_dashboard.dart';
import '../government/government_dashboard.dart';
import '../admin/admin_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("User not logged in"),
        ),
      );
    }

    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthService().getUserProfile(user.uid),
      builder: (context, snapshot) {

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Error
        if (snapshot.hasError || !snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: Text("Error loading profile"),
            ),
          );
        }

        final data = snapshot.data!;
        final role = data['role'];
        final status = data['status'];

        // 🚨 Pending approval
        if (status == "pending") {
          return const Scaffold(
            body: Center(
              child: Text(
                "Your account is pending approval.\nPlease wait for admin approval.",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Role Routing
        switch (role) {

          case "jobseeker":
            return const JobSeekerDashboard();

          case "employer":
            return const EmployerDashboard();

          case "government":
            return const GovernmentDashboard();

          case "admin":
            return const AdminDashboard();

          default:
            return const JobSeekerDashboard();
        }
      },
    );
  }
}