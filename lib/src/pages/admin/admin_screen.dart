import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/pages/admin/dashboard.dart';
import 'package:my_health_assistant/src/pages/admin/patient_screen.dart';
import 'package:my_health_assistant/src/pages/admin/topic_screen.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

import 'appointment.dart';
import 'doctor_page.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selected = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    List<Menu> menuList = [
      Menu(item: "Dasboard", icon: 'assets/images/admin/dashboard.svg'),
      Menu(item: "Patient", icon: 'assets/images/admin/patient.svg'),
      Menu(item: "Doctor", icon: 'assets/images/admin/doctor.svg'),
      Menu(item: "Article", icon: 'assets/images/admin/trending-topic.svg'),
      Menu(item: "Appointment", icon: 'assets/images/admin/trending-topic.svg'),
    ];
    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            width: 200,
            child: Column(
              children: [
                Image.asset('assets/images/picwish.png'),
                Text(
                  'My Health Assistant',
                  style: MyFontStyles.blackColorH1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _pageController.jumpToPage(index);
                              selected = index;
                            });
                          },
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(microseconds: 500),
                                width: 5,
                                height: (selected == index) ? 65 : 0,
                                color: Colors.blue,
                              ),
                              Expanded(
                                  child: Container(
                                color: (selected == index)
                                    ? Colors.blue.withOpacity(0.2)
                                    : Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        menuList[index].icon,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        menuList[index].item,
                                        style: MyFontStyles.blackColorH2,
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: menuList.length),
                ),
              ],
            ),
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: const [
              DashBoardScreen(),
              PatientPage(),
              DoctorPage(),
              TopicScreen(),
              AppointmentAdminScreen()
            ],
          ))
        ],
      ),
    );
  }
}

class Menu {
  String icon;
  String item;
  Menu({required this.item, required this.icon});
}
