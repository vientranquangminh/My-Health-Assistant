import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_text_button.dart';

import 'appointment_container.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({Key? key, required this.completed}) : super(key: key);

  final List<Appointment> completed;

  @override
  Widget build(BuildContext context) {

    completed.sort((a, b) {
      DateTime aDate =
          DateFormat('yyyy-MM-dd HH:mm').parse('${a.date} ${a.time}');
      DateTime bDate =
          DateFormat('yyyy-MM-dd HH:mm').parse('${b.date} ${b.time}');
      return aDate.compareTo(bDate);
    });

    return completed.isNotEmpty ? ListView.builder(
      itemCount: completed.length,
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
                  color: MyColors.completedStatus,
                  appointment: completed[index],
                  img: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
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
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyTextButton(
                          buttonColor: MyColors.mainColor,
                          customFunction: (() {
                            log('Book again');
                            Navigator.pushNamed(context, PatientRoutes.selectDate);
                          }),
                          fontSize: 13,
                          text: 'Book again',
                          textColor: MyColors.mainColor,
                        )
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: MyElevatedButton(
                          buttonColor: MyColors.mainColor,
                          customFunction: (() => log('message')),
                          fontSize: 13,
                          text: 'Leave a review',
                          textColor: MyColors.whiteText,
                        )
                      )
                    ],
                  ),
                )
              ],
            ));
      },
    ) : SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('You don\'t have an appointment yet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),),
            Text('You don\'t have a doctor\'s appointment scheduled at the moment.',
            style: TextStyle(fontSize: 14,), textAlign: TextAlign.center,)
          ],
        ),
    );
  }
}
