import 'package:flutter/material.dart';
import 'package:pathway_jobs/models/job_post.dart';
import 'package:pathway_jobs/services/job_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final JobService _jobService = JobService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    locationController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  Future<void> _addJob() async {
    if (titleController.text.isEmpty || companyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in the title and company")),
      );
      return;
    }

    final newJob = JobPost(
      id: '',
      title: titleController.text,
      company: companyController.text,
      location: locationController.text,
      salary: salaryController.text,
    );

    try {
      await _jobService.createJob(newJob);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Job Added Successfully")),
      );

      titleController.clear();
      companyController.clear();
      locationController.clear();
      salaryController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add job: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField(titleController, "Job Title", TextInputAction.next),
              _buildField(companyController, "Company", TextInputAction.next),
              _buildField(locationController, "Location", TextInputAction.next),
              _buildField(salaryController, "Salary", TextInputAction.done),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addJob,
                  child: const Text("Add Job"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
      TextEditingController controller,
      String label,
      TextInputAction action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        textInputAction: action,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}