
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/tab_bar/appointment_container.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class CancelledPage extends StatelessWidget {
  const CancelledPage({Key? key, required this.cancelled}) : super(key: key);

  final List<Appointment> cancelled;

  @override
  Widget build(BuildContext context) {
    cancelled.sort((a, b) {
      DateTime aDate =
          DateFormat('yyyy-MM-dd HH:mm').parse('${a.date} ${a.time}');
      DateTime bDate =
          DateFormat('yyyy-MM-dd HH:mm').parse('${b.date} ${b.time}');
      return aDate.compareTo(bDate);
    });

    return cancelled.isNotEmpty
        ? ListView.builder(
            itemCount: cancelled.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: AppointmentContainer(
                  color: MyColors.cancelStatus,
                  // status: 'Cancelled',
                  appointment: cancelled[index],
                  img: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/schedule_page/doctor.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
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