import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/pages/screens/fill_profile/component/custom_texfield.dart';
import 'package:my_health_assistant/src/pages/screens/fill_profile/component/gender.dart';
import 'package:my_health_assistant/src/pages/screens/fill_profile/component/input_date_of_birth.dart';
import 'package:my_health_assistant/src/pages/screens/fill_profile/component/show_dialog.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({Key? key}) : super(key: key);

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
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
                            radius: 80,
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
                      hint: 'Full name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const CustomTextFiled(
                      hint: 'Nick name',
                    ),
                    InputAge(dateInput: _dateInput),
                    CustomTextFiled(
                      hint: 'Email',
                      surfixIcon: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Can not be empty';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enterr a valid email address';
                        }
                        return null;
                      },
                    ),
                    const Gender()
                  ],
                )),
            SizedBox(height: MediaQuery.of(context).size.height / 13),
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
                      Timer(const Duration(seconds: 5), () {
                        Navigator.pushNamed(context, MyRoutes.pageController);
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
}
