import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:my_health_assistant/src/models/profile_model/notification_model.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class NotificationInProfile extends StatefulWidget {
  const NotificationInProfile({Key? key}) : super(key: key);

  @override
  State<NotificationInProfile> createState() => _NotificationInProfileState();
}

class _NotificationInProfileState extends State<NotificationInProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Notification'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listNotification[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  FlutterSwitch(
                      padding: 1,
                      width: 35.0,
                      height: 17.0,
                      toggleSize: 16.5,
                      activeColor: MyColors.mainColor,
                      value: listNotification[index].status,
                      onToggle: (val) {
                        setState(() {
                          listNotification[index].status = val;
                        });
                      }),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: listNotification.length),
      ),
    );
  }
}
