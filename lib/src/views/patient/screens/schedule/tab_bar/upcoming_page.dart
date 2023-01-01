import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/reschedule_page/reschedule_page.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/tab_bar/appointment_container.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_text_button.dart';

import '../../../../../widgets/bottom_sheet/bottom_sheet_logout.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({Key? key, required this.upcoming}) : super(key: key);

  final List<Appointment> upcoming;

  @override
  Widget build(BuildContext context) {
    upcoming.sort((a, b) {
      DateTime aDate =
          DateFormat('dd-MM-yyyy HH:mm').parse('${a.date} ${a.time}');
      log(aDate.toString());
      DateTime bDate =
          DateFormat('dd-MM-yyyy HH:mm').parse('${b.date} ${b.time}');
      return aDate.compareTo(bDate);
    });

    return upcoming.isNotEmpty
        ? ListView.builder(
            itemCount: upcoming.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    AppointmentContainer(
                      color: MyColors.mainColor,
                      appointment: upcoming[index],
                      img: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          'assets/images/schedule_page/doctor.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.black45,
                          thickness: 0.2,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: MyTextButton(
                                buttonColor: MyColors.mainColor,
                                customFunction: () {
                                  _modalBottomSheetMenu(
                                      context, upcoming[index]);
                                },
                                fontSize: 13,
                                text: 'Cancel Appointment',
                                textColor: MyColors.mainColor,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              flex: 1,
                              child: MyElevatedButton(
                                buttonColor: MyColors.mainColor,
                                customFunction: () {
                                  log('current appointment ${upcoming[index]}');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ReschedulePage(currentAppointment: upcoming[index],)));
                                },
                                fontSize: 13,
                                text: 'Reschedule',
                                textColor: Colors.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
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
                  'You don\'t have a doctor\'s appointment scheduled at the moment.',
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

void _modalBottomSheetMenu(BuildContext context, Appointment appointment) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return BottomSheetLogout(
        text: 'Cancel Appointment',
        content:
            const Text('Are you sure you want to cancel your appointment?'),
        buttonText1: 'Back',
        buttonText2: 'Yes, cancel',
        function1: (() {
          Navigator.pop(context);
        }),
        function2: (() {
          Logger().e(appointment);
          Navigator.pushNamed(context, PatientRoutes.cancel,
              arguments: {'appointment': appointment});
        }),
      );
    },
  );
}
