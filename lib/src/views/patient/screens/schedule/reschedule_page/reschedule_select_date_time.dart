import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/controllers/appointment_controller/appointment_controller.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';
import 'package:my_health_assistant/src/widgets/my_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'my_custom_gridview_hours.dart';

class RescheduleSelectDateTime extends StatefulWidget {
  const RescheduleSelectDateTime(
      {Key? key, required this.currentAppointment, required this.appointments})
      : super(key: key);
  final Appointment currentAppointment;
  final List<Appointment> appointments;

  @override
  State<RescheduleSelectDateTime> createState() =>
      _RescheduleSelectDateTimeState();
}

class _RescheduleSelectDateTimeState extends State<RescheduleSelectDateTime> {
  @override
  void initState() {
    super.initState();
    log('check appointment: ${widget.appointments}');
  }

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String status = 'Upcoming';

  List<String> times = [
    '01:00',
    '01:30',
    '04:00',
    '05:00',
    '06:00',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
  ];

  String time = '${DateTime.now().hour}:${DateTime.now().minute}';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log('default Time: $time');
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;
    Color mainColor = const Color.fromARGB(255, 0, 106, 192);
    return Scaffold(
        appBar: CustomAppBar(title: 'Reschedule Appointment'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: SfDateRangePicker(
                        todayHighlightColor: mainColor,
                        selectionColor: mainColor,
                        navigationMode: DateRangePickerNavigationMode.none,
                        backgroundColor: Colors.blue[50],
                        enablePastDates: false,
                        view: DateRangePickerView.month,
                        showNavigationArrow: true,
                        onSelectionChanged:
                            (dateRangePickerSelectionChangedArgs) {
                          setState(() {
                            date = DateFormat('yyyy-MM-dd').format(
                                dateRangePickerSelectionChangedArgs.value);
                            log('date: date: date: $date');
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Select Hour',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomGridViewHours(
                        times: times,
                        getTime: (value) => _getTime(value),
                        date: date,
                        appointmentOfDoctor: AppointmentController
                            .getAppointmentsOfSpecificDoctorByDate(
                                widget.appointments,
                                DateFormat('dd-MM-yyyy')
                                    .format(DateTime.parse(date))))
                  ],
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: MyElevatedButton(
                      buttonColor: mainColor,
                      customFunction: () {
                        DateTime dt = DateTime.parse(date);
                        String fDate = DateFormat('dd-MM-yyyy').format(dt);
                        AppointmentController.updateAppointment(
                            widget.currentAppointment.id ?? '', fDate, time);
                        showMyDialog(
                          context,
                          mainColor,
                          size,
                          'Reschedule Success',
                          'Appointment successfully changed. You will receive a notification and the doctor you selected will contact you.',
                          'assets/images/schedule_page/schedule.png',
                        );
                      },
                      fontSize: 16,
                      text: 'Submit',
                      textColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  String _getTime(String value) {
    time = value;
    return time;
  }
}
