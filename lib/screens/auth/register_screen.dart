import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  String selectedRole = ROLE_JOBSEEKER;

  Future<void> _register() async {
    try {
      await _authService.register(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: selectedRole,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            selectedRole == ROLE_GOVERNMENT
                ? 'Registration submitted. Await approval.'
                : 'Registration successful. Please log in.',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _login() async {
    // Assume you already have user.uid from the authentication process
    final user = // your logic to get the user;

    final profile = await _authService.getUserProfile(user.uid);

    if (profile == null) return;

    final role = profile['role'];
    final status = profile['status'];

    if (status != 'active') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account pending approval')),
      );
      return;
    }

    // Add any further logic for successful login here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: const [
                DropdownMenuItem(
                  value: ROLE_JOBSEEKER,
                  child: Text('Jobseeker'),
                ),
                DropdownMenuItem(
                  value: ROLE_EMPLOYER,
                  child: Text('Employer'),
                ),
                DropdownMenuItem(
                  value: ROLE_GOVERNMENT,
                  child: Text('Government'),
                ),
              ],
              onChanged: (value) {
                setState(() => selectedRole = value!);
              },
              decoration: const InputDecoration(labelText: 'Select Role'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}