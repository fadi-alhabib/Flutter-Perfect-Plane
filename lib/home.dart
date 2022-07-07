// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:fluppy_bird/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluppy_bird/barriers.dart';
import 'package:fluppy_bird/bird.dart';
import 'package:fluppy_bird/welcome.dart';

class HomePage extends StatefulWidget {
  final String? skinChanged;
  const HomePage({
    Key? key,
    this.skinChanged,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences preferences;
  String charachterSkin = "assets/images/skins/plane_1/plane_1_blue.png";

  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  double gameSpeed = 0.05;

  bool gameStarted = false;
  bool isPaused = false;

  int score = 0;
  int highestScore = 0;

  double birdWidth = 0.15;
  double birdHeight = 0.15;

  List<double> barrierXAxis = [2, 3.5];
  double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.75, 0.55],
    [0.55, 0.75]
  ];

  List<double> currentBarrierXAxis = [2, 3.5];
  double currentBirdYAxis = 0;
  double currentTime = 0;
  double currentInitialHeight = 0;
  int currentScore = 0;

  bool resumeClicked = false;
  Timer? countDownTimer;
  int seconds = 4;

  void startCountDownTimer() {
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds--;
        if (seconds == -1) {
          resumeClicked = false;
          seconds = 4;
          countDownTimer?.cancel();
          resume();
          if (gameStarted == true) {
            startGame();
          }
        }
      });
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = preferences.getInt('HighestScore') ?? 0;
      if (widget.skinChanged == null) {
        charachterSkin = preferences.getString('planeSkin') ??
            "assets/images/skins/plane_1/plane_1_blue.png";
      } else {
        setState(() {
          charachterSkin = widget.skinChanged as String;
        });
        preferences.setString('planeSkin', widget.skinChanged as String);
      }
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(const Duration(milliseconds: 75), (Timer timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYAxis = initialHeight - height;
      });

      setState(() {
        if (barrierXAxis[0] < -2) {
          barrierXAxis[0] += 3.5;
          score += 1;
          if (gameSpeed >= 0.2) {
            gameSpeed = 0.2;
          } else {
            gameSpeed += 0.02;
          }
        } else {
          barrierXAxis[0] -= gameSpeed;
        }
        setState(() {
          if (barrierXAxis[1] < -2) {
            barrierXAxis[1] += 3.5;
            score += 1;
          } else {
            barrierXAxis[1] -= gameSpeed;
          }
        });
      });

      if (birdDead()) {
        timer.cancel();
        _showDialog();
        gameStarted = false;
        if (score > highestScore) {
          highestScore = score;
          preferences.setInt('HighestScore', highestScore);
        }
      }

      if (isPaused == true) {
        timer.cancel();
        setState(() {
          currentBirdYAxis = birdYAxis;
          currentBarrierXAxis = [barrierXAxis[0], barrierXAxis[1]];
          currentTime = time;

          currentInitialHeight = initialHeight;
          currentScore = score;
        });
      }
    });
  }

  void resume() {
    setState(() {
      isPaused = false;
      birdYAxis = currentBirdYAxis;
      barrierXAxis = [currentBarrierXAxis[0], currentBarrierXAxis[1]];
      time = currentTime;

      initialHeight = currentInitialHeight;
      score = currentScore;
    });
    if (gameStarted == false) {
      resetGame();
    }
  }

  void jump() {
    gameStarted = true;
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void resetGame() {
    setState(() {
      birdYAxis = 0;
      gameSpeed = 0.05;
      gameStarted = false;
      time = 0;
      initialHeight = birdYAxis;

      score = 0;
      barrierXAxis[0] = 2;
      barrierXAxis[1] = 3.5;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: const BorderedText(
              text: "GAME OVER",
              fontSize: 40,
            ),
            actionsPadding: const EdgeInsets.all(20.0),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  resetGame();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.green,
                    child: const Text(
                      "PLAY AGAIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Games',
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                      (route) => false);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.green,
                    child: const Text(
                      "MAIN MENUE",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Games',
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  bool birdDead() {
    if (birdYAxis < -1 || birdYAxis > 1) {
      return true;
    }

    for (int i = 0; i < barrierXAxis.length; i++) {
      if (barrierXAxis[i] <= birdWidth &&
          barrierXAxis[i] + barrierWidth >= -birdWidth &&
          (birdYAxis <= -1 + barrierHeight[i][0] ||
              birdYAxis + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  Widget showCountDown() {
    return BorderedText(
      text: seconds.toString(),
      fontSize: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? jump : startGame,
      child: Scaffold(
        body: Column(children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage('assets/images/back.png'),
                            fit: BoxFit.cover)),
                    alignment: Alignment(0, birdYAxis),
                    duration: const Duration(seconds: 0),
                    child: MyBird(
                      birdYAxis: birdYAxis,
                      birdWidth: birdWidth,
                      birdHeight: birdHeight,
                      photoUrl: charachterSkin,
                    ),
                  ),
                  Container(
                      alignment: const Alignment(0, -0.5),
                      child: gameStarted
                          ? const Text('')
                          : const BorderedText(
                              text: "TAP  TO  PLAY",
                              fontSize: 36,
                            )),
                  MyBarrier(
                    barrierXAxis: barrierXAxis[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][0],
                    isTheBottomBarrier: false,
                  ),
                  MyBarrier(
                    barrierXAxis: barrierXAxis[0],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[0][1],
                    isTheBottomBarrier: true,
                  ),
                  MyBarrier(
                    barrierXAxis: barrierXAxis[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][0],
                    isTheBottomBarrier: false,
                  ),
                  MyBarrier(
                    barrierXAxis: barrierXAxis[1],
                    barrierWidth: barrierWidth,
                    barrierHeight: barrierHeight[1][1],
                    isTheBottomBarrier: true,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isPaused = true;
                        });

                        showDialog(
                            barrierColor: Colors.blue.shade100.withOpacity(0.4),
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Colors.grey.shade800,
                                title: Column(
                                  children: [
                                    Center(
                                      child: Lottie.asset(
                                        'assets/images/animated-photos/game-paused-animation.json',
                                        repeat: true,
                                      ),
                                    ),
                                    const BorderedText(
                                        text: "GAME PAUSED", fontSize: 35),
                                  ],
                                ),
                                actionsAlignment: MainAxisAlignment.spaceAround,
                                actionsPadding: const EdgeInsets.all(20),
                                actions: [
                                  GestureDetector(
                                    onTap: () {
                                      resumeClicked = true;
                                      startCountDownTimer();
                                      Navigator.pop(context);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        color: Colors.green,
                                        child: const Text(
                                          "Resume",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Games',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      resetGame();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WelcomeScreen()),
                                          (route) => false);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        color: Colors.green,
                                        child: const Text(
                                          "Main menue",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Games'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.black,
                        size: 35,
                      )),
                  Center(
                      child: resumeClicked == true
                          ? showCountDown()
                          : const Text("")),
                ],
              )),
          Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: const Color(0XFF70D19D),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Score',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Games',
                        ),
                      ),
                      Text(
                        '$score',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Games'),
                      )
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Hieghest Score',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Games'),
                      ),
                      Text(
                        '$highestScore',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Games'),
                      )
                    ]),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
