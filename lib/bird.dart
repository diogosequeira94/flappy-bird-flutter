import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  final birdY;
  const FlappyBird({this.birdY, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        'assets/flappybird.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
