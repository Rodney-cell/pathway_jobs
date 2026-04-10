import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dashboard/admin_dashboard.dart';
import '../dashboard/jobseeker_dashboard.dart';
import '../dashboard/employer_dashboard.dart';
import '../dashboard/government_dashboard.dart';
import '../auth/login_screen.dart'; // 1. Added Import
import 'rejected_screen.dart';

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
            if (!userSnapshot.hasData) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            var userData = userSnapshot.data!.data() as Map<String, dynamic>;
            String role = userData['role'] ?? 'jobseeker';
            // Default to pending if no status set to be safe
            String status = userData['status'] ?? 'pending';

            // Admin
            if (role == 'admin') {
              return const AdminDashboard();
            }

            // Government (Professionalized Approval Flow)
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
              // 2. Added Rejected Logic
              if (status == 'rejected') {
                return const RejectedScreen();
              }
              // Only authorized users reach this
              return const GovernmentDashboard();
            }

            // Employer
            if (role == 'employer') {
              return const EmployerDashboard();
            }

            // Jobseeker
            return JobseekerDashboard(); // <-- Updated here
          },
        );
      },
    );
  }
}
