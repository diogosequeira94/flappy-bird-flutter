import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.5),
      child: Text(
        'T A P  T O  P L A Y',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
