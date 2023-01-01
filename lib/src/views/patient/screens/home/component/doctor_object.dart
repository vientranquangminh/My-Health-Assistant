// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../../../models/users/doctor.dart';

// class DoctorObject {
//   final String doctorName;
//   String? department;
//   String? imgUrl;
//   String? hospital;
//   String? gender;
//   String? phoneNumber;
//   DoctorObject(
//       {required this.doctorName,
//       this.department,
//       this.imgUrl,
//       this.hospital,
//       this.gender,
//       this.phoneNumber});
// }

// // Stream<List<Doctor>> getAllDoctor() {
// //   return FirebaseFirestore.instance.collection('doctors').snapshots().map(
// //       (snapshot) =>
// //           snapshot.docs.map((doc) => Doctor.fromJson(doc.data())).toList());
// // }