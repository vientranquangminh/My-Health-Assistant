import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import '../views/patient/screens/articles/articles_page.dart';
import '../views/patient/screens/history/history_page.dart';
import '../views/patient/screens/profile/profile_page.dart';
import '../views/patient/screens/schedule/appointment_page.dart';
import '../views/patient/screens/home/home_page.dart';

class MyPageController extends StatefulWidget {
  const MyPageController({Key? key}) : super(key: key);

  @override
  State<MyPageController> createState() => _MyPageControllerState();
}

class _MyPageControllerState extends State<MyPageController> {
  int _selectedIndex = 0;
  Color? selectedColor = MyColors.mainColor;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = [
    HomePage(),
    AppointmentPage(),
    HistoryPage(),
    ArticlePage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/images/bottom_navigation_bar/home.svg',
                color: MyColors.mainColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/images/bottom_navigation_bar/schedule.svg',
                color: MyColors.mainColor),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/images/bottom_navigation_bar/history.svg',
                color: MyColors.mainColor),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/images/bottom_navigation_bar/article.svg',
                color: MyColors.mainColor),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/images/bottom_navigation_bar/user.svg',
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
