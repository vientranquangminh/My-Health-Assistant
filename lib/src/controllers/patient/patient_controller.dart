import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_health_assistant/src/models/users/patient.dart';

class PatientController {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentPatient(
      String uid) {
    return FirebaseFirestore.instance
        .doc('patients')
        .collection(uid)
        .snapshots();
  }

  static Stream<List<Patient>> getAllPatients() {
    return FirebaseFirestore.instance.collection('patients').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Patient.fromJson(doc.data())).toList());
  }

  static Stream<Patient> getPatientByUid(String uid){
    Patient? patientTemp;
    StreamController<Patient> controller =
        StreamController<Patient>.broadcast(); 

    getAllPatients().listen((value) {
      for (var item in value) {
        if (item.id == uid) {
          patientTemp = item;
        }
      }
      controller.add(patientTemp!);
    });
    return controller.stream;
  }
}
