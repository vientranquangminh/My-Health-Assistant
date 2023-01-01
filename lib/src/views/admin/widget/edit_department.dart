import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditDepartment extends StatefulWidget {
  EditDepartment({
    Key? key,
    required this.getText,
    required this.deparment,
  }) : super(key: key);

  @override
  State<EditDepartment> createState() => _EditDepartmentState();
  final Function(String value) getText;
  String deparment;
}

class _EditDepartmentState extends State<EditDepartment> {
  String? dropDownValue;
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
    return InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        isEmpty: dropDownValue == '',
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(widget.deparment),
            value: dropDownValue,
            isDense: true,
            onChanged: (value) {
              widget.getText(value ?? '');
              _getDepartment(value);
              dropDownValue = value!;
            },
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  _getDepartment(value) {
    if (value != null) {
      setState(() {
        widget.deparment = value;
      });
    }
  }
}
