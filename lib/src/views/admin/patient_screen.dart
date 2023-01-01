import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/controllers/patient/patient_controller.dart';
import 'package:my_health_assistant/src/models/users/patient.dart';
import 'package:my_health_assistant/src/views/admin/widget/appbar_admin.dart';
import 'package:my_health_assistant/src/views/admin/widget/patient/dialog_edit_profile_patient.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({Key? key}) : super(key: key);

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
                          'Patient',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Manage All Patient',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        )
                      ]),
                ),
                const SizedBox(height: 20),
                StreamBuilder<List<Patient>>(
                  stream: PatientController.getAllPatients(),
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
                      List<Patient> patients = snapshot.data!;
                      List<DataRow> rows = [];
                      for (int i = 0; i < patients.length; i++) {
                        rows.add(
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(patients[i].fullName)),
                              DataCell(Text(patients[i].nickname)),
                              DataCell(
                                  Text(patients[i].dateOfBirth.toString())),
                              DataCell(Text(patients[i].phoneNumber)),
                              DataCell(Text(patients[i].gender)),
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
                                      child: EditPatient(
                                        patientId: patients[i].id,
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(columns: <DataColumn>[
                            DataColumn(
                              label: Text('Patient Name',
                                  style: MyFontStyles.blackColorH1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            DataColumn(
                              label: Text('Nick Name',
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
    );
  }
}
