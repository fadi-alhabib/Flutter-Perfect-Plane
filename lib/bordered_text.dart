import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final double fontSize;

  const BorderedText({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The text border
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            fontFamily: "Games",
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 10
              ..color = Colors.black,
          ),
        ),
        // The text inside
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            letterSpacing: 5,
            fontWeight: FontWeight.bold,
            fontFamily: "Games",
            color: const Color(0xff24EC22),
          ),
        ),
      ],
    );
  }
}
