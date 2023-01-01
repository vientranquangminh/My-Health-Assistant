import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

import '../../../../routes.dart';

class WaitingVerifyScreen extends StatefulWidget {
  const WaitingVerifyScreen({Key? key}) : super(key: key);

  @override
  State<WaitingVerifyScreen> createState() => _WaitingVerifyScreenState();
}

class _WaitingVerifyScreenState extends State<WaitingVerifyScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  
  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/sign_in/zyro-image.png'),
            Text(
              'Please Verify Your Email Address',
              style: MyFontStyles.blackColorH1.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: MyColors.mainColor),
            ),
            const SizedBox(height: 15),
            Text(
              'We noticed your email address has not been verified. '
              'By doing so. you will receive important notification and information about your account',
              textAlign: TextAlign.center,
              style: MyFontStyles.blackColorH2.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    await user.reload();
    user = auth.currentUser!;
    if(user.emailVerified){
      timer.cancel();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, CommonRoutes.signIn);
    }
  }
}
