import 'package:flutter/material.dart';

import '../jobs/job_list_screen.dart';
import '../employer/employer_profile.dart';
import '../government/government_programs.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pathway Jobs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          ListTile(
            title: const Text("Find Jobs"),
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

          ListTile(
            title: const Text("Employers"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmployerProfileScreen(),
                ),
              );
            },
          ),

          ListTile(
            title: const Text("Government Programs"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GovernmentProgramsScreen(),
                ),
              );
            },
          ),

          ListTile(
            title: const Text("My Profile"),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}