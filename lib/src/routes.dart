import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/screens/fill_profile/fill_profile.dart';
import 'package:my_health_assistant/src/pages/screens/schedule/cancel_page/cancel_page.dart';
import 'package:my_health_assistant/src/pages/screens/schedule/reschedule_page/reschedule_page.dart';
import 'package:my_health_assistant/src/pages/screens/schedule/reschedule_page/select_date_time_page.dart';
import 'package:my_health_assistant/src/pages/screens/sign_in/sign_in_screen.dart';
import 'package:my_health_assistant/src/pages/screens/sign_in/sign_up_screen.dart';
import 'package:my_health_assistant/src/pages/screens/sign_in/waiting_verify_email.dart';

import 'pages/screens/articles/articles_page.dart';
import 'pages/screens/get_started/get_started.dart';
import 'pages/screens/history/history_page.dart';
import 'pages/screens/home/home_page.dart';
import 'pages/screens/profile/profile_page.dart';
import 'widgets/page_controller.dart';

class MyRoutes {
  static const startApp = '/';
  static const home = '/home';
  static const pageController = '/page_controller';
  static const history = '/history';
  static const article = '/article';
  static const profile = '/profile';
  static const selectDate = '/select_date';
  static const reschedule = '/reschedule';
  static const cancel = '/cancel';
  static const seeAllArticles = '/see_all_articles';
  static const signIn = '/sign_in';
  static const signUp = '/sign_up';
  static const fillProfile = '/fillProfile';
  static const waitScreen = '/wait_screen';
}

var customRoutes = <String, WidgetBuilder>{
  MyRoutes.startApp: (context) => const GetStarted(),
  MyRoutes.pageController: (context) => const MyPageController(),
  MyRoutes.home: (context) => const HomePage(),
  MyRoutes.history: (context) => const HistoryPage(),
  MyRoutes.article: (context) => const ArticlePage(),
  MyRoutes.profile: (context) => const ProfilePage(),
  MyRoutes.selectDate: (context) => const SelectDateTimePage(),
  MyRoutes.reschedule: (context) => const ReschedulePage(),
  MyRoutes.cancel: (context) => const CancelPage(),
  // MyRoutes.seeAllArticles:(context) => const SeeAllArticlesPage(),
  MyRoutes.signIn: (context) => const SignInScreen(),
  MyRoutes.signUp: (context) => const SignUpScreen(),
  MyRoutes.fillProfile: (context) => const FillProfileScreen(),
  MyRoutes.waitScreen:(context) => const WaitingVerifyScreen(),
};
