import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/views/doctor/doctor_page_controller.dart';
import 'package:my_health_assistant/src/views/patient/screens/fill_profile/component/show_dialog.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

import '../../patient/screens/fill_profile/component/custom_texfield.dart';
import '../../patient/screens/fill_profile/component/gender.dart';
import '../../patient/screens/fill_profile/component/input_date_of_birth.dart';
import 'component/deparment.dart';

class FillProfileDoctor extends StatefulWidget {
  const FillProfileDoctor({Key? key}) : super(key: key);

  @override
  State<FillProfileDoctor> createState() => _FillProfileDoctorState();
}

class _FillProfileDoctorState extends State<FillProfileDoctor> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? textGender;
  String? textDepartment;
  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _datetimeController.dispose();
    _dateInput.dispose();
    _descriptionController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Fill Your Profile'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage(
                                'assets/images/schedule_page/doctor.png'),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 230,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8)),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/edit-pen.svg',
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFiled(
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
                    FillProfileDeparment(
                      onChanged: ((value) => _getDeparment(value)),
                    ),
                    Gender(
                      onChanged: (value) => _getGender(value),
                    ),
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
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogBuilder(),
                      );
                      Timer(const Duration(seconds: 3), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DoctorPageController(),
                            ));
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text(
                    'Continue',
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

  _getGender(value) {
    if (value != null) {
      setState(() {
        textGender = value;
      });
    }
  }

  _getDeparment(value) {
    if (value != null) {
      setState(() {
        textDepartment = value;
      });
    }
  }
}
