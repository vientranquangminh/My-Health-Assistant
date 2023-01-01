import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/colors.dart';

class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.greyText),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: const [
            Text("(+84)"),
            SizedBox(width: 5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: VerticalDivider(color: Colors.grey,),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(
                          color: MyColors.greyText,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
