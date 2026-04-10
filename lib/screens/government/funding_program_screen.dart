import 'package:flutter/material.dart';

class FundingProgramScreen extends StatelessWidget {
  const FundingProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Funding Programs"),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Youth Employment Fund"),
            subtitle: Text("Support for young entrepreneurs"),
          ),
          ListTile(
            title: Text("Small Business Grant"),
            subtitle: Text("Funding for small businesses"),
          ),
          ListTile(
            title: Text("Skills Development Program"),
            subtitle: Text("Training & funding support"),
          ),
        ],
      ),
    );
  }
}