import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/pages/admin/login_screen.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/widgets/buttons/my_elevated_button.dart';

class BannerDoctor extends StatelessWidget {
  const BannerDoctor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 103, 173, 239),
                    offset: Offset(4, 6),
                    blurRadius: 20),
              ],
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(0, 129, 201, 1),
                    Color.fromRGBO(17, 168, 253, 1),
                  ]),
              borderRadius: BorderRadius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Medical checks!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 10),
                const Text(
                    "Check your health condition regulary\nto minimize the incidence of\ndiseasein the future",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 30,
                  child: MyElevatedButton(
                    buttonColor: MyColors.whiteText,
                    textColor: MyColors.mainColor,
                    text: 'Check now',
                    fontSize: 13,
                    customFunction: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      const Positioned(
          right: 30,
          bottom: 0,
          child: Image(
            image: AssetImage("assets/images/home_page/doctor2.png"),
          ))
    ]);
  }
}
