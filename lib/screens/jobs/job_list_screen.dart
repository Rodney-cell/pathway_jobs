import 'package:flutter/material.dart';
import '../../widgets/job_card.dart';
import '../../services/job_service.dart';
import '../../models/job_post.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {

  final JobService _jobService = JobService();
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
          );
        },
      ),
    );
  }
}