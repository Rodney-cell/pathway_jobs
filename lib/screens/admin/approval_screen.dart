import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/admin_service.dart';
import '../../widgets/user_approval_card.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminService adminService = AdminService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Government Account Approvals"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: adminService.getPendingGovernmentUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No pending approvals"),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return UserApprovalCard(
                userId: doc.id,
                email: data['email'] ?? 'No email',
                department: data['department'] ?? 'Unknown',
              );
            }).toList(),
          );
        },
      ),
    );
  }
}