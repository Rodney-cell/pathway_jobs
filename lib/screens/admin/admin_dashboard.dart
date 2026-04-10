import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
              "Manage Users",
              Icons.people,
              () {},
            ),

            _buildCard(
              context,
              "Manage Jobs",
              Icons.work,
              () {},
            ),

            _buildCard(
              context,
              "Applications",
              Icons.assignment,
              () {},
            ),

            _buildCard(
              context,
              "Reports",
              Icons.bar_chart,
              () {},
            ),

            _buildCard(
              context,
              "System Settings",
              Icons.settings,
              () {},
            ),

            _buildCard(
              context,
              "Admin Profile",
              Icons.admin_panel_settings,
              () {},
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