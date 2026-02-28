import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramService {
  static Future<void> addProgram(String title, String description) async {
    await FirebaseFirestore.instance.collection('government_programs').add({
      'title': title,
      'description': description,
    });
  }
}