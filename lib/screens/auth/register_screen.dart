import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();

  String selectedRole = ROLE_JOBSEEKER;
  bool _isLoading = false;
  // 👁️ Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // 2. DISPOSE CONTROLLERS (Prevents Memory Leaks)
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _authService.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final user = result.user;
      if (user != null) {
        String status = "approved"; // Government needs approval
        if (selectedRole == ROLE_GOVERNMENT) {
          status = "pending";
        }
        // Employer needs approval
        if (selectedRole == ROLE_EMPLOYER) {
          status = "pending";
        }
        await _authService.saveUserRole(
          user.uid,
          selectedRole,
          status,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            selectedRole == ROLE_GOVERNMENT || selectedRole == ROLE_EMPLOYER
                ? 'Registration submitted. Await approval.'
                : 'Registration successful.',
          ),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                // 1. EMAIL KEYBOARD TYPE
                keyboardType: TextInputType.emailAddress,
                // 3. UI IMPROVEMENT: NEXT ACTION
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              // Password Field 👁️
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password Field 👁️
              TextField(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword
