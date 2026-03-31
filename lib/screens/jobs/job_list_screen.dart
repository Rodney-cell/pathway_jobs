import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/job_card.dart';
import '../../services/job_service.dart';
import '../../models/job_post.dart';
import '../../services/application_service.dart';
import '../../models/job_application.dart';

import 'job_post_screen.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final JobService _jobService = JobService();
  final ApplicationService _applicationService = ApplicationService();

  List<JobPost> jobs = [];

  @override
  void initState() {
    super.initState();
    loadJobs();
  }

  void loadJobs() async {
    final data = await _jobService.getJobs();
    setState(() {
      jobs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs"),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return JobCard(
            job: jobs[index],

            // Apply Button Logic
            onApply: () async {
              final user = FirebaseAuth.instance.currentUser;

              // If not logged in → go to login
              if (user == null) {
                Navigator.pushNamed(context, '/login');
                return;
              }

              final application = JobApplication(
                id: '',
                jobId: jobs[index].id,
                userId: user.uid,
                status: "pending",
              );

              await _applicationService.apply(application);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Application Sent"),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const JobPostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}