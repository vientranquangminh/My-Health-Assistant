import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/patient/fill_information_firestore/fill_information_firestore.dart';
import 'package:my_health_assistant/src/data/shared_preferences.dart';
import 'package:my_health_assistant/src/models/users/patient.dart';
import 'package:my_health_assistant/src/pages/patient/screens/fill_profile/component/custom_texfield.dart';
import 'package:my_health_assistant/src/pages/patient/screens/fill_profile/component/gender.dart';
import 'package:my_health_assistant/src/pages/patient/screens/fill_profile/component/input_date_of_birth.dart';
import 'package:my_health_assistant/src/pages/patient/screens/fill_profile/component/show_dialog.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({Key? key}) : super(key: key);

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? textGender;
  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _nicknameController.dispose();
    _datetimeController.dispose();
    _dateInput.dispose();
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
                    CustomTextFiled(
                      controller: _nicknameController,
                      hint: 'Nick name',
                    ),
                    InputAge(dateInput: _dateInput),
                    Gender(
                      onChanged: (value) => _getGender(value),
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
                        }
                        else{
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
                  onPressed: () async {
                    String? uid = await SharedPrefs.getUid();
                    Logger().i('uid from fill profile: $uid');
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogBuilder(),
                      );
                      Timer(const Duration(seconds: 2), () {
                        Patient patient = Patient(id: uid!, fullName: _nameController.text, nickname: _nicknameController.text, dateOfBirth: DateFormat('dd-MM-yyyy').parse(_dateInput.text), gender: textGender ?? '', phoneNumber: _phoneNumberController.text, address: _addressController.text);
                        FillInformation.addPatientInformation(patient.toJson());
                        Navigator.pushNamed(context, PatientRoutes.pageController);
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
}
