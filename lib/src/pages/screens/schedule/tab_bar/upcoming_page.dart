import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/screens/schedule/appointment.dart';
import 'package:my_health_assistant/src/pages/screens/schedule/tab_bar/appointment_container.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_text_button.dart';

import '../../../../widgets/bottom_sheet/bottom_sheet_logout.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({Key? key, required this.upcoming}) : super(key: key);

  final List<Appointment> upcoming;

  @override
  Widget build(BuildContext context) {
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
                      status: 'Upcoming',
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
                                  _modalBottomSheetMenu(context);
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
                                  log('Reschedule');
                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const ReschedulePage()));
                                  Navigator.pushNamed(context, MyRoutes.reschedule);
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

void _modalBottomSheetMenu(BuildContext context) {
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
        content: const Text('Are you sure you want to cancel your appointment?'),
        buttonText1: 'Back',
        buttonText2: 'Yes, cancel',
        function1: (() {
          Navigator.pop(context);
        }),
        function2: ((){
          Navigator.pushNamed(context, MyRoutes.cancel);
        }),
      );
    },
  );
}
