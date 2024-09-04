import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Icon prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;

  const CustomCupertinoTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: prefixIcon,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CupertinoColors.systemGrey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
    );
  }
}
