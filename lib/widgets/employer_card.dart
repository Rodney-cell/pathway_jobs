import 'package:flutter/material.dart';
import '../models/employer_profile.dart';

class EmployerCard extends StatelessWidget {
  final EmployerProfile employer;

  const EmployerCard({
    super.key,
    required this.employer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(employer.companyName),
        subtitle: Text(employer.location),
      ),
    );
  }
}