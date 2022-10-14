import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {Key? key, required this.hint, this.surfixIcon, this.validator})
      : super(key: key);
  final String hint;
  final Icon? surfixIcon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            suffixIcon: surfixIcon,
            hintText: hint,
            labelStyle: MyFontStyles.normalGreyText),
        validator: validator,
      ),
    );
  }
}
