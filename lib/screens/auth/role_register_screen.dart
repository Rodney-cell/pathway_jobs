import 'package:flutter/material.dart';
import '../../services/registration_service.dart';

class RoleRegisterScreen extends StatefulWidget {
  const RoleRegisterScreen({super.key});

  @override
  State<RoleRegisterScreen> createState() => _RoleRegisterScreenState();
}

class _RoleRegisterScreenState extends State<RoleRegisterScreen> {
  String role = 'jobseeker';
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  Future<void> register() async {
    await RegistrationService.registerUser(
      email: emailCtrl.text.trim(),
      password: passCtrl.text.trim(),
      role: role,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration successful')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            DropdownButton<String>(
              value: role,
              items: const [
                DropdownMenuItem(value: 'jobseeker', child: Text('Job Seeker')),
                DropdownMenuItem(value: 'employer', child: Text('Employer')),
                DropdownMenuItem(value: 'government', child: Text('Government')),
              ],
              onChanged: (v) => setState(() => role = v!),
            ),
            ElevatedButton(onPressed: register, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}