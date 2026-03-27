import 'package:flutter/material.dart';
import '../../widgets/program_card.dart';

class GovernmentProgramsScreen extends StatelessWidget {
  const GovernmentProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Government Programs"),
      ),
      body: ListView(
        children: const [

          ProgramCard(
            title: "Skills Development",
            description: "Government funded training programs",
          ),

          ProgramCard(
            title: "Youth Employment",
            description: "Employment opportunities for youth",
          ),

          ProgramCard(
            title: "Learnerships",
            description: "Learnership opportunities",
          ),

        ],
      ),
    );
  }
}