import 'package:flutter/material.dart';

import '../jobseeker/job_list_screen.dart';
import '../jobseeker/training_program_screen.dart';
import '../government/government_program_list_screen.dart';
import '../employer/job_post_screen.dart';

class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pathway Jobs"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobListScreen(),
                  ),
                );
              },
              child: const Text("Browse Jobs"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrainingProgramScreen(),
                  ),
                );
              },
              child: const Text("Training Programs"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const GovernmentProgramListScreen(),
                  ),
                );
              },
              child: const Text("Government Programs"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JobPostScreen(),
                  ),
                );
              },
              child: const Text("Post Job (Employer)"),
            ),

          ],
        ),
      ),
    );
  }
}