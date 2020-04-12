import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stupidnumber/blocs/GamePageBloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  GamePageBloc _gamePageBloc = GamePageBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    _gamePageBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _gamePageBloc.pickRandom(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<Object>(
              initialData: 1,
              stream: _gamePageBloc.percentController.stream,
              builder: (context, snapshot) {
                return LinearPercentIndicator(
                  lineHeight: 20,
                  percent: snapshot.data,
                  //animation: true,
                );
              }),
          StreamBuilder<Object>(
              stream: _gamePageBloc.titleController.stream,
              builder: (context, snapshot) {
                return Draggable(
                  data: _gamePageBloc.randomResult,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        snapshot.data,
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                    color: Colors.grey,
                  ),
                  feedback: Container(
                    width: 100.0,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        snapshot.data,
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                    color: Colors.pink,
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                color: Colors.green,
                child: DragTarget(
                  builder: (context, List<int> candidateData, rejectedData) {
                    print(candidateData);
                    return Center(
                        child: Text(
                      "Right",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ));
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    print(data);
                    if (data == _gamePageBloc.mainResult) {
                      print('right');
                      _gamePageBloc.timer.cancel();
                      _gamePageBloc.pickRandom(context);
                      print('result ${_gamePageBloc.mainResult}');
                    } else {
                      _gamePageBloc.gameOver(context);
                      print('wrong');
                    }
                  },
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                color: Colors.red,
                child: DragTarget(
                  builder: (context, List<int> candidateData, rejectedData) {
                    return Center(
                        child: Text(
                      "Wrong",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ));
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    if (data != _gamePageBloc.mainResult) {
                      print('right');
                      _gamePageBloc.timer.cancel();
                      _gamePageBloc.pickRandom(context);
                    } else {
                      _gamePageBloc.gameOver(context);
                      print('wrong');
                    }
                  },
                ),
              )
            ],
          )
        ],
      )
          // );
          //   }
          // ),
          ),
    );
  }
}
