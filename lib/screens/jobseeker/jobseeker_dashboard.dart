import 'package:flutter/material.dart';

class JobSeekerDashboard extends StatelessWidget {
  const JobSeekerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Seeker Dashboard'),
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
                Navigator.pushNamed(context, '/jobList');
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
              () {},
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
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}