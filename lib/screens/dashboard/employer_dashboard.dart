import 'package:flutter/material.dart';

class EmployerDashboard extends StatelessWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [

            _buildCard(context, "Post Job", Icons.post_add, () {}),
            _buildCard(context, "Manage Jobs", Icons.work, () {}),
            _buildCard(context, "Applications", Icons.assignment, () {}),
            _buildCard(context, "Company Profile", Icons.business, () {}),
            _buildCard(context, "Reports", Icons.bar_chart, () {}),
            _buildCard(context, "Settings", Icons.settings, () {}),

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
            Text(title),
          ],
        ),
      ),
    );
  }
}