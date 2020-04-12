import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(StupidNumberApp());
}

class StupidNumberApp extends StatelessWidget {
  const StupidNumberApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
