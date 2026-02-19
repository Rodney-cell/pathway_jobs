import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      final newUser = AppUser(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        location: locationController.text,
        education: educationController.text,
        skills: skillsController.text,
      );

      _userService.registerUser(newUser);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildField(nameController, "Full Name"),
                _buildField(emailController, "Email"),
                _buildField(phoneController, "Phone"),
                _buildField(locationController, "Location"),
                _buildField(educationController, "Education"),
                _buildField(skillsController, "Skills"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerUser,
                  child: Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: (value) =>
            value!.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
