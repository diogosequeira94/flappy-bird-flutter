import 'package:flutter/material.dart';

class FlappyBird extends StatelessWidget {
  final birdY;
  final double birdWidth; // normal double value for width;
  final double birdHeight; // out of 2, 2 being the entire height of the screen

  const FlappyBird(
      {this.birdY, required this.birdWidth, required this.birdHeight, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        'assets/bird.png',
        width: MediaQuery.of(context).size.height * birdWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight,
        fit: BoxFit.fill,
      ),
    );
  }
}
