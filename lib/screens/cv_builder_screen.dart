import 'package:flutter/material.dart';

class CVBuilderScreen extends StatelessWidget {
  const CVBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CV Builder"),
      ),
      body: const Center(
        child: Text("CV Builder Screen"),
      ),
    );
  }
}
