// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FillPatientInfoController {
  static var logger = Logger();
  static final db = FirebaseFirestore.instance;

  static void addPatientInformation(Map<String, dynamic> json) {
    db.collection('patients').doc(json['id']).set(json);
  }

  static Future<void> getPatient() async {
    await db.collection("patients").get().then((event) {
      for (var doc in event.docs) {
        logger.i("${doc.id} => ${doc.data()}");
      }
    });
  }

  static Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance.doc("patients/$docID").get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      return false;
    }
  }
}
