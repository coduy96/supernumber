import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stupidnumber/pages/over_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePageBloc {
  int timeOut = 4500;
  int level = 0;
  int firstNumber = 0;
  int secondNumber = 0;
  String randomResult = '0';
  String mainResult = '0';
  String title = '';
  double percent = 1;
  Timer timer;
  int currentTimeOut = 0;
  int bestScore = 0;

  StreamController titleController = StreamController<String>();
  StreamController percentController = StreamController<double>();
  StreamController isGameOver = StreamController<bool>();
  StreamController randomResultController = StreamController<String>();
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

  void startTimer(BuildContext context, String gameplay) {
    currentTimeOut = timeOut;
    timer = Timer.periodic(Duration(milliseconds: 5), (Timer _) {
      currentTimeOut = currentTimeOut - 5;
      if (currentTimeOut < 0.01) {
        timer.cancel();
        gameOver(context, gameplay);
      } else {
        percentController.sink.add(currentTimeOut / timeOut);
      }
    });
  }

  void gameOver(BuildContext context, String gamePlay) async {
    print('game over');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => OverPage(
                finalScore: level,
                bestScore: bestScore,
                gamePlay: gamePlay,
              )),
    );
  }

  void nextLevel(BuildContext context, String gamePlay) {
    level++;
    print('level $level');
    levelController.sink.add(level);
    if (timeOut > 1000) {
      timeOut = timeOut - level + 10;
      //timeOut = timeOut - 500;
    }

    //timeOut = timeOut -1000;
    print('timeout $timeOut');
    startTimer(context, gamePlay);
    //pickRandom();
  }

  void pickRandom(BuildContext context, String gamePlay) {
    nextLevel(context, gamePlay);
    print('timeout = $timeOut level: $level');
    firstNumber = randomGenerator.nextInt(level + 3) + 3;
    secondNumber = randomGenerator.nextInt(level + 3) + 3;
    switch (gamePlay) {
      case 'baby':
        {
          generatePlus();
          break;
        }
      case 'human':
        {
          int ranNum = randomGenerator.nextInt(3) + 1;
          if (ranNum == 1) {
            generatePlus();
          } else if (ranNum == 2) {
            generateMulti();
          } else if (ranNum == 3) {
            generateMulti();
          }
          break;
        }
      case 'superhuman':
        {
          int ranNum = randomGenerator.nextInt(4) + 1;
          if (ranNum == 1) {
            generatePlus();
          } else if (ranNum == 2) {
            generateMulti();
          } else if (ranNum == 3) {
            generateMinus();
          } else if (ranNum == 4) {
            generateDevide();
          }
          break;
        }
    }

    //generatePlus();
    //generateMulti();
    //generateMinus();
    //generateDevide();
    //print('title: $title');
    syncData();
  }

  void generatePlus() {
    mainResult = (firstNumber + secondNumber).toString();
    //generate random result
    bool randomChoice = randomGenerator.nextBool();
    changeButtonDirection.sink.add(randomGenerator.nextBool());
    if (randomChoice) {
      randomResult = mainResult;
    } else {
      if (randomGenerator.nextBool()) {
        randomResult = (randomGenerator.nextInt(level) + 1).toString();
      } else {
        randomResult =
            (int.parse(mainResult) + randomGenerator.nextInt(5)).toString();
      }
    }

    title = '${firstNumber.toString()} + ${secondNumber.toString()}';
  }

  void generateMinus() {
    mainResult = (firstNumber - secondNumber).toString();
    //generate random result
    bool randomChoice = randomGenerator.nextBool();
    changeButtonDirection.sink.add(randomGenerator.nextBool());
    if (randomChoice) {
      randomResult = mainResult;
    } else {
      if (randomGenerator.nextBool()) {
        randomResult = (randomGenerator.nextInt(level)).toString();
      } else {
        randomResult =
            (int.parse(mainResult) - randomGenerator.nextInt(5)).toString();
      }
    }

    title = '${firstNumber.toString()} - ${secondNumber.toString()}';
  }

  void generateMulti() {
    mainResult = (firstNumber * secondNumber).toString();
    //generate random result
    bool randomChoice = randomGenerator.nextBool();
    changeButtonDirection.sink.add(randomGenerator.nextBool());
    if (randomChoice) {
      randomResult = mainResult;
    } else {
      if (randomGenerator.nextBool()) {
        randomResult = (randomGenerator.nextInt(level)).toString();
      } else {
        randomResult =
            (int.parse(mainResult) + randomGenerator.nextInt(5)).toString();
      }
    }

    title = '${firstNumber.toString()} * ${secondNumber.toString()}';
  }

  void generateDevide() {
    mainResult = (firstNumber / secondNumber).toStringAsFixed(1);
    //generate random result
    bool randomChoice = randomGenerator.nextBool();
    changeButtonDirection.sink.add(randomGenerator.nextBool());
    if (randomChoice) {
      randomResult = mainResult;
    } else {
      if (randomGenerator.nextBool()) {
        randomResult =
            (randomGenerator.nextInt(level)).toDouble().toStringAsFixed(1);
      } else {
        randomResult = (double.parse(mainResult) + randomGenerator.nextDouble())
            .toStringAsFixed(1);
      }
    }

    title = '${firstNumber.toString()} / ${secondNumber.toString()}';
  }

  checkScore(String gamePlay) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    switch (gamePlay) {
      case 'baby':
        if (prefs.getInt('bestScoreBaby') == null) {
          print('go to null');
          prefs.setInt('bestScoreBaby', 0);
          bestScore = 0;
        }
        if (level > prefs.getInt('bestScoreBaby')) {
          prefs.setInt('bestScoreBaby', level);
          bestScore = level;
          print('Best score: $bestScore');
        }
        if (level < prefs.getInt('bestScoreBaby')) {
          bestScore = prefs.getInt('bestScoreBaby');
          print('Best score: $bestScore');
        }
        break;
      case 'human':
        if (prefs.getInt('bestScoreHuman') == null) {
          print('go to null');
          prefs.setInt('bestScoreHuman', 0);
          bestScore = 0;
        }
        if (level > prefs.getInt('bestScoreHuman')) {
          prefs.setInt('bestScoreHuman', level);
          bestScore = level;
          print('Best score: $bestScore');
        }
        if (level < prefs.getInt('bestScoreHuman')) {
          bestScore = prefs.getInt('bestScoreHuman');
          print('Best score: $bestScore');
        }
        break;
      case 'superhuman':
        if (prefs.getInt('bestScoreSuperHuman') == null) {
          print('go to null');
          prefs.setInt('bestScoreSuperHuman', 0);
          bestScore = 0;
        }
        if (level > prefs.getInt('bestScoreSuperHuman')) {
          prefs.setInt('bestScoreSuperHuman', level);
          bestScore = level;
          print('Best score: $bestScore');
        }
        if (level < prefs.getInt('bestScoreSuperHuman')) {
          bestScore = prefs.getInt('bestScoreSuperHuman');
          print('Best score: $bestScore');
        }
    }
  }
}
