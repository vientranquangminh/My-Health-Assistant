import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/admin/widget/edit_day_of_birth_admin.dart';
import 'package:my_health_assistant/src/pages/admin/widget/edit_department.dart';
import 'package:my_health_assistant/src/pages/admin/widget/edit_gender.dart';
import 'package:my_health_assistant/src/pages/patient/screens/profile/widgets/edit_profile_widgets/gender.dart';

import '../../../../widgets/buttons/my_elevated_button.dart';

class EditDoctor extends StatefulWidget {
  const EditDoctor({
    Key? key,
  }) : super(key: key);

  @override
  State<EditDoctor> createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  String? textGender;
  String? textDepartment;
  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _departmentController.dispose();
    _dateInputController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: SizedBox(
          child: Column(
            children: const [
              Text(
                'Edit Profile Doctor',
                // 'Cancel Appointment Success',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        content: SizedBox(
          height: 400,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number of doctor";
                  } else if (value.length > 10 ||
                      value[0] != '0' ||
                      value.length < 10) {
                    return "Please enter valid phone number";
                  } else if (value[0] == '0' && value[1] == '0') {
                    return "Please enter valid phone number";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: const Icon(
                      Icons.phone_android,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
              ),
              const SizedBox(height: 10),
              EditDateOfBirthAdmin(dateInput: _dateInputController),
              const SizedBox(height: 10),
              EditGender(
                getText: (value) => _getTextGender(value),
                gender: 'Male',
              ),
              const SizedBox(height: 10),
              EditDepartment(
                  getText: (value) => _getTextDepartment(value),
                  deparment: 'General')
            ],
          ),
        ),
        actions: <Widget>[
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: MyElevatedButton(
                buttonColor: Colors.blue,
                customFunction: () {
                  if (_formKey.currentState!.validate()) {
                    log(textGender.toString());
                    log(textDepartment.toString());
                    Navigator.pop(context);
                  }
                },
                fontSize: 16,
                text: 'Submit',
                textColor: Colors.white,
              ))
        ],
      ),
    );
  }

  _getTextGender(value) {
    if (value != null) {
      textGender = value;
    }
  }

  _getTextDepartment(value) {
    if (value != null) {
      textDepartment = value;
    }
  }
}
