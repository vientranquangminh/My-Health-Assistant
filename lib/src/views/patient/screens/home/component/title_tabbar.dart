import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class TabbarTitle extends StatelessWidget {
  const TabbarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColors.mainColor,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(title),
        ));
  }
}
