import 'package:flutter/material.dart';
import 'package:pathway_jobs/screens/jobseeker/saved_jobs_screen.dart';
// Added MainDashboard import
import 'package:pathway_jobs/screens/main/main_dashboard.dart';
import 'job_list_screen.dart';

class JobSeekerDashboard extends StatelessWidget {
  const JobSeekerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ADDED: AppBar with Switch Role action
      appBar: AppBar(
        title: const Text("Job Seeker Dashboard"),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildCard(
              context,
              "Find Jobs",
              Icons.search,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobListScreen(),
                  ),
                );
              },
            ),

            _buildCard(
              context,
              "My Applications",
              Icons.work,
              () {
                Navigator.pushNamed(context, '/applications');
              },
            ),

            _buildCard(
              context,
              "Saved Jobs",
              Icons.bookmark,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedJobsScreen(),
                  ),
                );
              },
            ),

            _buildCard(
              context,
              "Profile",
              Icons.person,
              () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
