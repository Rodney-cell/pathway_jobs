import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Correct Dashboard Imports (Fixed)
import 'package:pathway_jobs/screens/admin/admin_dashboard.dart';
import 'package:pathway_jobs/screens/jobseeker/jobseeker_dashboard.dart';
import 'package:pathway_jobs/screens/employer/employer_dashboard.dart';
import 'package:pathway_jobs/screens/government/government_dashboard.dart';

import 'package:pathway_jobs/screens/auth/login_screen.dart';
import 'package:pathway_jobs/screens/auth/rejected_screen.dart';

class RoleRouter extends StatelessWidget {
  const RoleRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Not logged in
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        // Logged in → check role
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(snapshot.data!.uid)
              .get(),
          builder: (context, userSnapshot) {

            // Loading user data
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // If no user data
            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              return const LoginScreen();
            }

            var userData =
                userSnapshot.data!.data() as Map<String, dynamic>;

            String role = userData['role'] ?? 'jobseeker';
            String status = userData['status'] ?? 'active';

            // Admin
            if (role == 'admin') {
              return const AdminDashboard();
            }

            // Government
            if (role == 'government') {
              if (status == 'pending') {
                return const Scaffold(
                  body: Center(
                    child: Text(
                      "Awaiting Admin Approval",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }

              if (status == 'rejected') {
                return const RejectedScreen();
              }

              return const GovernmentDashboard();
            }

            // Employer
            if (role == 'employer') {
              return const EmployerDashboard();
            }

            // Jobseeker (default)
            return const JobSeekerDashboard();
          },
        );
      },
    );
  }
}