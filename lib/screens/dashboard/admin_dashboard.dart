import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}