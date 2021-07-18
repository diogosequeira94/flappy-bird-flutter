import 'dart:async';

import 'package:flappy_bird_flutter/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Bird position on Y axis
  static double birdY = 0;

  /// How strong the gravity is
  double gravity = -4.9;

  /// How strong the jump is
  double velocity = 30;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  void jump() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      /// A real physical jump is the same as an upside down parabola
      /// this is a simple quadratic equation
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });
      // Keep the time going!
      time += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    FlappyBird(),
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
