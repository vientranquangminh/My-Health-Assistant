import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/models/users/doctor.dart';
import 'package:my_health_assistant/src/views/patient/screens/home/component/container_doctor.dart';

class MyListDoctor extends StatelessWidget {
  const MyListDoctor({
    Key? key,
    required this.department,
  }) : super(key: key);
  final List<Doctor> department;
  @override
  Widget build(BuildContext context) {
    department.sort((a, b) {
      String aName = a.fullName;
      String bName = b.fullName;
      return aName.compareTo(bName);
    });
    return ListView.builder(
        itemCount: department.length,
        itemBuilder: (context, index) {
          return ContainerDoctor(
            doctorsInDepartment: department,
            index: index,
          );
        });
  }
}