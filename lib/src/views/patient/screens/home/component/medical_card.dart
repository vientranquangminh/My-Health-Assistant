import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/models/department_model.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class MedicalCard extends StatelessWidget {
  const MedicalCard({Key? key, required this.department}) : super(key: key);
  final Department department;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 216, 237, 254),
                shape: BoxShape.circle),
            child: SvgPicture.asset(
              department.icon,
              height: 5,
              width: 5,
              fit: BoxFit.none,
              color: MyColors.mainColor,
            )),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            department.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
