import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // init var
  static double birdY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdY;
  bool gameHasStarted = false;
  List<double> barriersX = [2, 3, 4]; // default location of barriers axis X
  // range hit point of barrier axis X
  List<double> barrierHitPointPairX = [0.35, -0.05];
  List<List<double>> barriersHitPointPairsY = [
    [0.19, -0.52],
    [0.52, -0.19],
    [0.19, -0.52],
  ]; // range hit point of barriers axis Y [bottom, top]
  int score = 0;
  int best = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdY;
    });
  }

  bool birdDead() {
    // check bird hit top or bottom
    if (birdY > 1 || birdY < -1) {
      gameHasStarted = false;
      return true;
    }

    // check bird hit barriers
    for (var i = 0; i < barriersX.length; i++) {
      if (barriersX[i] <= barrierHitPointPairX[0] &&
          barriersX[i] >= barrierHitPointPairX[1]) {
        if (birdY > barriersHitPointPairsY[i][0] ||
            birdY < barriersHitPointPairsY[i][1]) {
          return true;
        }
      }
    }

    return false;
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('G A M E  O V E R')),
          content: Text("Score: " + score.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                resetGame();
              },
              child: const Text(
                'PLAY AGAIN',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdY = initialHeight - height;
      });

      // check if barriers out left screen -> back from right screen
      for (var i = 0; i < barriersX.length; i++) {
        if (barriersX[i] == -2) {
          setState(() {
            barriersX[i] += 4;
          });
        } else {
          setState(() {
            barriersX[i] -= 0.05;
          });
        }
      }

      // round barriers
      for (var i = 0; i < barriersX.length; i++) {
        barriersX[i] = double.parse((barriersX[i]).toStringAsFixed(2));
      }

      // plus score
      for (var i = 0; i < barriersX.length; i++) {
        if (barriersX[i] == 0) {
          setState(() {
            score += 1;
          });
        }
      }

      if (birdDead()) {
        timer.cancel();
        _showDialog();
      }

      time += 0.05;
    });
  }

  void resetGame() {
    Navigator.pop(context);

    if (score > best) {
      setState(() {
        best = score;
      });
    }

    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      height = 0;
      initialHeight = height;

      for (var i = 0; i < barriersX.length; i++) {
        barriersX[i] = i + 2;
      }

      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 500,
              color: Colors.blue,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdY),
                    duration: const Duration(milliseconds: 0),
                    child: const Bird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text("")
                        : const Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(barriersX[0], 1.1), // bottom
                    child: Barrier(size: 180),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(barriersX[0], -1.1), // top
                    child: Barrier(size: 120),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(barriersX[1], 1.1),
                    child: Barrier(size: 120),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(barriersX[1], -1.1),
                    child: Barrier(size: 180),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(barriersX[2], 1.1),
                    child: Barrier(size: 180),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment: Alignment(barriersX[2], -1.1),
                    child: Barrier(size: 120),
                  )
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Back"),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.all(30),
                        shape: const CircleBorder(),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "BEST",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          best.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
