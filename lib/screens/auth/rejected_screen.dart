import 'package:flutter/material.dart';

class RejectedScreen extends StatelessWidget {
  const RejectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Your account was not approved",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}