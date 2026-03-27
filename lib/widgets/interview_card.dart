import 'package:flutter/material.dart';
import '../models/interview_booking.dart';

class InterviewCard extends StatelessWidget {
  final InterviewBooking interview;

  const InterviewCard({
    super.key,
    required this.interview,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text("Interview"),
        subtitle: Text(interview.status),
      ),
    );
  }
}