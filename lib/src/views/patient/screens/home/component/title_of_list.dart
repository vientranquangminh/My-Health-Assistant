import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class TitleOfList extends StatelessWidget {
  const TitleOfList({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          TextButton(
              onPressed: onPressed,
              child: const Text('See all',
                  style: TextStyle(color: MyColors.mainColor)))
        ],
      ),
    );
  }
}