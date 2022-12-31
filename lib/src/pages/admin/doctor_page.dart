import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';
import 'package:my_health_assistant/src/pages/admin/widget/doctor/dialog_edit_profile_doctor.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.lightBlue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.person_add,
                              color: MyColors.mainColor,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Add New Account Doctor',
                              style: MyFontStyles.mainColorH4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                                DataCell(IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.xmark_circle_fill,
                                    size: 18,
                                  ),
                                  onPressed: () {},
                                )),
                              ],
                            ),
                          );
                        }
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
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
                              const DataColumn(
                                label: Text(''),
                              ),
                            ], rows: rows),
                          ),
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
      ),
    );
  }
}
