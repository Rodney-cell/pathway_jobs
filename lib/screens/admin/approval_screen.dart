import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/admin_service.dart';
// Note: Ensure UserApprovalCard accepts onApprove and onReject callbacks
import '../../widgets/user_approval_card.dart'; 

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key});

  // Helper method to handle status updates to Firestore
  Future<void> _updateUserStatus(BuildContext context, String userId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
        'status': newStatus,
      });
      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User $newStatus successfully')),
      );
    } catch (e) {
      // Handle errors (e.g., permission denied)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

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
              final String userId = doc.id;

              return UserApprovalCard(
                userId: userId,
                email: data['email'] ?? 'No email',
                department: data['department'] ?? 'Unknown',
                // --- INTEGRATION POINT ---
                onApprove: () => _updateUserStatus(context, userId, 'approved'),
                onReject: () => _updateUserStatus(context, userId, 'rejected'),
                // -------------------------
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
