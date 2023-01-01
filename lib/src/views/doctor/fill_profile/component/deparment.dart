import 'package:flutter/material.dart';

class FillProfileDeparment extends StatefulWidget {
  final Function(String value) onChanged;
  const FillProfileDeparment({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FillProfileDeparment> createState() => _FillProfileDeparmentState();
}

class _FillProfileDeparmentState extends State<FillProfileDeparment> {
  String? dropdownvalue;
  var items = [
    'General',
    'Dentist',
    'Ophthalmologist',
    'Nutritionist',
    'Neurologist',
    'Pediatric',
    'Radiology'
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
              hint: const Text('Department'),
              isDense: true,
              onChanged: (value) {
                widget.onChanged(value ?? '');
                dropdownvalue = value!;
              },
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
