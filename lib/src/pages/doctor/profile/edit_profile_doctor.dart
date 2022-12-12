import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/doctor/profile/component/custom_texfield_doctor.dart';
import 'package:my_health_assistant/src/pages/global_var.dart';
import 'package:my_health_assistant/src/widgets/app_toast/app_toast.dart';
import '../../patient/screens/fill_profile/component/custom_texfield.dart';
import 'package:my_health_assistant/src/pages/doctor/profile/component/gender_doctor.dart';
import 'package:my_health_assistant/src/pages/doctor/profile/component/input_date_of_birth.dart';
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
    final doctor = FirebaseFirestore.instance
        .collection("doctors")
        .doc(auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Your Profile'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: doctor,
              builder: ((context, snapshot) {
                if(snapshot.hasError){
                  return Text('Something went wrong ${snapshot.error}');
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasData){
                  return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFiledDoctor(
                        enabled: false,
                        controller: _nameController..text = snapshot.data?.get('fullName'),
                        hint: 'Full name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Can not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      InputAge(dateInput: _dateInput, date: snapshot.data?.get('dateOfBirth')),
                      const GenderDoctor(),
                      CustomTextFiled(
                        controller: _descriptionController..text = snapshot.data?.get('description'),
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
                        controller: _phoneNumberController..text = snapshot.data?.get('phoneNumber'),
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
                        controller: _addressController..text = snapshot.data?.get('address'),
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
                  ));
                }
                return Container();
              }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        'description': _descriptionController.text,
                        'phoneNumber': _phoneNumberController.text,
                        'address': _addressController.text,
                      };
                      var collection =
                          FirebaseFirestore.instance.collection('doctors');
                      // var collectionAppointment =
                      // FirebaseFirestore.instance.collection('appointments');
                      // collectionAppointment.
                      // final key = UniqueKey().toString();
                      collection.doc(auth.currentUser!.uid).update(data);
                      // showMyDialog(context, MyColors.mainColor, MediaQuery.of(context).size, 'Success', 'You account has been saved.');
                      AppToasts.showToast(
                          context: context, title: 'Update successfully');
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
