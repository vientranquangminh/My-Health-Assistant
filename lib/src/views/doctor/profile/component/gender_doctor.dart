import 'package:flutter/material.dart';

class GenderDoctor extends StatefulWidget {
  const GenderDoctor({Key? key}) : super(key: key);

  @override
  State<GenderDoctor> createState() => _GenderDoctorState();
}

class _GenderDoctorState extends State<GenderDoctor> {
  String dropdownvalue = 'Male';
  var items = [
    'Male',
    'Female',
    'Others',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          isEmpty: dropdownvalue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownvalue,
              isDense: true,
              onChanged: null,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )),
    );
  }
}
