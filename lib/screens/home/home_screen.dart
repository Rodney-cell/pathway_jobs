import 'package:flutter/material.dart';

// Added import for the employer dashboard
import '../employer/employer_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Example existing list tiles (replace or keep as needed)
          ListTile(
            title: const Text('Profile'),
            trailing: const Icon(Icons.person),
            onTap: () {
              // Navigate to profile (example)
            },
          ),

          // Added Employer Dashboard ListTile
          ListTile(
            title: const Text("Employer Dashboard"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmployerDashboard(),
                ),
              );
            },
          ),

          // Other list tiles...
          ListTile(
            title: const Text('Settings'),
            trailing: const Icon(Icons.settings),
            onTap: () {
              // Navigate to settings (example)
            },
          ),
        ],
      ),
    );
  }
}