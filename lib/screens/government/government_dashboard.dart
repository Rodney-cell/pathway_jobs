import 'package:flutter/material.dart';

class GovernmentDashboard extends StatelessWidget {
  const GovernmentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Dashboard'),
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
              "Post Jobs",
              Icons.post_add,
              () {},
            ),

            _buildCard(
              context,
              "Manage Programs",
              Icons.account_balance,
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
              "Settings",
              Icons.settings,
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