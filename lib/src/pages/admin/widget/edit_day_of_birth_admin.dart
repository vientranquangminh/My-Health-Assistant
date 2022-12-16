import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDateOfBirthAdmin extends StatefulWidget {
  const EditDateOfBirthAdmin({Key? key, required this.dateInput, required this.date})
      : super(key: key);

  @override
  State<EditDateOfBirthAdmin> createState() => _EditDateOfBirthAdminState();
  final TextEditingController dateInput;
  final String date;
}

class _EditDateOfBirthAdminState extends State<EditDateOfBirthAdmin> {
  
  @override
  void initState() {
    widget.dateInput.text = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.dateInput,
      readOnly: true,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: 'Date Of Birth',
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