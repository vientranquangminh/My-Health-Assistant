import 'package:flutter/cupertino.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class MyCustomCategory extends StatelessWidget {
  const MyCustomCategory({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: MyColors.lightBlue,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Text(category, style: MyFontStyles.mainColorH5,),
    );
  }
}