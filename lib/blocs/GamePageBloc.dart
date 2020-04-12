import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stupidnumber/pages/over_page.dart';

class GamePageBloc {
  int timeOut = 10000;
  int level = 0;
  int firstNumber = 0;
  int secondNumber = 0;
  int randomResult = 0;
  int mainResult = 0;
  String title = '';
  double percent = 1;
  Timer timer;
  int currentTimeOut = 0;

  StreamController titleController = StreamController<String>();
  StreamController percentController = StreamController<double>();
  StreamController isGameOver = StreamController<bool>();

  void dispose() {
    titleController.close();
    percentController.close();
    isGameOver.close();
    //timer.cancel();
  }

  void syncData() {
    titleController.sink.add(title);
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
    print('Game Over');
    //timer.cancel();
    // timeOut = 3000;
    // level = 0;
    // firstNumber = 0;
    // secondNumber = 0;
    // randomResult = 0;
    // mainResult = 0;
    // title = '';
    // percent = 1;
    // currentTimeOut = 0;
    // dispose();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => OverPage(
                finalScore: level,
              )),
    );
  }

  void nextLevel(BuildContext context) {
    level++;
    print('level $level');
    timeOut = timeOut - level;
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
    } else {
      if (randomGenerator.nextBool()) {
        randomResult = randomGenerator.nextInt(level);
      } else {
        randomResult = mainResult + randomGenerator.nextInt(5);
      }
    }

    title =
        '${firstNumber.toString()} + ${secondNumber.toString()} = ${randomResult.toString()}';
    print('title: $title');
    syncData();
  }
}
