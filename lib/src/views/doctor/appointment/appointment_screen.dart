import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/controllers/appointment_controller/appointment_controller.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/views/doctor/appointment/component/status_page.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.whiteText,
          elevation: 0.0,
          leading: SvgPicture.asset('assets/images/main_icon.svg',
              color: Colors.blue),
          title: const Text(
            "Appointment",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color.fromARGB(255, 55, 148, 224),
                  labelColor: const Color.fromARGB(255, 55, 148, 224),
                  unselectedLabelColor: Colors.black45,
                  labelStyle: const TextStyle(fontSize: 16),
                  tabs: const [
                    Tab(
                      text: 'Upcoming',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Cancelled',
                    )
                  ],
                ),
                StreamBuilder<List<Appointment>>(
                  stream: AppointmentController.getAllAppointment(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      List<Appointment> appointments = snapshot.data!;
                      return Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            MyListStatus(
                              status: AppointmentController
                                  .getAppointmentOfDoctorByCon(
                                      appointments, 'Upcoming'),
                              color: Colors.blue,
                            ),
                            MyListStatus(
                              status: AppointmentController
                                  .getAppointmentOfDoctorByCon(
                                      appointments, 'Completed'),
                              color: Colors.green,
                            ),
                            MyListStatus(
                              status: AppointmentController
                                  .getAppointmentOfDoctorByCon(
                                      appointments, 'Cancelled'),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
                )
              ],
            ),
          ),
        ));
  }
}
