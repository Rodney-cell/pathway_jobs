import 'package:cloud_firestore/cloud_firestore.dart';

class FundingService {
  static Future<void> addFunding(String name, String amount) async {
    await FirebaseFirestore.instance.collection('funding_programs').add({
      'name': name,
      'amount': amount,
    });
  }
}