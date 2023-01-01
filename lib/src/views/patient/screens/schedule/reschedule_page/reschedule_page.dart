import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/controllers/appointment_controller/appointment_controller.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/reschedule_page/my_radio_list_tile.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/reschedule_page/reschedule_select_date_time.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class ReschedulePage extends StatefulWidget {
  const ReschedulePage({super.key, required this.currentAppointment});
  final Appointment currentAppointment;

  @override
  State<ReschedulePage> createState() => _ReschedulePageState();
}

class _ReschedulePageState extends State<ReschedulePage> {
  String reason = '';

  @override
  Widget build(BuildContext context) {
    List<String> rescheduleReasons = [
      'I\'m having a schedule clash',
      'I\'m not available on schedule',
      'I have an activity that can\'t left behind',
      'I don\'t want to tell',
      'Others',
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Reschedule Appointment'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Reason for Schedule Change',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  MyRadioListTile(
                    reasons: rescheduleReasons,
                    getReason: (value) => _getReason(value),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text(
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with:',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
              Center(
                child: StreamBuilder<List<Appointment>>(
                  stream: AppointmentController.getAllAppointment(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      List<Appointment> allAppointments = snapshot.data!;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: MyElevatedButton(
                          text: 'Next',
                          buttonColor: MyColors.mainColor,
                          customFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RescheduleSelectDateTime(
                                  currentAppointment: widget.currentAppointment,
                                  appointments: AppointmentController
                                      .getAllUpComingAppointment(
                                    allAppointments,
                                    widget.currentAppointment.doctorId ?? '',
                                  ),
                                ),
                              ),
                            );

                            Logger().i(
                                'all appointment length: ${AppointmentController.getAllUpComingAppointment(
                              allAppointments,
                              widget.currentAppointment.id ?? '',
                            )}');
                          },
                          fontSize: 16,
                          textColor: Colors.white,
                        ),
                      );
                    }
                    return Container();
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getReason(String value) {
    reason = value;
  }
}
