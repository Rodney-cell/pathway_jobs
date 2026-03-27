import 'package:flutter/material.dart';
import '../../models/job_post.dart';
import '../../services/job_service.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {

  final _title = TextEditingController();
  final _company = TextEditingController();
  final _location = TextEditingController();
  final _salary = TextEditingController();

  final JobService _jobService = JobService();

  void postJob() async {

    final job = JobPost(
      id: '',
      title: _title.text,
      company: _company.text,
      location: _location.text,
      salary: _salary.text,
    );

    await _jobService.createJob(job);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Job"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: "Job Title",
              ),
            ),

            TextField(
              controller: _company,
              decoration: const InputDecoration(
                labelText: "Company",
              ),
            ),

            TextField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: "Location",
              ),
            ),

            TextField(
              controller: _salary,
              decoration: const InputDecoration(
                labelText: "Salary",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: postJob,
              child: const Text("Post Job"),
            )

          ],
        ),
      ),
    );
  }
}