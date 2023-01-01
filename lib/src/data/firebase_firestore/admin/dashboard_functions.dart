import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_health_assistant/src/const_variables.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/models/users/patient.dart';

class DashBoardFunctions {
  static Stream<List<Article>> getAllArticles() {
    return FirebaseFirestore.instance.collection('articles').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Article.fromJson(doc.data())).toList());
  }

  static Stream<List<Article>> getAllArticlesByCondition(String status) {
    if (status == 'All') {
      return FirebaseFirestore.instance.collection('articles').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Article.fromJson(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection('articles')
          .where('category', isEqualTo: status)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Article.fromJson(doc.data()))
              .toList());
    }
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

  static Stream<List<Appointment>> getAllAppointment() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Appointment.fromJson(doc.data()))
            .toList());
  }

  static Stream<List<Appointment>> getAllAppointmentByCondition(String status) {
    if (status == 'All') {
      return FirebaseFirestore.instance
          .collection('appointments')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Appointment.fromJson(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection('appointments')
          .where('status', isEqualTo: status)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Appointment.fromJson(doc.data()))
              .toList());
    }
  }

  static List<Appointment> getAppointmentByCon(
      List<Appointment> appointments, String condition) {
    List<Appointment> appointmentList = [];
    for (var element in appointments) {
      if (element.status == condition) {
        appointmentList.add(element);
      }
    }
    return appointmentList;
  }

  static void deleteAllAppointmentByStatus(String status) async {
    if (status == 'All') {
      var collection = FirebaseFirestore.instance.collection('appointments');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('appointments')
          .where('status', isEqualTo: status);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }

  static void deleteAllArticlesByStatus(String status) async {
    if (status == 'All') {
      var collection = FirebaseFirestore.instance.collection('articles');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('articles')
          .where('category', isEqualTo: status);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }

  static Stream<DocumentSnapshot> getAdminAccount() {
    return FirebaseFirestore.instance
        .collection("admin")
        .doc(AdminValues.adminId)
        .snapshots();
  }

}
