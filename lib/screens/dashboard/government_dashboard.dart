import 'package:flutter/material.dart';

class GovernmentDashboard extends StatelessWidget {
  const GovernmentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Government Dashboard',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}