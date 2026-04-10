import 'package:flutter/material.dart';

class JobseekerDashboard extends StatelessWidget {
  const JobseekerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Job Seeker Dashboard',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}