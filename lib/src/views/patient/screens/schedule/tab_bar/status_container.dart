import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({Key? key, required this.status, required this.color}) : super(key: key);
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: color) 
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Text(
          status,
        style: TextStyle(color: color, fontSize: 10),),
      ),
    );
  }
}