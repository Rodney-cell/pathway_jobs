import 'package:flutter/material.dart';

class ApplicationTrackingScreen extends StatelessWidget {
  const ApplicationTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Applications"),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Construction Worker"),
            subtitle: Text("Status: Pending"),
          ),
          ListTile(
            title: Text("Security Guard"),
            subtitle: Text("Status: Approved"),
          ),
        ],
      ),
    );
  }
}