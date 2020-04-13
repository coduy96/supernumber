import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stupidnumber/pages/over_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePageBloc {
  int timeOut = 5000;
  int level = 0;
  int firstNumber = 0;
  int secondNumber = 0;
  int randomResult = 0;
  int mainResult = 0;
  String title = '';
  double percent = 1;
  Timer timer;
  int currentTimeOut = 0;
  int bestScore = 0;

  StreamController titleController = StreamController<String>();
  StreamController percentController = StreamController<double>();
  StreamController isGameOver = StreamController<bool>();
  StreamController randomResultController = StreamController<int>();
  StreamController changeButtonDirection = StreamController<bool>();
  StreamController levelController = StreamController<int>();

  void dispose() {
    titleController.close();
    percentController.close();
    isGameOver.close();
    randomResultController.close();
    changeButtonDirection.close();
    levelController.close();
    //timer.cancel();
  }

  void syncData() {
    titleController.sink.add(title);
    randomResultController.sink.add(randomResult);
  }

  var randomGenerator = Random();

  void startTimer(BuildContext context) {
    currentTimeOut = timeOut;
    timer = Timer.periodic(Duration(milliseconds: 5), (Timer _) {
      currentTimeOut = currentTimeOut - 5;
      if (currentTimeOut < 0.01) {
        timer.cancel();
        gameOver(context);
      } else {
        percentController.sink.add(currentTimeOut / timeOut);
      }
    });
  }

  void gameOver(BuildContext context) async {
    print('game over');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => OverPage(
                finalScore: level,bestScore: bestScore,
              )),
    );
  }

  void nextLevel(BuildContext context) {
    level++;
    print('level $level');
    levelController.sink.add(level);
    if (timeOut > 1000) {
      timeOut = timeOut - level + 10;
      //timeOut = timeOut - 500;
    }

    //timeOut = timeOut -1000;
    print('timeout $timeOut');
    startTimer(context);
    //pickRandom();
  }

  void pickRandom(BuildContext context) {
    nextLevel(context);
    print('timeout = $timeOut level: $level');
    firstNumber = randomGenerator.nextInt(level + 4);
    secondNumber = randomGenerator.nextInt(level + 4);

    mainResult = firstNumber + secondNumber;
    //generate random result

    bool randomChoice = randomGenerator.nextBool();
    if (randomChoice) {
      randomResult = mainResult;
      changeButtonDirection.sink.add(true);
    } else {
      if (randomGenerator.nextBool()) {
        randomResult = randomGenerator.nextInt(level);
      } else {
        changeButtonDirection.sink.add(false);
        randomResult = mainResult + randomGenerator.nextInt(5);
      }
    }

    title = '${firstNumber.toString()} + ${secondNumber.toString()}';
    print('title: $title');
    syncData();
  }

  checkScore() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (prefs.getInt('bestScore') == null) {
      print('go to null');
      prefs.setInt('bestScore', 0);
      bestScore = 0;
    }
    if (level > prefs.getInt('bestScore')) {
      prefs.setInt('bestScore', level);
      bestScore = level;
      print('Best score: $bestScore');
    }
    if (level < prefs.getInt('bestScore')) {
      bestScore = prefs.getInt('bestScore');
      print('Best score: $bestScore');
    }
  }
}
