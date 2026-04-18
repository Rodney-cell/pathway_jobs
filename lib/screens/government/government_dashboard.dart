import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GovernmentDashboard extends StatelessWidget {
  const GovernmentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // 🔥 Analytics Section
            Row(
              children: [
                Expanded(child: _buildUsersCard()),
                const SizedBox(width: 10),
                Expanded(child: _buildJobsCard()),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: _buildApplicationsCard()),
              ],
            ),

            const SizedBox(height: 20),

            // 🔥 Government Controls
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [

                  _buildCard(
                    context,
                    "Post Jobs",
                    Icons.post_add,
                    () {},
                  ),

                  _buildCard(
                    context,
                    "Manage Programs",
                    Icons.account_balance,
                    () {},
                  ),

                  _buildCard(
                    context,
                    "Applications",
                    Icons.assignment,
                    () {},
                  ),

                  _buildCard(
                    context,
                    "Reports",
                    Icons.bar_chart,
                    () {},
                  ),

                  _buildCard(
                    context,
                    "Settings",
                    Icons.settings,
                    () {},
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  // 🔥 Analytics Cards

  Widget _buildUsersCard() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final count = snapshot.data!.docs.length;

        return Card(
          child: ListTile(
            title: const Text("Total Users"),
            trailing: Text(count.toString()),
          ),
        );
      },
    );
  }

  Widget _buildJobsCard() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final count = snapshot.data!.docs.length;

        return Card(
          child: ListTile(
            title: const Text("Total Jobs"),
            trailing: Text(count.toString()),
          ),
        );
      },
    );
  }

  Widget _buildApplicationsCard() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('applications').snapshots(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final count = snapshot.data!.docs.length;

        return Card(
          child: ListTile(
            title: const Text("Applications"),
            trailing: Text(count.toString()),
          ),
        );
      },
    );
  }

  // 🔥 Grid Cards

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}