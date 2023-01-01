import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {Key? key,
      required this.hint,
      this.surfixIcon,
      this.validator,
      required this.controller,
      this.keyboardType})
      : super(key: key);
  final String hint;
  final Icon? surfixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
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
