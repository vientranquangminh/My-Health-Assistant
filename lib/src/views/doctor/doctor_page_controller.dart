import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/views/doctor/appointment/appointment_screen.dart';
import 'package:my_health_assistant/src/views/doctor/article/article_screen.dart';
import 'package:my_health_assistant/src/views/doctor/chat/chat_doctor_screen.dart';
import 'package:my_health_assistant/src/views/doctor/notification/notification_screen.dart';
import 'package:my_health_assistant/src/views/doctor/profile/profile_screen.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class DoctorPageController extends StatefulWidget {
  const DoctorPageController({Key? key}) : super(key: key);

  @override
  State<DoctorPageController> createState() => _DoctorPageControllerState();
}

class _DoctorPageControllerState extends State<DoctorPageController> {
  int _selectedIndex = 0;
  Color? selectedColor = MyColors.mainColor;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = [
    AppointmentScreen(),
    NotificationScreen(),
    ArticleScreen(),
    ChatDoctorScreen(),
    ProfileDoctor()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/doctor_screen/list_1.svg',
                color: MyColors.mainColor),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/doctor_screen/ringing.svg',
                color: MyColors.mainColor),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/doctor_screen/online.svg',
                color: MyColors.mainColor),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/doctor_screen/chat_1.svg',
                color: MyColors.mainColor),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/images/doctor_screen/profile-user.svg',
                color: MyColors.mainColor),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
