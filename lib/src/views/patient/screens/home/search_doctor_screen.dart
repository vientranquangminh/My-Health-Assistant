import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/const_variables.dart';
import 'package:my_health_assistant/src/controllers/doctor/doctor_controller.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/views/patient/screens/home/component/my_list_doctor.dart';
import 'package:my_health_assistant/src/views/patient/screens/home/component/not_found.dart';

import 'component/title_tabbar.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({Key? key, required this.doctors}) : super(key: key);
  final List<Doctor> doctors;

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen>
    with TickerProviderStateMixin {
  List<Doctor> doctorsList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doctorsList = widget.doctors;
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 8, vsync: this);
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
          title: Text(
            'Search Doctor',
            style: MyFontStyles.blackColorH1.copyWith(fontSize: 20),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  fillColor: Colors.grey[200],
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 16.0),
                  suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/home_page/filter.svg',
                        color: MyColors.mainColor,
                      ),
                      onPressed: () {}),
                ),
                onChanged: ((value) {
                  searchDoctor(
                      value, widget.doctors); // de tam nhu vay sau nay sua lai
                }),
              ),
            ),
            SizedBox(
              height: 30,
              child: TabBar(
                controller: tabController,
                labelColor: MyColors.whiteText,
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.mainColor),
                tabs: const [
                  TabbarTitle(title: 'All'),
                  TabbarTitle(title: 'General'),
                  TabbarTitle(title: 'Dentist'),
                  TabbarTitle(title: 'Ophthalmologist'),
                  TabbarTitle(title: 'Nutritionist'),
                  TabbarTitle(title: 'Neurologist'),
                  TabbarTitle(title: 'Pediatric'),
                  TabbarTitle(title: 'Radiology'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  doctorsList.isNotEmpty
                      ? MyListDoctor(department: doctorsList)
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.general)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.general))
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.dentist)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.dentist))
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.ophthalmologist)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.ophthalmologist))
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.nutritionist)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.nutritionist))
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.neurologist)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.neurologist))
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.pediatric)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.pediatric))
                      : const NotFoundScreen(),
                  DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.radiology)
                          .isNotEmpty
                      ? MyListDoctor(
                          department: DoctorController.getDoctorByDep(
                              doctorsList, DepartmentValues.radiology))
                      : const NotFoundScreen()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchDoctor(String query, List<Doctor> doctorList) {
    final suggestions = doctorList.where((doctor) {
      final doctorName = doctor.fullName.toLowerCase();

      final searchLower = query.toLowerCase();

      return doctorName.contains(searchLower);
    }).toList();

    setState(() {
      if (query.isNotEmpty) {
        doctorsList = suggestions;
      } else {
        doctorsList = doctorList;
      }
    });
  }
}
