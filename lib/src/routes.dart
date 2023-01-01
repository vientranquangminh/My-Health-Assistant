import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/views/doctor/fill_profile/filll_profile_doctor.dart';
import 'package:my_health_assistant/src/views/doctor/profile/profile_screen.dart';
import 'package:my_health_assistant/src/views/patient/screens/fill_profile/fill_profile.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/cancel_page/cancel_page.dart';
import 'package:my_health_assistant/src/views/patient/screens/schedule/reschedule_page/select_date_time_page.dart';
import 'package:my_health_assistant/src/views/patient/screens/sign_in/sign_in_screen.dart';
import 'package:my_health_assistant/src/views/patient/screens/sign_in/sign_up_screen.dart';
import 'package:my_health_assistant/src/views/patient/screens/sign_in/waiting_verify_email.dart';

import 'views/patient/screens/articles/articles_page.dart';
import 'views/patient/screens/get_started/get_started.dart';
import 'views/patient/screens/history/history_page.dart';
import 'views/patient/screens/profile/profile_page.dart';
import 'widgets/page_controller.dart';


class CommonRoutes {
  static const startApp = '/';
  // static const home = '/home';
  static const signIn = '/sign_in';
  static const signUp = '/sign_up';
}

class PatientRoutes {
  static const pageController = '/page_controller';
  static const history = '/history';
  static const article = '/article';
  static const profile = '/profile';
  static const selectDate = '/select_date';
  static const reschedule = '/reschedule';
  static const cancel = '/cancel';
  static const seeAllArticles = '/see_all_articles';
  static const fillProfile = '/fillProfile';
  static const waitScreen = '/wait_screen';
  static const rescheduleSelectDateTime = '/reschedule_select_date_time';
}

var customRoutes = <String, WidgetBuilder> {
  PatientRoutes.pageController: (context) => const MyPageController(),
  PatientRoutes.history: (context) => const HistoryPage(),
  PatientRoutes.article: (context) => const ArticlePage(),
  PatientRoutes.profile: (context) => const ProfilePage(),
  PatientRoutes.selectDate: (context) => const SelectDateTimePage(),
  // PatientRoutes.reschedule: (context) => const ReschedulePage(),
  // PatientRoutes.rescheduleSelectDateTime: (context) =>
  //     const RescheduleSelectDateTime(),
  PatientRoutes.cancel: (context) => const CancelPage(),
  // MyRoutes.seeAllArticles:(context) => const SeeAllArticlesPage(),
  PatientRoutes.fillProfile: (context) => const FillProfileScreen(),
  PatientRoutes.waitScreen: (context) => const WaitingVerifyScreen(),


  CommonRoutes.startApp: (context) => const GetStarted(),
  CommonRoutes.signIn: (context) => const SignInScreen(),
  CommonRoutes.signUp: (context) => const SignUpScreen(),


  DoctorRoutes.fillDoctorProfile: (context) => const FillProfileDoctor(),
  DoctorRoutes.doctorPageController: (context) => const ProfileDoctor(),
};

class DoctorRoutes {
  static const doctorPageController = '/dpage_controller';
  static const fillDoctorProfile = '/dfillProfile';
}
