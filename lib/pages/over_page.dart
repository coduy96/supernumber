import 'package:flutter/material.dart';

class OverPage extends StatelessWidget {
  final finalScore;
  const OverPage({this.finalScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Game Over: $finalScore'),),
      ),
    );
  }
}
