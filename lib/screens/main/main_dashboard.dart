import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// FIXED: Using Package Imports
import 'package:pathway_jobs/screens/jobseeker/jobseeker_dashboard.dart';
import 'package:pathway_jobs/screens/employer/employer_dashboard.dart';
import 'package:pathway_jobs/screens/government/government_dashboard.dart';
import 'package:pathway_jobs/screens/admin/admin_dashboard.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  Future<void> setRole(BuildContext context, String role) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Update the role in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({
      'role': role,
      'status': role == 'jobseeker' ? 'active' : 'pending', // Government/Employer usually need approval
    }, SetOptions(merge: true));

    if (!context.mounted) return;

    // Navigate to the correct dashboard
    Widget nextScreen;
    switch (role) {
      case 'employer':
        nextScreen = const EmployerDashboard();
        break;
      case 'government':
        nextScreen = const GovernmentDashboard();
        break;
      case 'admin':
        nextScreen = const AdminDashboard();
        break;
      default:
        nextScreen = const JobSeekerDashboard();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pathway Jobs"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome! Select Your Role",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              _roleButton(context, "Job Seeker", 'jobseeker', Colors.blue),
              const SizedBox(height: 15),
              _roleButton(context, "Employer", 'employer', Colors.green),
              const SizedBox(height: 15),
              _roleButton(context, "Government", 'government', Colors.orange),
              const SizedBox(height: 15),
              _roleButton(context, "Admin", 'admin', Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton(BuildContext context, String label, String role, Color color) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          // FIXED: Swapped back to standard withOpacity(0.1)
          backgroundColor: color.withOpacity(0.1), 
          foregroundColor: color,
        ),
        onPressed: () => setRole(context, role),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
