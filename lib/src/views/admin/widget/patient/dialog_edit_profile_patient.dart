import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/views/admin/widget/edit_day_of_birth_admin.dart';
import 'package:my_health_assistant/src/views/admin/widget/edit_gender.dart';
import 'package:my_health_assistant/src/widgets/app_toast/app_toast.dart';

import '../../../../widgets/buttons/my_elevated_button.dart';

class EditPatient extends StatefulWidget {
  const EditPatient({Key? key, required this.patientId}) : super(key: key);
  final String patientId;

  @override
  State<EditPatient> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _dateInputController = TextEditingController();
  String? textGender;
  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _nickNameController.dispose();
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
                'Edit Profile Patient',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        content: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('patients')
              .doc(widget.patientId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.hasData) {
              textGender = snapshot.data?.get('gender');
              return SizedBox(
                height: 400,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController
                        ..text = snapshot.data?.get('fullName'),
                      decoration: InputDecoration(
                          hintText: "Name",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter patient name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nickNameController
                        ..text = snapshot.data?.get('nickname'),
                      decoration: InputDecoration(
                          hintText: "Nick Name",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter nick name of patient';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _phoneNumberController
                        ..text = snapshot.data?.get('phoneNumber'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter phone number of patient";
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
                    EditDateOfBirthAdmin(
                      dateInput: _dateInputController,
                      date: snapshot.data?.get('dateOfBirth')
                      // snapshot.data?.get('dateOfBirth'),
                    ),
                    const SizedBox(height: 10),
                    EditGender(
                      getText: (value) => _getTextGender(value),
                      gender: snapshot.data?.get('gender'),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        actions: <Widget>[
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              margin: const EdgeInsets.all(20),
              child: MyElevatedButton(
                buttonColor: Colors.blue,
                customFunction: () {
                  if (_formKey.currentState!.validate()) {
                    log(textGender.toString());
                    log('Updated');
                    Map<String, dynamic> data = {
                      'fullName': _nameController.text,
                      'nickname': _nickNameController.text,
                      'gender': textGender,
                      'phoneNumber': _phoneNumberController.text,
                      'dateOfBirth': _dateInputController.text
                    };
                    var collection =
                        FirebaseFirestore.instance.collection('patients');
                    collection.doc(widget.patientId).update(data);
                    AppToasts.showToast(
                        context: context, title: 'Update successfully');
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
}
