import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String text;
  final double width;
  // final double height;
  // final Color color;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  // final double borderRadius;

  const CustomButton2({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    //  this.height = 50,
    // this.color = const Color.fromARGB(255, 24, 89, 143),
    this.textStyle,
    //  this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 20, 82, 181),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ?? const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
