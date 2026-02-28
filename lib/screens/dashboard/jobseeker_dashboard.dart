import 'package:flutter/material.dart';

class JobSeekerDashboard extends StatelessWidget {
  const JobSeekerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Job Seeker Dashboard',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}