import 'package:flutter/material.dart';

class TrainingProgramScreen extends StatelessWidget {
  const TrainingProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Training Programs"),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Construction Training"),
          ),
          ListTile(
            title: Text("Security Training"),
          ),
          ListTile(
            title: Text("Driving Training"),
          ),
          ListTile(
            title: Text("IT Skills Training"),
          ),
        ],
      ),
    );
  }
}