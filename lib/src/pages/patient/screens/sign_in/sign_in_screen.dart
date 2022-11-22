// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/doctor/authentication/sign_in.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/patient/fill_information_firestore/fill_information_firestore.dart';
import 'package:my_health_assistant/src/pages/doctor/doctor_page_controller.dart';
import 'package:my_health_assistant/src/pages/doctor/fill_profile/filll_profile_doctor.dart';
import 'package:my_health_assistant/src/routes.dart';

import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

import '../../../../data/shared_preferences.dart';
import '../../../../services/reset_password.dart';
import '../../../../services/sign_in.dart';
import '../../../../widgets/snack_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isDoctor = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Logger logger = Logger(
      printer: PrettyPrinter(),
    );
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200.0,
                  height: 200.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/picwish.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Text(
                  "Login to Your Account",
                  style: MyFontStyles.normalBlackText
                      .copyWith(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 44.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return "Length of password's characters must be 8 or greater";
                    }
                    return null;
                  },
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          // Making around shape
                          borderRadius: BorderRadius.circular(6)),
                      checkColor: Colors.white,
                      value: isDoctor,
                      onChanged: (bool? value) {
                        setState(() {
                          isDoctor = value!;
                        });
                      },
                    ),
                    const Text('I am a Doctor',
                        style: MyFontStyles.normalBlackText)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    fillColor: const Color(0XFF0069FE),
                    onPressed: () async {
                      if (isDoctor == true) {
                        if (_formKey.currentState!.validate()) {
                          User? user = await SignIn.loginUsingEmailPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                          if (user != null) {
                            await SignInDoctor.getDoctor();
                            SharedPrefs.isLoggedIn(true);
                            SharedPrefs.writeUid(user.uid);
                            logger.i('uid from user: ${user.uid}');
                            String? uidFromPrefs = await SharedPrefs.getUid();
                            logger.i('uid prefs user: $uidFromPrefs');

                            final bool filled =
                                await SignInDoctor.checkDoctorExist(user.uid);

                            if (filled) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorPageController(),
                                  ));
                            } else {
                              Navigator.pushNamed(
                                  context, DoctorRoutes.fillDoctorProfile);
                            }
                          }
                        }
                      } else {
                        if (_formKey.currentState!.validate()) {
                          User? user = await SignIn.loginUsingEmailPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                          if (user != null) {
                            await FillInformation.getPatient();
                            SharedPrefs.isLoggedIn(true);
                            SharedPrefs.writeUid(user.uid);
                            logger.i('uid from user: ${user.uid}');
                            String? uidFromPrefs = await SharedPrefs.getUid();
                            logger.i('uid prefs user: $uidFromPrefs');

                            final bool filled =
                                await FillInformation.checkExist(user.uid);
                            if (filled) {
                              Navigator.pushNamed(
                                  context, PatientRoutes.pageController);
                            } else {
                              Navigator.pushNamed(
                                  context, PatientRoutes.fillProfile);
                            }
                          } else {
                            final snackBar = showSnackBar(
                                'Email or password is not correct');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                GestureDetector(
                  onTap: () {
                    logger.i('forgot password');
                    if (_emailController.text.isEmpty) {
                      final snackBar =
                          showSnackBar('Email and Password must be filled');
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      ResetPassword.resetPassword(email: _emailController.text);
                      final snackBar = showSnackBar('Please check your email');
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    "Forgot the password?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
