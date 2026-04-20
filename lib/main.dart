import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
// Standardized imports using package paths
import 'package:pathway_jobs/screens/auth/login_screen.dart';
import 'package:pathway_jobs/screens/admin/approval_screen.dart';
import 'package:pathway_jobs/screens/home/home_screen.dart';
import 'package:pathway_jobs/screens/auth/role_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔧 FIX: Prevent Windows Firebase crash
  try {
    await FirebaseFirestore.instance.clearPersistence();
  } catch (e) {
    debugPrint("Firestore persistence already cleared: $e");
  }

  runApp(const PathwayJobsApp());
}

class PathwayJobsApp extends StatelessWidget {
  const PathwayJobsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathway Jobs',
      debugShowCheckedModeBanner: false,
      // Professional Theme Configuration
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const RoleRouter(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin-approvals': (context) => const ApprovalScreen(),
      },
    );
  }
}
