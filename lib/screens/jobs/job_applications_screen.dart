import 'package:flutter/material.dart';

class JobApplicationsScreen extends StatelessWidget {
  const JobApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Applications"),
      ),
      body: const Center(
        child: Text("Applications will appear here"),
      ),
    );
  }
}