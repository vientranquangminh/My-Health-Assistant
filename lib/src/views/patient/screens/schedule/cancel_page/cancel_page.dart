import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/controllers/appointment_controller/appointment_controller.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/reschedule_page/my_radio_list_tile.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';
import 'package:my_health_assistant/src/widgets/my_dialog.dart';

class CancelPage extends StatefulWidget {
  const CancelPage({super.key});

  @override
  State<CancelPage> createState() => _CancelPageState();
}

class _CancelPageState extends State<CancelPage> {
  String reason = 'I want to change another doctor';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    List<String> cancelReason = [
      'I want to change another doctor',
      'I want to change package',
      'I don\'t want to consult',
      'I have recovered from disease',
      'I have found suitable medicine',
      'I just want to cancel',
      'I don\'t want to tell',
      'Others',
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(title: 'Cancel Appointment'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    reasons: cancelReason,
                    getReason: (value) => _getText(value),
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
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: MyElevatedButton(
                      text: 'Submit',
                      buttonColor: MyColors.mainColor,
                      customFunction: () {
                        AppointmentController.cancelAppointment(
                            arguments['appointment'].id, reason);
                        showMyDialog(
                          context,
                          MyColors.mainColor,
                          size,
                          'Cancel Appointment',
                          'We are very sad that you have canceled your appointment. We will always improve our service to satisfy you in the next appointment',
                          'assets/images/schedule_page/cancel.png',
                        );
                        log('cancel: ----------- $reason ------------');
                      },
                      fontSize: 16,
                      textColor: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getText(String value) {
    reason = value;
  }
}
