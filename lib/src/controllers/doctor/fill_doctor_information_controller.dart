import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FillDoctorInfoController {
  static var logger = Logger();
  static final db = FirebaseFirestore.instance;

  static void addDoctorInformation(Map<String, dynamic> json) {
    db.collection('doctors').doc(json['id']).set(json);
  }
}

