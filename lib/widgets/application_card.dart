import 'package:flutter/material.dart';
import '../models/job_application.dart';

class ApplicationCard extends StatelessWidget {
  final JobApplication application;

  const ApplicationCard({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Application"),
        subtitle: Text("Status: ${application.status}"),
      ),
    );
  }
}