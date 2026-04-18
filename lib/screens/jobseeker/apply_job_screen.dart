import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApplyJobScreen extends StatefulWidget {

  final String jobId;
  final String jobTitle;

  const ApplyJobScreen({
    super.key,
    required this.jobId,
    required this.jobTitle,
  });

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {

  bool isLoading = false;

  Future<void> applyJob() async {

    setState(() {
      isLoading = true;
    });

    try {

      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('applications')
          .add({
        'jobId': widget.jobId,
        'jobTitle': widget.jobTitle,
        'applicantId': user!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Application Submitted"),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );

    }

    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Apply - ${widget.jobTitle}"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: isLoading ? null : applyJob,
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text("Apply Now"),
        ),
      ),
    );
  }
}