import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDateOfBirthAdmin extends StatefulWidget {
  const EditDateOfBirthAdmin({Key? key, required this.dateInput})
      : super(key: key);

  @override
  State<EditDateOfBirthAdmin> createState() => _EditDateOfBirthAdminState();
  final TextEditingController dateInput;
}

class _EditDateOfBirthAdminState extends State<EditDateOfBirthAdmin> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.dateInput,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: 'Date Of Birth',
        // hintText: DateFormat("dd-MM-yyyy").parse(widget.date).toIso8601String(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(
          Icons.calendar_month,
          color: Colors.grey,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Can not be empty';
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100));
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            widget.dateInput.text = formattedDate;
          });
        }
      },
    );
  }
}