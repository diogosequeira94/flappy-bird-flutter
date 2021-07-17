import 'dart:async';

import 'package:flappy_bird_flutter/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdY = 0;

  void jump() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        // Bird moves Up, so we need to decrease value of Y value
        birdY -= 0.05;
      });
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
