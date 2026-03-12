import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/jobseeker/profile_screen.dart';
import '../screens/employer/employer_profile_screen.dart';
import '../screens/government/government_dashboard_screen.dart';

class RoleRouter {
  static Future<void> routeUser(
      BuildContext context, String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (!doc.exists) {
      // 🔥 AUTO-CREATE USER WITH DEFAULT ROLE
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
        'role': 'jobseeker',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );

      return;
    }

    final role = doc.data()?['role'];

    if (!context.mounted) return;

    if (role == 'employer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const EmployerProfileScreen(),
        ),
      );
    } else if (role == 'government') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const GovernmentDashboardScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    }
  }
}