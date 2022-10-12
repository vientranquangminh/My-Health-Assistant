import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/screens/schedule/reschedule_page/my_radio_list_tile.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class CancelPage extends StatelessWidget {
  const CancelPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
                    ),
                  ),
                  MyRadioListTile(reasons: cancelReason),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: MyElevatedButton(
                      text: 'Submit',
                      buttonColor: MyColors.mainColor,
                      customFunction: () {
                        showMyDialog(context, MyColors.mainColor, size);
                        log('Submitted');
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
}

void showMyDialog(BuildContext context, Color mainColor, Size size) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Text(
          'Cancel Appointment Success',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: const Text(
            'We are very sad that you have canceled your appointment. We will always improve our service to satisfy you in the next appointment',
            style: TextStyle(fontSize: 15)),
        actions: <Widget>[
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: size.width - 40,
              height: 40,
              child: MyElevatedButton(
                buttonColor: mainColor,
                customFunction: () => Navigator.popUntil(
                    context, ModalRoute.withName(MyRoutes.pageController)),
                fontSize: 16,
                text: 'OK',
                textColor: Colors.white,
              ))
        ],
      ),
    ),
  );
}