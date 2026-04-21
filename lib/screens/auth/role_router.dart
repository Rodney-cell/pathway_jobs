import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 1. ADDED: Main Dashboard Import
import 'package:pathway_jobs/screens/main/main_dashboard.dart';

// Correct Dashboard Imports
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(snapshot.data!.uid)
              .get(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // 👇 UPDATED: Error and Missing Data handling
            if (userSnapshot.hasError) {
              return const LoginScreen();
            }

            if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
              return const LoginScreen();
            }

            // EXTRA SAFE: Prevent crash if doc exists but data is null
            var userData = userSnapshot.data!.data() as Map<String, dynamic>? ?? {};

            // SAFER: Default to empty string
            String role = userData['role'] ?? '';
            String status = userData['status'] ?? 'active';

            if (role == 'admin') {
              return const AdminDashboard();
            }

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

            if (role == 'employer') {
              return const EmployerDashboard();
            }

            // 3. FINAL FIX: Only go to JobSeekerDashboard if explicitly set
            if (role == 'jobseeker') {
              return const JobSeekerDashboard();
            }

            // Everything else goes to the Role Picker
            return const MainDashboard();
          },
        );
      },
    );
  }
}
