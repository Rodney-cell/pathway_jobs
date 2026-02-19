import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final JobService _jobService = JobService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _addJob() {
    final newJob = Job(
      title: titleController.text,
      company: companyController.text,
      location: locationController.text,
      description: descriptionController.text,
    );

    _jobService.addJob(newJob);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Job Added Successfully")),
    );

    titleController.clear();
    companyController.clear();
    locationController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField(titleController, "Job Title"),
              _buildField(companyController, "Company"),
              _buildField(locationController, "Location"),
              _buildField(descriptionController, "Description"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addJob,
                child: Text("Add Job"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
