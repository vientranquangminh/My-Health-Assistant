import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

import 'widget/appbar_admin.dart';

const List<String> list = <String>['All', 'Upcoming', 'Completed', 'Cancelled'];

class AppointmentAdminScreen extends StatefulWidget {
  const AppointmentAdminScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentAdminScreen> createState() => _AppointmentAdminScreenState();
}

class _AppointmentAdminScreenState extends State<AppointmentAdminScreen> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarAdmin(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: StreamBuilder<List<Appointment>>(
                stream: DashBoardFunctions.getAllAppointmentByCondition(dropdownValue),
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
                        DataCell(Text('${appointments[i].status}',
                            style: TextStyle(
                                color: appointments[i].status == 'Cancelled'
                                    ? Colors.red
                                    : appointments[i].status == 'Upcoming'
                                        ? Colors.blue
                                        : Colors.green))),
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Manage All Appointment',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                )
                              ]),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                elevation: 10,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                    log('Change status');
                                    appointments = DashBoardFunctions.getAppointmentByCon(appointments, value);
                                    log('${appointments.length}');
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text('Date',
                                      style: MyFontStyles.blackColorH1.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                DataColumn(
                                  label: Text('Time',
                                      style: MyFontStyles.blackColorH1.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                DataColumn(
                                  label: Text('Doctor',
                                      style: MyFontStyles.blackColorH1.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                DataColumn(
                                  label: Text('Department',
                                      style: MyFontStyles.blackColorH1.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                DataColumn(
                                  label: Text('Patient',
                                      style: MyFontStyles.blackColorH1.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ),
                                DataColumn(
                                    label: Text('Status',
                                        style: MyFontStyles.blackColorH1
                                            .copyWith(
                                                fontWeight: FontWeight.bold))),
                                const DataColumn(
                                  label: Text(''),
                                ),
                              ],
                              rows: cells,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              DashBoardFunctions.deleteAllAppointmentByStatus(dropdownValue);
                            },
                            child: Container(
                                width: 130,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Delete All',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )
                                  ],
                                )),
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
