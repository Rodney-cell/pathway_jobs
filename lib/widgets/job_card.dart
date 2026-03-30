import 'package:flutter/material.dart';
import '../models/job_post.dart';

class JobCard extends StatelessWidget {
  final JobPost job;
  final VoidCallback? onApply;

  const JobCard({
    super.key,
    required this.job,
    this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(job.title),
        subtitle: Text("${job.company} • ${job.location}"),
        trailing: ElevatedButton(
          onPressed: onApply,
          child: const Text("Apply"),
        ),
      ),
    );
  }
}