import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Status extends StatefulWidget {
  Status({
    Key? key,
    required this.status,
    required this.getStatus,
  }) : super(key: key);
  final Function(String value) getStatus;
  String status;

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  String? dropDownValue;
  var items = [
    'Complete',
    'Upcoming',
    'Cancel',
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
          isEmpty: dropDownValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropDownValue,
              hint: Text(widget.status),
              isDense: true,
              onChanged: (value) {
                widget.getStatus(value ?? '');
                _getstatus(value);
                dropDownValue = value!;
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

  _getstatus(value) {
    if (value != null) {
      setState(() {
        widget.status = value;
      });
    }
  }
}
