import 'package:flutter/material.dart';
// Added MainDashboard import
import 'package:pathway_jobs/screens/main/main_dashboard.dart';

// FIXED: Updated Package Imports to reflect the new file location
import 'package:pathway_jobs/screens/job_post_screen.dart';
import 'package:pathway_jobs/screens/jobs/job_list_screen.dart';
import 'package:pathway_jobs/screens/jobs/job_applications_screen.dart';

class EmployerDashboard extends StatelessWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employer Dashboard"),
        // Added Switch Role button
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: "Switch Role",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainDashboard()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Post New Job
          ListTile(
            leading: const Icon(Icons.add_box_outlined, color: Colors.blue),
            title: const Text("Post New Job"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobPostScreen(),
                ),
              );
            },
          ),
          const Divider(),

          // View Posted Jobs
          ListTile(
            leading: const Icon(Icons.list_alt, color: Colors.green),
            title: const Text("View Posted Jobs"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobListScreen(),
                ),
              );
            },
          ),
          const Divider(),

          // View Applications
          ListTile(
            leading: const Icon(Icons.people_outline, color: Colors.orange),
            title: const Text("Applications"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobApplicationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
