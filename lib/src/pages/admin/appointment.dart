import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

import 'widget/appbar_admin.dart';

class AppointmentAdminScreen extends StatefulWidget {
  const AppointmentAdminScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentAdminScreen> createState() => _AppointmentAdminScreenState();
}

class _AppointmentAdminScreenState extends State<AppointmentAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarAdmin(),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: StreamBuilder<List<Appointment>>(
              stream: DashBoardFunctions.getAllAppointment(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<Appointment> appointments = snapshot.data ?? [];
                  appointments.sort((a, b) {
                    DateTime aDate = DateFormat('dd-MM-yyyy HH:mm')
                        .parse('${a.date} ${a.time}');
                    log(aDate.toString());
                    DateTime bDate = DateFormat('dd-MM-yyyy HH:mm')
                        .parse('${b.date} ${b.time}');
                    return aDate.compareTo(bDate);
                  });
                  List<DataRow> cells = [];
                  int length = snapshot.data?.length ?? 0;
                  for (int i = 0; i < length; i++) {
                    cells.add(DataRow(cells: [
                      DataCell(Text('${appointments[i].date}')),
                      DataCell(Text('${appointments[i].time}')),
                      DataCell(Text('${appointments[i].doctorName}')),
                      const DataCell(Text('department')),
                      DataCell(Text('${appointments[i].patientName}')),
                      DataCell(Text('${appointments[i].status}')),
                      DataCell(IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('appointments')
                              .doc(snapshot.data?[i].id)
                              .delete();
                        },
                        icon: const Icon(CupertinoIcons.xmark_circle_fill),
                        iconSize: 18,
                      )),
                    ]));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Appointment',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Manage All Appointment',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              )
                            ]),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text('Date',
                                  style: MyFontStyles.blackColorH1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Time',
                                  style: MyFontStyles.blackColorH1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Doctor',
                                  style: MyFontStyles.blackColorH1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Department',
                                  style: MyFontStyles.blackColorH1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Patient',
                                  style: MyFontStyles.blackColorH1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                                label: Text('Status',
                                    style: MyFontStyles.blackColorH1.copyWith(
                                        fontWeight: FontWeight.bold))),
                            const DataColumn(
                              label: Text(''),
                            ),
                          ],
                          rows: cells,
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}

class AppointmentObject {
  String date;
  String time;
  String doctor;
  String department;
  String patient;
  String status;

  AppointmentObject(
      {required this.date,
      required this.time,
      required this.doctor,
      required this.department,
      required this.patient,
      required this.status});
}

List<AppointmentObject> listAppointmentAdmin = [
  AppointmentObject(
      time: '9:30',
      date: '20/12/2022',
      doctor: 'Linh xe ôm',
      department: 'Dentist',
      patient: 'Thành',
      status: 'Upcoming'),
  AppointmentObject(
      time: '14:30',
      date: '20/12/2022',
      doctor: 'Lil Rùa',
      department: 'Dentist',
      patient: 'Long',
      status: 'Completed'),
];
