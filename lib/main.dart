import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:stupidnumber/services/admob_service.dart';
import 'pages/home_page.dart';

void main() {
  AdMobService _admobService = AdMobService();
  Admob.initialize(_admobService.getAppId());
  runApp(StupidNumberApp());
}

class StupidNumberApp extends StatelessWidget {
  const StupidNumberApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
