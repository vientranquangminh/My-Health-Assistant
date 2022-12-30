import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/article/article.dart';

import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({Key? key}) : super(key: key);

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
            child: StreamBuilder<List<Article>>(
              stream: DashBoardFunctions.getAllArticles(),
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
                  List<DataRow> cells = [];
                  int length = snapshot.data?.length ?? 0;
                  for (int i = 0; i < length; i++) {
                    cells.add(
                      DataRow(
                        cells: [
                          DataCell(Text('$i')),
                          DataCell(Text('${snapshot.data?[i].title}')),
                          DataCell(Text('${snapshot.data?[i].time}')),
                          DataCell(Text('${snapshot.data?[i].doctorName}')),
                          DataCell(IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('articles')
                                  .doc(snapshot.data?[i].key)
                                  .delete();
                            },
                            icon: const Icon(CupertinoIcons.xmark_circle_fill),
                            iconSize: 18,
                          )),
                        ],
                      ),
                    );
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
                                'Article',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Manage All Article post',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Number',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Article Title',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Created At',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Created by',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  '',
                                ),
                              ),
                            ),
                          ], rows: cells),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
              // child:
            ),
          ),
        ],
      ),
    );
  }
}
