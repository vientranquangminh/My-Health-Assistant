import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/pages/patient/screens/home/component/my_list_doctor.dart';

import 'package:my_health_assistant/src/pages/patient/screens/home/component/doctor_object.dart';
import 'package:my_health_assistant/src/pages/patient/screens/home/component/not_found.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'component/title_tabbar.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({Key? key}) : super(key: key);

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen>
    with TickerProviderStateMixin {
  List<DoctorObject> doctors = listDoctor;
  List<DoctorObject> general =
      listDoctor.where((element) => element.department == 'General').toList();
  List<DoctorObject> dentist =
      listDoctor.where((element) => element.department == 'Dentist').toList();
  List<DoctorObject> ophthalmologist = listDoctor
      .where((element) => element.department == 'Ophthalmologist')
      .toList();
  List<DoctorObject> nutritionist = listDoctor
      .where((element) => element.department == 'Nutritionist')
      .toList();
  List<DoctorObject> neurologist = listDoctor
      .where((element) => element.department == 'Neurologist')
      .toList();
  List<DoctorObject> pediatric =
      listDoctor.where((element) => element.department == 'Pediatric').toList();
  List<DoctorObject> radiology =
      listDoctor.where((element) => element.department == 'Radiology').toList();
  final TextEditingController _searchController = TextEditingController();

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
                  onChanged: searchDoctor
                  // onChanged: (value) {
                  //   searchDoctor(_searchController.text, listDoctor);
                  // },
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
                  doctors.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: doctors),
                  general.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: general),
                  dentist.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: dentist),
                  ophthalmologist.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: ophthalmologist),
                  nutritionist.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: nutritionist),
                  neurologist.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: neurologist),
                  pediatric.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: pediatric),
                  radiology.isEmpty
                      ? const NotFoundScreen()
                      : MyListDoctor(department: radiology)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void searchDoctor(String query, List<DoctorObject> doctorList) {
  //   final suggestions = doctorList.where((doctor) {
  //     final doctorName = doctor.doctorName.toLowerCase();

  //     final searchLower = query.toLowerCase();

  //     return doctorName.contains(searchLower);
  //   }).toList();

  //   setState(() {
  //     if (query.isNotEmpty) {
  //       doctors = suggestions;
  //     } else {
  //       doctors = doctorList;
  //     }
  //   });
  // }
  void searchDoctor(String query) {
    final all = compareDoctorName(query, listDoctor).toList();
    final generalSearch = compareDoctorName(query, general).toList();
    final dentistSearch = compareDoctorName(query, dentist).toList();
    final ophthalmologistSearch =
        compareDoctorName(query, ophthalmologist).toList();
    final nutritionistSearch = compareDoctorName(query, nutritionist).toList();
    final neurologistSearch = compareDoctorName(query, neurologist).toList();
    final pediatricSearch = compareDoctorName(query, pediatric).toList();
    final radiologySearch = compareDoctorName(query, radiology).toList();
    setState(() {
      if (query.isNotEmpty) {
        doctors = all;
        general = generalSearch;
        dentist = dentistSearch;
        ophthalmologist = ophthalmologistSearch;
        nutritionist = nutritionistSearch;
        neurologist = neurologistSearch;
        pediatric = pediatricSearch;
        radiology = radiologySearch;
      } else {
        doctors = listDoctor;
        general = listDoctor
            .where((element) => element.department == 'General')
            .toList();

        dentist = listDoctor
            .where((element) => element.department == 'Dentist')
            .toList();

        ophthalmologist = listDoctor
            .where((element) => element.department == 'Ophthalmologist')
            .toList();
        nutritionist = listDoctor
            .where((element) => element.department == 'Nutritionist')
            .toList();
        pediatric = listDoctor
            .where((element) => element.department == 'Pediatric')
            .toList();
        radiology = radiology = listDoctor
            .where((element) => element.department == 'Radiology')
            .toList();
        ;
      }
    });
  }

  // ignore: non_constant_identifier_names
  Iterable<DoctorObject> compareDoctorName(
      String query, List<DoctorObject> list) {
    return list.where((doctor) {
      final doctorName = doctor.doctorName.toLowerCase();

      final searchLower = query.toLowerCase();

      return doctorName.contains(searchLower);
    });
  }
}
