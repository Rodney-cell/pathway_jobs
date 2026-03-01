import 'package:flutter/material.dart';
import '../../services/job_alert_service.dart';

class JobAlertScreen extends StatefulWidget {
  const JobAlertScreen({super.key});

  @override
  State<JobAlertScreen> createState() => _JobAlertScreenState();
}

class _JobAlertScreenState extends State<JobAlertScreen> {
  final titleCtrl = TextEditingController();
  final keywordCtrl = TextEditingController();

  Future<void> saveAlert() async {
    await JobAlertService.createAlert(
      titleCtrl.text.trim(),
      keywordCtrl.text.trim(),
    );

    titleCtrl.clear();
    keywordCtrl.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job alert saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Alerts')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Alert title'),
            ),
            TextField(
              controller: keywordCtrl,
              decoration: const InputDecoration(labelText: 'Keyword (e.g. driver)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveAlert,
              child: const Text('Create Alert'),
            ),
          ],
        ),
      ),
    );
  }
}