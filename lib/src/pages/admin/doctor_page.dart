import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';
import 'package:my_health_assistant/src/pages/admin/widget/doctor/dialog_edit_profile_doctor.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

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
                          'Doctor',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Manage All Doctor',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        )
                      ]),
                ),
                const SizedBox(height: 20),
                StreamBuilder<List<Doctor>>(
                  stream: DashBoardFunctions.getAllDoctorAccounts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      List<Doctor> doctors = snapshot.data!;
                      List<DataRow> rows = [];
                      for (int i = 0; i < doctors.length; i++) {
                        rows.add(
                          DataRow(
                            cells: [
                              DataCell(Text(doctors[i].fullName)),
                              DataCell(Text(doctors[i].department)),
                              DataCell(Text(doctors[i].dateOfBirth.toString())),
                              DataCell(Text(doctors[i].phoneNumber)),
                              DataCell(Text(doctors[i].gender)),
                              DataCell(IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: EditDoctor(
                                        docId: doctors[i].id,
                                      ),
                                    ),
                                  );
                                },
                              )),
                            ],
                          ),
                        );
                      }
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: DataTable(columns: <DataColumn>[
                          DataColumn(
                            label: Text('Doctor Name',
                                style: MyFontStyles.blackColorH1
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text('Department',
                                style: MyFontStyles.blackColorH1
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text('Day Of Birth',
                                style: MyFontStyles.blackColorH1
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text('Phone Number',
                                style: MyFontStyles.blackColorH1
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text('Gender',
                                style: MyFontStyles.blackColorH1
                                    .copyWith(fontWeight: FontWeight.bold)),
                          ),
                          const DataColumn(
                            label: Text(''),
                          ),
                        ], rows: rows),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
