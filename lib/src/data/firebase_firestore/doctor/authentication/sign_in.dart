import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class SignInDoctor {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;
  static final logger = Logger();

  static Future<void> getDoctor() async {
    await db.collection("doctor").get().then((event) {
      for (var doc in event.docs) {
        logger.i("${doc.id} => ${doc.data()}");
      }
    });
  }

  static Future<bool> checkDoctorExist(String docID) async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance.doc("doctors/$docID").get().then((doc) {
        exist = doc.exists;
      });
      log(exist.toString());
      return exist;
    } catch (e) {
      return false;
    }
  }
}
