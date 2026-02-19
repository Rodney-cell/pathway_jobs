import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pathway Jobs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "From Application to Employment.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Register"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jobs');
              },
              child: Text("Find Jobs"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cv_builder');
              },
              child: Text("Build CV"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/premium');
              },
              child: Text("Premium"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),

            SizedBox(height: 40),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin');
              },
              child: Text("Admin Login"),
            ),
          ],
        ),
      ),
    );
  }
}
