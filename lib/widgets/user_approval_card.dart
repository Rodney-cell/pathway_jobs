import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class UserApprovalCard extends StatelessWidget {
  final String userId;
  final String email;
  final String department;

  const UserApprovalCard({
    super.key,
    required this.userId,
    required this.email,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final AdminService adminService = AdminService();

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(email, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text("Department: $department"),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => adminService.approveUser(userId),
                  child: const Text("Approve"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => adminService.rejectUser(userId),
                  child: const Text("Reject"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}