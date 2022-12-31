import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/doctor/authentication/sign_in.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/patient/fill_information_firestore/fill_information_firestore.dart';
import 'package:my_health_assistant/src/data/shared_preferences.dart';
import 'package:my_health_assistant/src/pages/doctor/doctor_page_controller.dart';
import 'package:my_health_assistant/src/routes.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  Logger logger = Logger(
    printer: PrettyPrinter(),
  );
  Future<void> _onIntroEnd(context) async {
    //do something here
    // SharedPreferences.setMockInitialValues({});
    final bool? status = await SharedPrefs.getStatus();
    // final bool? filled = await SharedPrefs.getFilled();
    logger.i(status.toString());
    if (status == null) {
      Navigator.pushNamed(context, CommonRoutes.signUp);
    } else {
      final String uid = await SharedPrefs.getUid() ?? '';

      final bool role = await SharedPrefs.getRole() ?? false;

      if (role) {
        final bool filled = await FillInformation.checkExist(uid);
        if (filled) {
          Navigator.pushNamed(context, PatientRoutes.pageController);
        } else {
          Navigator.pushNamed(context, PatientRoutes.fillProfile);
        }
      } else {
        final bool filled = await SignInDoctor.checkDoctorExist(uid);
        if (filled) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorPageController(),
              ));
        } else {
          Navigator.pushNamed(context, DoctorRoutes.fillDoctorProfile);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.w700,
          color: Color(0xFF246BFD)),
      titlePadding: EdgeInsets.all(16),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 20),
    );

    return ScreenUtilInit(
        designSize: const Size(428, 884),
        builder: (BuildContext context, Widget? child) {
          return IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            pages: [
              PageViewModel(
                image: Image.asset('assets/images/onboard1.png'),
                title: "Thousands of doctor & experts to help your heath!",
                body: "",
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/onboard2.png'),
                title: "Health checks & consultations easily anywhere anytime",
                body: "",
                decoration: pageDecoration,
              ),
              PageViewModel(
                image: Image.asset('assets/images/onboard3.png'),
                title: "Let's start living healthy and well with us right now",
                body: "",
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            skipOrBackFlex: 0,
            nextFlex: 0,
            next: Container(
              height: 50,
               width: 250.w,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withAlpha(1000),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 3.0),
                    )
                  ]),
              child: const Center(
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            done: Container(
              height: 50,
              width: 250.w,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withAlpha(1000),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 3.0),
                    )
                  ]),
              child: const Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            curve: Curves.fastLinearToSlowEaseIn,
            dotsDecorator: const DotsDecorator(
              size: Size(15.0, 15.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(30.0, 15.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          );
        });
  }
}
