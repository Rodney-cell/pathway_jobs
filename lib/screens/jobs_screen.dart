import 'package:flutter/material.dart';
import '../services/job_service.dart';
import '../models/job_model.dart';

class JobsScreen extends StatelessWidget {
  final JobService _jobService = JobService();

  @override
  Widget build(BuildContext context) {
    List<Job> jobs = _jobService.getJobs();

    return Scaffold(
      appBar: AppBar(
        title: Text("Job Listings"),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          Job job = jobs[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(job.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.company),
                  Text(job.location),
                  if (job.isFeatured)
                    Text(
                      "⭐ Featured Job",
                      style: TextStyle(color: Colors.orange),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
