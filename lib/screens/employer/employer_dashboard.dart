import 'package:flutter/material.dart';
import '../jobs/job_post_screen.dart';
import '../jobs/job_list_screen.dart';

// Added import for applications screen
import '../jobs/job_applications_screen.dart';

class EmployerDashboard extends StatelessWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employer Dashboard"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          ListTile(
            title: const Text("Post New Job"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobPostScreen(),
                ),
              );
            },
          ),

          ListTile(
            title: const Text("View Posted Jobs"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const JobListScreen(),
                ),
              );
            },
          ),

          // Added Applications list tile
          ListTile(
            title: const Text("Applications"),
            trailing: const Icon(Icons.arrow_forward),
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