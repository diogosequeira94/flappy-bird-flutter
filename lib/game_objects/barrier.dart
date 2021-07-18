import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final barrierHeight; // proportion of the screen height
  final barrierWidth; // out of 2, where 2 is the width of the screen
  final barrierX;
  final bool isBottomBarrier;

  const Barrier(
      {this.barrierHeight,
      this.barrierWidth,
      required this.isBottomBarrier,
      this.barrierX,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight,
      ),
    );
  }
}
