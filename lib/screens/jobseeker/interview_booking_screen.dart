import 'package:flutter/material.dart';

class InterviewBookingScreen extends StatelessWidget {
  const InterviewBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interview Booking"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Interview Booked"),
              ),
            );
          },
          child: const Text("Book Interview"),
        ),
      ),
    );
  }
}