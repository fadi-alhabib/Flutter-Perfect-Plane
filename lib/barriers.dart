import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double barrierWidth;
  final double barrierHeight;
  final double barrierXAxis;
  final bool isTheBottomBarrier;

  const MyBarrier(
      {super.key,
      required this.barrierWidth,
      required this.barrierHeight,
      required this.barrierXAxis,
      required this.isTheBottomBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
          (2 * barrierXAxis + barrierWidth) / (2 - barrierWidth),
          isTheBottomBarrier ? 1 : -1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown,
          border: !isTheBottomBarrier
              ? const Border(bottom: BorderSide(color: Colors.green, width: 10))
              : const Border(top: BorderSide(color: Colors.green, width: 10)),
        ),
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
