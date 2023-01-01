import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/tab_bar/status_container.dart';

class AppointmentContainer extends StatelessWidget {
  const AppointmentContainer(
      {Key? key,
      required this.appointment,
      required this.img,
      // required this.status,
      required this.color})
      : super(key: key);
  final Appointment appointment;
  final Widget img;
  // final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(padding: const EdgeInsets.all(5), child: img),
        const SizedBox(
          width: 10,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            appointment.doctorName ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          StatusContainer(status: appointment.status ?? '', color: color),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: appointment.date,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
              children: [
                const TextSpan(
                  text: ' | ',
                ),
                TextSpan(text: appointment.time),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: const [
              Icon(
                Icons.phone,
                size: 15,
                color: Colors.black54,
              ),
              SizedBox(width: 4),
              Text(
                '0905221133',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              if (appointment.doctorGender == 'Male')
                const Icon(
                  Icons.male_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
              if (appointment.doctorGender == 'Female')
                const Icon(
                  Icons.female_outlined,
                  color: Colors.pink,
                  size: 20,
                ),
              if (appointment.doctorGender == 'Others')
                const Icon(
                  Icons.question_mark,
                  color: Colors.blue,
                  size: 20,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(appointment.doctorGender ?? '',
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
              ),
            ],
          ),
        ])
      ],
    );
  }
}
