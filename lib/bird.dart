import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdYAxis;
  final double birdWidth;
  final double birdHeight;
  final String photoUrl;

  const MyBird(
      {super.key,
      required this.birdYAxis,
      required this.birdWidth,
      required this.birdHeight,
      required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdYAxis + birdHeight) / (2 - birdHeight)),
      child: Image.asset(
        photoUrl,
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      ),
    );
  }
}
