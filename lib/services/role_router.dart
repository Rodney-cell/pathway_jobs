import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/dashboard/jobseeker_dashboard.dart';
import '../screens/dashboard/employer_dashboard.dart';
import '../screens/dashboard/government_dashboard.dart';
import '../screens/dashboard/admin_dashboard.dart';

class RoleRouter {
  static Future<void> routeUser(BuildContext context, String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (!doc.exists) {
      _deny(context, "User record not found");
      return;
    }

    final data = doc.data()!;
    final role = data['role'];
    final status = data['status'];

    if (status != 'active') {
      _deny(context, "Account pending approval");
      return;
    }

    Widget destination;

    switch (role) {
      case 'jobseeker':
        destination = const JobSeekerDashboard();
        break;
      case 'employer':
        destination = const EmployerDashboard();
        break;
      case 'government':
        destination = const GovernmentDashboard();
        break;
      case 'admin':
        destination = const AdminDashboard();
        break;
      default:
        _deny(context, "Unknown role");
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  static void _deny(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}