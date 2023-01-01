import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/views/doctor/profile/component/custom_texfield_doctor.dart';
import '../../patient/screens/fill_profile/component/custom_texfield.dart';
import 'package:my_health_assistant/src/views/doctor/profile/component/gender_doctor.dart';
import 'package:my_health_assistant/src/views/doctor/profile/component/input_date_of_birth.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class EditProfileDoctor extends StatefulWidget {
  const EditProfileDoctor({Key? key}) : super(key: key);

  @override
  State<EditProfileDoctor> createState() => _EditProfileDoctorState();
}

class _EditProfileDoctorState extends State<EditProfileDoctor> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _dateInput.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Your Profile'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFiledDoctor(
                      enabled: false,
                      controller: _nameController,
                      hint: 'Full name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    InputAge(dateInput: _dateInput),
                    const GenderDoctor(),
                    CustomTextFiled(
                      controller: _descriptionController,
                      hint: 'Description',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFiled(
                      surfixIcon: const Icon(Icons.phone_android),
                      hint: 'Phone number',
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone number";
                        } else if (value.length > 11 || value[0] != '0') {
                          return "Please enter valid phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextFiled(
                      hint: 'Address',
                      controller: _addressController,
                      surfixIcon: const Icon(Icons.location_on_sharp),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )),
            SizedBox(height: MediaQuery.of(context).size.height / 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('update');
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
