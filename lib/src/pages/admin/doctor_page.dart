import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';
import 'package:my_health_assistant/src/pages/admin/widget/doctor/dialog_edit_profile_doctor.dart';
import 'package:my_health_assistant/src/pages/admin/widget/doctor/doctor_object.dart';
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
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: DataTable(
                    columns: <DataColumn>[
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
                        label: Text('Email',
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
                    ],
                    rows:
                        List<DataRow>.generate(listDoctor.length, (int index) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(listDoctor[index].name)),
                          DataCell(Text(listDoctor[index].department)),
                          DataCell(Text(listDoctor[index].email)),
                          DataCell(Text(listDoctor[index].dayOfBirth)),
                          DataCell(Text(listDoctor[index].phone)),
                          DataCell(Text(listDoctor[index].gender)),
                          DataCell(IconButton(
                            icon: const Icon(Icons.edit,size: 18,),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: EditDoctor(),
                                ),
                              );
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
