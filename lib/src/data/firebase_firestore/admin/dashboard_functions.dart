import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/models/users/patient.dart';

class DashBoardFunctions {
  static Stream<List<Article>> getAllArticles() {
    return FirebaseFirestore.instance.collection('articles').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Article.fromJson(doc.data())).toList());
  }

  static Stream<List<Patient>> getAllPatientAccounts() {
    return FirebaseFirestore.instance.collection('patients').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Patient.fromJson(doc.data())).toList());
  }

  static Stream<List<Doctor>> getAllDoctorAccounts() {
    return FirebaseFirestore.instance.collection('doctors').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Doctor.fromJson(doc.data())).toList());
  }
}
