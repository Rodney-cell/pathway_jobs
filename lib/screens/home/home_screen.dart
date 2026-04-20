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

    // 1. Safety check for logged in user
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    return FutureBuilder<Map<String, dynamic>?>(
      future: AuthService().getUserProfile(user.uid),
      builder: (context, snapshot) {
        // 2. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 3. FIX: Handle missing Firestore Document (The "Error loading profile" fix)
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text("Setup Account")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text("No profile found. Please set up your role."),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Text("Go to Profile Setup"),
                  ),
                  TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
          );
        }

        final data = snapshot.data!;
        final role = data['role'] ?? "jobseeker";
        final status = data['status'] ?? "approved";

        // 4. Pending approval screen
        if (status == "pending") {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Pending Approval"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async => await FirebaseAuth.instance.signOut(),
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

        // 5. Dashboard selection logic
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
                tooltip: "Profile",
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              IconButton(
                tooltip: "Logout",
                icon: const Icon(Icons.logout),
                onPressed: () async => await FirebaseAuth.instance.signOut(),
              ),
            ],
          ),
          body: getDashboard(),
        );
      },
    );
  }
}
