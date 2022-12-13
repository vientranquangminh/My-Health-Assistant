import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/data/shared_preferences.dart';
import 'package:my_health_assistant/src/pages/doctor/profile/edit_profile_doctor.dart';
import 'package:my_health_assistant/src/pages/global_var.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/services/sign_out.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/bottom_sheet/bottom_sheet_logout.dart';

final Map<String, dynamic> profileScreenData = {
  'Profile': [
    {"title": "Edit Profile", "iconUrl": "assets/images/profile/user.svg"},
    {
      "title": "Notification",
      "iconUrl": "assets/images/profile/icon _bell_.svg"
    },
    {"title": "Payment", "iconUrl": "assets/images/profile/credit-card.svg"},
    {"title": "Security", "iconUrl": "assets/images/profile/shield-check.svg"},
    {"title": "Language", "iconUrl": "assets/images/profile/language.svg"},
    {"title": "Dark Mode", "iconUrl": "assets/images/profile/eye.svg"},
    {
      "title": "Help Center",
      "iconUrl": "assets/images/profile/information-circle.svg"
    },
    {"title": "Invite Friends", "iconUrl": "assets/images/profile/users.svg"},
  ]
};

class ProfileDoctor extends StatelessWidget {
  const ProfileDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = FirebaseFirestore.instance
        .collection("doctors")
        .doc(auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.whiteText,
        elevation: 0.0,
        leading:
            SvgPicture.asset('assets/images/main_icon.svg', color: Colors.blue),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/profile/avatar.jpg"),
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: doctor,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(snapshot.data?.get('fullName'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20)),
                  );
                }),
              ),
              const SizedBox(height: 4),
              StreamBuilder<DocumentSnapshot>(
                stream: doctor,
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20));
                  }
                  return Text(
                    snapshot.data?.get('phoneNumber'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey.shade700),
                  );
                }),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: profileScreenData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      expansionTileCustom(
                          index, profileScreenData.keys.toList(), context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return BottomSheetLogout(
                                    text: 'Log out',
                                    content: const Text(
                                        'Are you sure you want to logout?'),
                                    buttonText1: 'Cancel',
                                    buttonText2: 'Logout',
                                    function1: (() {
                                      log('cancel');
                                      Navigator.pop(context);
                                    }),
                                    function2: (() {
                                      log('Logout');
                                      SignOut.signOut();
                                      SharedPrefs.isLoggedOut();
                                      SharedPrefs.removeUid();
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              CommonRoutes.startApp));
                                    }),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/profile/logout.svg'),
                                const SizedBox(width: 8),
                                const Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      )
                    ],
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Theme expansionTileCustom(int type, List keys, BuildContext context) {
    List maps = profileScreenData[keys[type]];
    return Theme(
      data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
          ),
          dividerColor: Colors.transparent),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: maps.length,
        itemBuilder: (context, index) {
          final item = maps[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: InkWell(
              onTap: () {
                _onTap(context, item);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(maps[index]['iconUrl']),
                        const SizedBox(width: 8),
                        Text(
                          maps[index]['title'],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 7, 3, 3),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }
}

_onTap(BuildContext context, item) {
  switch (item['title']) {
    case 'Edit Profile':
      return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfileDoctor(),
          ));
    case 'Notification':
      return log('Notification');
    case 'Payment':
      return log('Payment');
    case 'Security':
      return log('Security');
    case 'Language':
      return log('Language');
    case 'Dark Mode':
      return log('Dark Mode');
    case 'Help Center':
      return log('Help Center');
    case 'Invite Friends':
      return log('Invite Friends');
    default:
  }
}
