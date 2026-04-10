import 'package:flutter/material.dart';
import '../jobseeker/profile_screen.dart';

// Added import for the employer dashboard
import '../dashboard/employer_dashboard.dart';

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

          // Profile
          ListTile(
            title: const Text('Profile'),
            trailing: const Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),

          // Employer Dashboard
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

          // Settings
          ListTile(
            title: const Text('Settings'),
            trailing: const Icon(Icons.settings),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}