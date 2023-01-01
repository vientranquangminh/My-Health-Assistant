// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/admin/login_screen.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Get Started',
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {

              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            child: const Text('Get Started')),
      ),
    );
  }
}
