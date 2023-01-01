import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/admin/dashboard_functions.dart';
import 'package:my_health_assistant/src/models/article/article.dart';

import 'package:my_health_assistant/src/pages/admin/widget/appbar_admin.dart';

const List<String> list = <String>[
  'All',
  'Medical',
  'Health',
  'Covid-19',
  'Lifestyle'
];

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
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
              child: StreamBuilder<List<Article>>(
                stream: DashBoardFunctions.getAllArticlesByCondition(dropdownValue),
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
                            DataCell(Text('${snapshot.data?[i].category}')),
                            DataCell(IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('articles')
                                    .doc(snapshot.data?[i].key)
                                    .delete();
                              },
                              icon:
                                  const Icon(CupertinoIcons.xmark_circle_fill),
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Manage All Article post',
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.6,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Number',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Article Title',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Created At',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Created by',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Topic',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              DashBoardFunctions.deleteAllArticlesByStatus(dropdownValue);
                              setState(() {
                                
                              });
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
                // child:
              ),
            ),
          ],
        ),
      ),
    );
  }
}
