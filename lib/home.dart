import 'dart:async';

import 'package:fluppy_bird/barriers.dart';
import 'package:fluppy_bird/bird.dart';
import 'package:fluppy_bird/welcome.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  double? gameSpeed;
  HomePage({this.gameSpeed});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameStarted = false;
  static double barrierXOne = 2;
  int score = 0;
  int highestScore = 0;

  double barrierXTwo = barrierXOne + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYAxis = initialHeight - height;
      });
      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
          score += 1;
          if (score > highestScore) {
            highestScore = score;
          }
        } else {
          barrierXOne -= widget.gameSpeed!;
        }
        setState(() {
          if (barrierXTwo < -2) {
            barrierXTwo += 3.5;
            score += 1;
            if (score > highestScore) {
              highestScore = score;
            }
          } else {
            barrierXTwo -= widget.gameSpeed!;
          }
        });
      });
      if (birdDead()) {
        timer.cancel();
        gameStarted = false;
        _showDialog();
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYAxis = 0;
      gameStarted = false;
      time = 0;
      initialHeight = birdYAxis;
      barrierXOne = 2;
      barrierXTwo = barrierXOne + 1.5;
      score = 0;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: resetGame,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        color: Colors.grey.shade500,
                        child: Text(
                          "PLAY AGAIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      resetGame();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WelcomeScreen()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        color: Colors.grey.shade500,
                        child: Text(
                          "MAIN MENUE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  bool birdDead() {
    if (birdYAxis < -1 ||
        birdYAxis > 1 ||
        (birdYAxis == 1.1 && barrierXOne == 0) ||
        (birdYAxis == -1.1 && barrierXOne == 0) ||
        (birdYAxis == 1.1 && barrierXTwo == 0) ||
        (birdYAxis == -1.1 && barrierXTwo == 0)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: gameStarted ? jump : startGame,
              child: Stack(
                children: [
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      // image: DecorationImage(
                      //     image: AssetImage("images/background.jpg"),
                      //     fit: BoxFit.cover)),
                    ),
                    alignment: Alignment(0, birdYAxis),
                    duration: Duration(seconds: 0),
                    child: MyBird(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.5),
                    child: gameStarted
                        ? Text('')
                        : Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, 1.1),
                    duration: Duration(microseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXOne, -1.1),
                    duration: Duration(microseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, 1.1),
                    duration: Duration(microseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXTwo, -1.1),
                    duration: Duration(microseconds: 0),
                    child: MyBarrier(
                      size: 250.0,
                    ),
                  )
                ],
              ),
            )),
        Expanded(
            child: Container(
          color: Colors.brown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Score',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${score}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Hieghest Score',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${highestScore}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
            ],
          ),
        )),
      ]),
    );
  }
}
