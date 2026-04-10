import 'package:flutter/material.dart';
import 'government_program_detail_screen.dart';

class GovernmentProgramListScreen extends StatelessWidget {
  const GovernmentProgramListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Government Programs"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Youth Training Program"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const GovernmentProgramDetailScreen(
                        programName: "Youth Training Program",
                      ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Employment Support Program"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const GovernmentProgramDetailScreen(
                        programName: "Employment Support Program",
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}