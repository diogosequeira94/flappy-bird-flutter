import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  final birdY;
  const FlappyBird({this.birdY, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      height: 50,
      width: 50,
      child: Image.asset('assets/flappybird.png'),
    );
  }
}
