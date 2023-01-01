import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/models/users/patient.dart';
import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  static List<charts.Series<BarModel, String>> _createChart(
      int admin, int doctor, int patient, int article) {
    final data = [
      BarModel(title: 'Account Admin', value: admin),
      BarModel(title: 'Account Doctor', value: doctor),
      BarModel(title: 'Account Patient', value: patient),
      BarModel(title: 'Article', value: article),
    ];
    return [
      charts.Series<BarModel, String>(
        data: data,
        id: 'Sum',
        colorFn: (datum, index) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (BarModel barModel, _) => barModel.title,
        measureFn: (BarModel barModel, _) => barModel.value,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    int doctorAccounts = 0;
    int adminAccounts = 1;
    int patientAccounts = 0;
    int articles = 0;
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarAdmin(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: StreamBuilder<List<Article>>(
                stream: DashBoardFunctions.getAllArticles(),
                builder: (context, snapshotArticle) {
                  return StreamBuilder<List<Patient>>(
                    stream: DashBoardFunctions.getAllPatientAccounts(),
                    builder: (context, snapshotPatient) {
                      return StreamBuilder<List<Doctor>>(
                        stream: DashBoardFunctions.getAllDoctorAccounts(),
                        builder: (context, snapshotDoctor) {
                          if (snapshotArticle.hasError ||
                              snapshotPatient.hasError ||
                              snapshotPatient.hasError) {
                            return Text(
                                'Something went wrong - article: ${snapshotArticle.error} - patients: ${snapshotPatient.error} - doctor: ${snapshotDoctor.error}');
                          }
                          if (snapshotArticle.connectionState ==
                                  ConnectionState.waiting ||
                              snapshotPatient.connectionState ==
                                  ConnectionState.waiting ||
                              snapshotDoctor.connectionState ==
                                  ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshotArticle.hasData &&
                              snapshotDoctor.hasData &&
                              snapshotPatient.hasData) {
                            patientAccounts = snapshotPatient.data?.length ?? 0;
                            doctorAccounts = snapshotDoctor.data?.length ?? 0;
                            articles = snapshotArticle.data?.length ?? 0;
                            List<DataRow> cells = [];
                            for (int i = 0; i < articles; i++) {
                              cells.add(DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('$i')),
                                  DataCell(Text(
                                      '${snapshotArticle.data?[i].title}')),
                                  DataCell(
                                      Text('${snapshotArticle.data?[i].time}')),
                                ],
                              ));
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'DashBoard',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ContainerDashBoard(
                                      title: 'Admin account',
                                      number: '1',
                                      icon: 'assets/images/admin/profile.svg',
                                    ),
                                    ContainerDashBoard(
                                      title: 'Patient account',
                                      number: '$patientAccounts',
                                      icon: 'assets/images/admin/patient.svg',
                                    ),
                                    ContainerDashBoard(
                                      title: 'Doctor account',
                                      number: '$doctorAccounts',
                                      icon: 'assets/images/admin/doctor.svg',
                                    ),
                                    ContainerDashBoard(
                                      title: 'Article',
                                      number: '$articles',
                                      icon:
                                          'assets/images/admin/trending-topic.svg',
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 10.0),
                                  child: Text(
                                    'Statistics',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: charts.BarChart(
                                      _createChart(
                                          adminAccounts,
                                          doctorAccounts,
                                          patientAccounts,
                                          articles),
                                      animate: true,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 10.0),
                                  child: Text(
                                    'Recent Article',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  width: double.infinity,
                                  child: DataTable(
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Number',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Article Title',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Created At',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
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
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerDashBoard extends StatelessWidget {
  const ContainerDashBoard({
    Key? key,
    required this.title,
    required this.number,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String number;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Numer of \n$title',
                    style: MyFontStyles.normalBlackText
                        .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                  number,
                  style: MyFontStyles.blackColorH1
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            SvgPicture.asset(
              icon,
              width: 60,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class BarModel {
  final String title;
  final int value;
  BarModel({required this.title, required this.value});
}
