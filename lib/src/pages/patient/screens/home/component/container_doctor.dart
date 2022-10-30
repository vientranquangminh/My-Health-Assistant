import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_health_assistant/src/pages/patient/screens/home/component/doctor_object.dart';
import 'package:my_health_assistant/src/routes.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class ContainerDoctor extends StatelessWidget {
  const ContainerDoctor({
    Key? key,
    required this.department,
    required this.index,
  }) : super(key: key);

  final List<DoctorObject> department;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    'assets/images/schedule_page/doctor.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              department[index].doctorName,
                              style: MyFontStyles.blackColorH1,
                            ),
                            SvgPicture.asset(
                              'assets/images/home_page/heart.svg',
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          text: department[index].department,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                          children: [
                            const TextSpan(
                              text: ' | ',
                            ),
                            TextSpan(
                              text: department[index].hospital,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 15,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            department[index].phoneNumber!,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (department[index].gender == 'Male')
                                  const Icon(
                                    Icons.male_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                if (department[index].gender == 'Female')
                                  const Icon(
                                    Icons.female_outlined,
                                    color: Colors.pink,
                                    size: 20,
                                  ),
                                if (department[index].gender == 'Others')
                                  const Icon(
                                    Icons.question_mark,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(department[index].gender!,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            SizedBox(
                                width: 70,
                                height: 28,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              MyColors.mainColor),
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))))),
                                  onPressed: () => Navigator.pushNamed(
                                      context, PatientRoutes.selectDate),
                                  child: const Text(
                                    'Book',
                                    style: MyFontStyles.whiteColorH2,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
