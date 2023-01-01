import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/controllers/appointment_controller/appointment_controller.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/app_toast/app_toast.dart';

class MyListStatus extends StatelessWidget {
  const MyListStatus({Key? key, required this.status, required this.color})
      : super(key: key);
  final List<Appointment> status;
  final Color color;
  @override
  Widget build(BuildContext context) {
    status.sort((a, b) {
      DateTime aDate =
          DateFormat('dd-MM-yyyy HH:mm').parse('${a.date} ${a.time}');
      log(aDate.toString());
      DateTime bDate =
          DateFormat('dd-MM-yyyy HH:mm').parse('${b.date} ${b.time}');
      return aDate.compareTo(bDate);
    });
    Logger().i('appointment of doctor $status');
    return status.isNotEmpty
        ? ScreenUtilInit(
            designSize: const Size(428, 884),
            builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                itemCount: status.length,
                itemBuilder: (context, index) {
                  final patient = FirebaseFirestore.instance
                      .collection("patients")
                      .doc(status[index].patientId)
                      .snapshots();
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0).r,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Image.asset(
                                  'assets/images/schedule_page/doctor.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0).r,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: patient,
                                      builder: ((context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text(
                                            "Loading...",
                                            style: MyFontStyles.blackColorH1,
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.get('fullName'),
                                            style: MyFontStyles.blackColorH2,
                                          );
                                        }
                                        return Container();
                                      }),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(color: color)),
                                      child: Padding(
                                        padding: EdgeInsets.all(6.w),
                                        child: Text(
                                          status[index].status ?? '',
                                          style: TextStyle(
                                              color: color, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    RichText(
                                      text: TextSpan(
                                        text: status[index].date,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                        children: [
                                          const TextSpan(
                                            text: ' | ',
                                          ),
                                          TextSpan(
                                            text: status[index].time,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 15,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(width: 4.w),
                                        const Text(
                                          '0905221133',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.9,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              if (status[index].patientGender ==
                                                  'Male')
                                                const Icon(
                                                  Icons.male_outlined,
                                                  color: Colors.blue,
                                                  size: 20,
                                                ),
                                              if (status[index].patientGender ==
                                                  'Female')
                                                const Icon(
                                                  Icons.female_outlined,
                                                  color: Colors.pink,
                                                  size: 20,
                                                ),
                                              if (status[index].patientGender ==
                                                  'Others')
                                                const Icon(
                                                  Icons.question_mark,
                                                  color: Colors.blue,
                                                  size: 20,
                                                ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: Text(
                                                    status[index]
                                                            .patientGender ??
                                                        '',
                                                    style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12)),
                                              ),
                                            ],
                                          ),
                                          if (status[index].status ==
                                              'Upcoming')
                                            SizedBox(
                                              height: 30.h,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          MyColors.mainColor),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  AppointmentController
                                                      .completeAppointment(
                                                          status[index].id ??
                                                              '');
                                                  AppToasts.showToast(
                                                    context: context,
                                                    title:
                                                        'Appointment has been completed',
                                                  );
                                                },
                                                child: const Text(
                                                  'Complete',
                                                  style:
                                                      MyFontStyles.whiteColorH4,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'You don\'t have an appointment yet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'You don\'t have a patient\'s appointment scheduled at the moment.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
  }
}
