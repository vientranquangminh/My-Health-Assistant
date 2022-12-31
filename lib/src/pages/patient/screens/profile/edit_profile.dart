import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/global_var.dart';

import 'package:my_health_assistant/src/pages/patient/screens/profile/widgets/edit_profile_widgets/gender.dart';
import 'package:my_health_assistant/src/pages/patient/screens/profile/widgets/edit_profile_widgets/input_date.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/app_toast/app_toast.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

import 'widgets/edit_profile_widgets/textfield_custom.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  String textGender = 'Male';

  @override
  Widget build(BuildContext context) {
    final patient = FirebaseFirestore.instance
        .collection("patients")
        .doc(auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
        stream: patient,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          if (snapshot.hasData) {
            return Column(children: [
              Column(
                children: [
                  TextFieldCustom(
                    controller: _nameController
                      ..text = snapshot.data!.get('fullName'),
                    hint: 'Full name',
                  ),
                  TextFieldCustom(
                    controller: _nicknameController
                      ..text = snapshot.data!.get('nickname'),
                    hint: 'Nick name',
                  ),
                  InputDate(
                    dateInput: _dateInput,
                    date: snapshot.data!.get('dateOfBirth'),
                  ),
                  GenderEditProfile(
                    gender: snapshot.data!.get('gender'),
                    getText: (value) => _getTextGender(value),
                  ),
                  TextFieldCustom(
                    surfixIcon: const Icon(Icons.phone_android),
                    hint: 'Phone number',
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController
                      ..text = snapshot.data!.get('phoneNumber'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your phone number";
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
                  ),
                  TextFieldCustom(
                    hint: 'Address',
                    controller: _addressController
                      ..text = snapshot.data!.get('address'),
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: MyElevatedButton(
                    customFunction: () {
                      log(textGender);
                      log('Updated');
                      Map<String, dynamic> data = {
                        'fullName': _nameController.text,
                        'nickname': _nicknameController.text,
                        'address': _addressController.text,
                        'gender': textGender,
                        'phoneNumber': _phoneNumberController.text,
                        'dateOfBirth': _dateInput.text
                      };
                      var collection =
                          FirebaseFirestore.instance.collection('patients');
                      // var collectionAppointment =
                      // FirebaseFirestore.instance.collection('appointments');
                      // collectionAppointment.
                      // final key = UniqueKey().toString();
                      collection.doc(auth.currentUser!.uid).update(data);
                      // showMyDialog(context, MyColors.mainColor, MediaQuery.of(context).size, 'Success', 'You account has been saved.');
                      AppToasts.showToast(
                          context: context, title: 'Update successfully');
                    },
                    text: 'Update',
                    buttonColor: MyColors.mainColor,
                    fontSize: 16,
                    textColor: MyColors.whiteText,
                  ),
                ),
              )
            ]);
          }
          return Container();
        }),
      )),
    );
  }

  _getTextGender(value) {
    if (value != null) {
      textGender = value;
    }
  }
}
