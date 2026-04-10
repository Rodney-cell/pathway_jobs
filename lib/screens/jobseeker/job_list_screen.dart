import 'package:flutter/material.dart';
import 'job_detail_screen.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      "Construction Worker",
      "General Worker",
      "Security Guard",
      "Cleaner",
      "Driver",
      "Warehouse Worker",
      "Electrician",
      "Plumber",
      "IT Support",
      "Admin Clerk"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Jobs"),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jobs[index]),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      JobDetailScreen(jobTitle: jobs[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}