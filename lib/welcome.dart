import 'package:fluppy_bird/bordered_text.dart';
import 'package:fluppy_bird/choose_skin.dart';
import 'package:fluppy_bird/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        extendBodyBehindAppBar: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BorderedText(text: "Perfect Pilot", fontSize: 65),
            const SizedBox(
              height: 40,
            ),
            button(
                icon: 'assets/images/button-icons/play.png',
                context: context,
                onClick: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false)),
            button(
                icon: 'assets/images/button-icons/skins.png',
                context: context,
                onClick: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Skin()));
                }),
            button(
                icon: 'assets/images/button-icons/exit.png',
                context: context,
                onClick: () => SystemNavigator.pop())
          ],
        ));
  }

  Widget button({required icon, onClick, required context}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
          onTap: onClick,
          child: Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade900),
                child: Image.asset(
                  icon,
                  fit: BoxFit.contain,
                  width: 100,
                  height: 50,
                )),
          )),
    );
  }
}
