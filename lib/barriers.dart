import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 75,
        height: size,
        decoration: BoxDecoration(
          // image: DecorationImage(image: AssetImage('images/background.jpg')),
          color: Colors.grey.shade800,
          border: BorderDirectional(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));
  }
}
