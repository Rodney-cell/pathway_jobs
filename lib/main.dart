import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/auth/login_screen.dart';
import 'screens/admin/approval_screen.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PathwayJobsApp());
}

class PathwayJobsApp extends StatelessWidget {
  const PathwayJobsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathway Jobs',
      debugShowCheckedModeBanner: false,

      home: const LoginScreen(),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/admin-approvals': (context) => const ApprovalScreen(),
      },
    );
  }
}