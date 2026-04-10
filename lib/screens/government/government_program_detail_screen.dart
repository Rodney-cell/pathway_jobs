import 'package:flutter/material.dart';

class GovernmentProgramDetailScreen extends StatelessWidget {
  final String programName;

  const GovernmentProgramDetailScreen({
    super.key,
    required this.programName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(programName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              programName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "This program helps citizens gain employment and training opportunities.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }
}