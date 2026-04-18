import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pathway_jobs/services/auth_service.dart';
import 'package:pathway_jobs/screens/jobseeker/profile_screen.dart';
import 'package:pathway_jobs/screens/jobseeker/jobseeker_dashboard.dart';
import 'package:pathway_jobs/screens/employer/employer_dashboard.dart';
import 'package:pathway_jobs/screens/government/government_dashboard.dart';
import 'package:pathway_jobs/screens/admin/admin_dashboard.dart';

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
      // FIXED: Passed user.uid to match the AuthService method
      future: AuthService().getUserProfile(user.uid),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(
              child: Text("Error loading profile"),
            ),
          );
        }

        final data = snapshot.data!;
        final role = data['role'] ?? "jobseeker";
        final status = data['status'] ?? "pending";

        if (status == "pending") {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Your account is pending approval.\nPlease wait for admin approval.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        Widget getDashboard() {
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
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Pathway Jobs"),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
          body: getDashboard(),
        );
      },
    );
  }
}
