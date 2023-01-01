import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class CustomTextFiledDoctor extends StatelessWidget {
  const CustomTextFiledDoctor(
      {Key? key,
      required this.hint,
      this.surfixIcon,
      this.validator,
      required this.controller,
      this.keyboardType,
      this.enabled})
      : super(key: key);
  final String hint;
  final Icon? surfixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 0.8),
            ),
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
