import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double widthFactor;

  const CustomButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color = Colors.blue,
    this.widthFactor = 0.9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
