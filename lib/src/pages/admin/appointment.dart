import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child: Column(
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
                      const DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: List<DataRow>.generate(listAppointmentAdmin.length,
                        (int index) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(listAppointmentAdmin[index].date)),
                          DataCell(Text(listAppointmentAdmin[index].time)),
                          DataCell(Text(listAppointmentAdmin[index].doctor)),
                          DataCell(
                              Text(listAppointmentAdmin[index].department)),
                          DataCell(Text(listAppointmentAdmin[index].patient)),
                          DataCell(IconButton(
                            icon: const Icon(CupertinoIcons.xmark_circle_fill,size: 18,),
                            onPressed: () {
                              setState(() {
                                listAppointmentAdmin.removeAt(index);
                              });
                            },
                          )),
                        ],
                      );
                    }),
                  ),
                )
              ],
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

  AppointmentObject(
      {required this.date,
      required this.time,
      required this.doctor,
      required this.department,
      required this.patient});
}

List<AppointmentObject> listAppointmentAdmin = [
  AppointmentObject(
      time: '9:30',
      date: '20/12/2022',
      doctor: 'Linh xe ôm',
      department: 'Dentist',
      patient: 'Thành'),
  AppointmentObject(
      time: '14:30',
      date: '20/12/2022',
      doctor: 'Lil Rùa',
      department: 'Dentist',
      patient: 'Long'),
];
