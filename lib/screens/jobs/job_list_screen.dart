import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// FIXED: Using Professional Package Imports
import 'package:pathway_jobs/widgets/job_card.dart';
import 'package:pathway_jobs/services/job_service.dart';
import 'package:pathway_jobs/models/job_post.dart';
import 'package:pathway_jobs/services/application_service.dart';
import 'package:pathway_jobs/models/job_application.dart';
// Updated path to point to the correct folder
import 'package:pathway_jobs/screens/job_post_screen.dart';

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
    if (!mounted) return;
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
      body: jobs.isEmpty 
        ? const Center(child: CircularProgressIndicator()) 
        : ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              return JobCard(
                job: jobs[index],
                onApply: () async {
                  final user = FirebaseAuth.instance.currentUser;

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

                  if (!mounted) return;
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
