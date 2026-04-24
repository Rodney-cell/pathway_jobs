import 'package:flutter/material.dart';
import 'package:pathway_jobs/models/job_post.dart';
import 'package:pathway_jobs/services/job_service.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final _title = TextEditingController();
  final _company = TextEditingController();
  final _descriptionController = TextEditingController();
  final _location = TextEditingController();
  final _salary = TextEditingController();

  final JobService _jobService = JobService();

  @override
  void dispose() {
    _title.dispose();
    _company.dispose();
    _descriptionController.dispose();
    _location.dispose();
    _salary.dispose();
    super.dispose();
  }

  void postJob() async {
    // Validation BEFORE posting
    if (_title.text.isEmpty ||
        _company.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final job = JobPost(
      id: '',
      title: _title.text,
      company: _company.text,
      companyDescription: _descriptionController.text,
      location: _location.text,
      salary: _salary.text,
      isFeatured: false,
    );

    await _jobService.createJob(job);

    if (!mounted) return;

    // 👇 ADDED: Success message before navigating back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Job posted successfully")),
    );

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: "Job Title *",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _company,
                decoration: const InputDecoration(
                  labelText: "Company *",
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "About the Company *",
                  hintText: "Describe what your company does...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _location,
                decoration: const InputDecoration(
                  labelText: "Location",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _salary,
                decoration: const InputDecoration(
                  labelText: "Salary",
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: postJob,
                  child: const Text("Post Job"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
