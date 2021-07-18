import 'dart:async';

import 'package:flappy_bird_flutter/game_objects/bird.dart';
import 'package:flappy_bird_flutter/game_objects/coverscreen.dart';
import 'package:flutter/material.dart';

import 'game_objects/barrier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Bird position on Y axis
  static double birdY = 0;
  double birdWidth = 0.1; // out of 2, 2 being entire width of the screen
  double birdHeight = 0.1; // out of 2, 2 being entire height of the screen

  /// How strong the gravity is
  double gravity = -4.9;

  /// How strong the jump is
  double velocity = 3.5;
  double initialPos = birdY;
  double height = 0;
  double time = 0;

  // Game Settings
  bool gameHasStarted = false;

  // Barrier Variables
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    /// out of 2, where 2 is the entire height of the screen
    /// [topHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      /// A real physical jump is the same as an upside down parabola
      /// this is a simple quadratic equation
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      // Check if bird is dead
      if (isBirdDead()) {
        timer.cancel();
        _showDialog();
      }

      // keep the map moving (move barriers)
      moveMap();

      // Keep the time going!
      time += 0.1;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      // keep barriers moving
      setState(() {
        barrierX[i] -= 0.005;
      });

      // if barrier exits the left part of the screen, keep it looping
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool isBirdDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    // hits barriers
    // checks if bird is within x coordinates and y coordinates of barriers

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context); // Dismisses the alert dialog
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              'G A M E  O V E R',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  padding: EdgeInsets.all(7.0),
                  color: Colors.white,
                  child: Text(
                    'PLAY AGAIN',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    FlappyBird(
                      birdY: birdY,
                      birdWidth: birdWidth,
                      birdHeight: birdHeight,
                    ),
                    if (!gameHasStarted) CoverScreen(),
                    // Top 0
                    Barrier(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][0],
                      isBottomBarrier: false,
                    ),
                    // Bottom 0
                    Barrier(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][1],
                      isBottomBarrier: true,
                    ),
                    // Top 1
                    Barrier(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][0],
                      isBottomBarrier: false,
                    ),
                    // Bottom 1
                    Barrier(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][1],
                      isBottomBarrier: true,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
