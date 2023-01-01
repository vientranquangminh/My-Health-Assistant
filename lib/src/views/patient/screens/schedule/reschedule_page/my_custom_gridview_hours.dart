import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/models/appointment/appointment.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

import 'custom_time_container.dart';

class MyCustomGridViewHours extends StatefulWidget {
  const MyCustomGridViewHours(
      {Key? key,
      required this.times,
      required this.getTime,
      required this.date,
      required this.appointmentOfDoctor})
      : super(key: key);
  final List<String> times;
  final Function(String value) getTime;
  final String date;
  final List<Appointment> appointmentOfDoctor;

  @override
  State<MyCustomGridViewHours> createState() => _MyCustomGridViewHoursState();
}

class _MyCustomGridViewHoursState extends State<MyCustomGridViewHours> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // temp = widget.times;
    handlePastDate();
    Logger().d('All appointment custom grid: ${widget.appointmentOfDoctor}');
    Logger()
        .d('All appointment custom grid: ${widget.appointmentOfDoctor.length}');
  }

  List<String> handlePastDate() {
    // temp = widget.times;
    List<String> result = [];
    DateTime dt = DateTime.now();
    String day = dt.day < 10 ? '0${dt.day}' : dt.day.toString();
    String month = dt.month < 10 ? '0${dt.month}' : dt.month.toString();
    String year = dt.year < 10 ? '0${dt.year}' : dt.year.toString();
    String hour = dt.hour < 10 ? '0${dt.hour}' : dt.hour.toString();
    String minute = dt.minute < 10 ? '0${dt.minute}' : dt.minute.toString();

    String now = '$year-$month-$day $hour:$minute';
    // log('now: $now');

    for (int i = 0; i < widget.times.length; i++) {
      String selection = '${widget.date} ${widget.times[i]}';
      // log('selection: $selection');
      print('Compare: ------ ${selection.compareTo(now)}');
      if (selection.compareTo(now) > 0) {
        // print('$i - ${widget.times[i]}');
        // widget.times.removeAt(i);
        result.add(widget.times[i]);
      }
    }
    // print(temp);
    return result;
  }

  List<String> getupComingDateTime() {
    log('widget.appointmentOfDoctor: ${widget.appointmentOfDoctor}');
    List<String> result = [];
    for (var element in widget.appointmentOfDoctor) {
      result.add('${element.time}');
    }
    print('result: $result');
    return result;
  }

  List<String> handleConflictingDate() {
    List<String> removePastDate = handlePastDate();
    // log('PAST DATE: $removePastDate');
    List<String> upcomingDateTime = getupComingDateTime();
    // log('UPCOMING DATE: $upcomingDateTime');
    removePastDate.removeWhere((element) => upcomingDateTime.contains(element));
    // log('final list: $removePastDate');
    return removePastDate;
  }

  @override
  Widget build(BuildContext context) {
    Logger().v('Check appointments: ${widget.appointmentOfDoctor}');
    Logger()
        .v('Check appointments length: ${widget.appointmentOfDoctor.length}');
    List<String> result = handleConflictingDate();
    // log(handleConflictingDate().toString());
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: (3)),
        itemCount: result.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // log('${widget.date} - ${widget.times[index]}');
              // log('${widget.appointmentOfDoctor}');
              setState(() {
                selectedIndex = index;
              });
              widget.getTime(result[index]);
            },
            child: CustomTimeContainer(
              hour: result[index],
              buttonColor: selectedIndex == index
                  ? MyColors.mainColor
                  : MyColors.whiteText,
              textColor: selectedIndex == index
                  ? MyColors.whiteText
                  : MyColors.mainColor,
            ),
          );
        });
  }
}
