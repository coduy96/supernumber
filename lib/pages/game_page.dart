//import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:audioplayer/audioplayer.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stupidnumber/blocs/GamePageBloc.dart';
import 'package:stupidnumber/components/game_button.dart';
import 'package:stupidnumber/pages/home_page.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:stupidnumber/services/admob_service.dart';

class GamePage extends StatefulWidget {
  final String gamePlay;
  GamePage({this.gamePlay});
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  GamePageBloc _gamePageBloc = GamePageBloc();
  AdmobBannerSize bannerSize;
  AdMobService admobService = AdMobService();

  @override
  void dispose() {
    // TODO: implement dispose
    //_gamePageBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _gamePageBloc.pickRandom(context, widget.gamePlay);
    bannerSize = AdmobBannerSize.FULL_BANNER;
  }

  @override
  Widget build(BuildContext context) {
    //final assetsAudioPlayer = AssetsAudioPlayer();
    // AudioPlayer advancedPlayer;
    // AudioCache audioCache;
    //AudioPlayer audioPlugin = AudioPlayer();

    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWH = _screenHeight / _screenWidth;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffff363062),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
            size: _screenWH * 17,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: StreamBuilder<Object>(
                stream: _gamePageBloc.levelController.stream,
                builder: (context, snapshot) {
                  return Text('Level: ${snapshot.data.toString()}',
                      style: GoogleFonts.sigmarOne(fontSize: 20));
                }),
          ))
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xff363062),
            gradient: LinearGradient(
                //colors: [Colors.indigo, Colors.deepOrange],
                colors: [Color(0xff363062), Color(0xffA04E68)],
                begin: Alignment.center,
                end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder<Object>(
                    initialData: 1,
                    stream: _gamePageBloc.percentController.stream,
                    builder: (context, snapshot) {
                      return LinearPercentIndicator(
                        //backgroundColor: Color(0xffffb3ae),
                        backgroundColor: Colors.white60,
                        progressColor: Colors.white,
                        lineHeight: 20,
                        percent: snapshot.data,
                        //animation: true,
                      );
                    },
                  ),
                  StreamBuilder<Object>(
                      stream: _gamePageBloc.titleController.stream,
                      builder: (context, snapshot) {
                        return Text(snapshot.data,
                            style: GoogleFonts.sigmarOne(
                                fontSize: 50, color: Colors.white));
                      }),
                  StreamBuilder<Object>(
                      stream: _gamePageBloc.randomResultController.stream,
                      builder: (context, snapshot) {
                        print('dataSnapshot ${snapshot.data}');
                        return Draggable(
                          data: _gamePageBloc.randomResult,
                          child: GameButton(
                            style: ButtonStyle.DEFAULT,
                            width: _screenWH * 50,
                            height: _screenWH * 50,
                            child: Center(
                              child: Text(
                                snapshot.data,
                                style: GoogleFonts.sigmarOne(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                          childWhenDragging: GameButton(
                            style: ButtonStyle.DEFAULT,
                            width: _screenWH * 50,
                            height: _screenWH * 50,
                          ),
                          feedback: GameButton(
                            style: ButtonStyle.DEFAULT,
                            width: _screenWH * 50,
                            height: _screenWH * 50,
                            child: Center(
                              child: Text(
                                snapshot.data,
                                style: GoogleFonts.sigmarOne(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }),
                  StreamBuilder<Object>(
                      initialData: false,
                      stream: _gamePageBloc.changeButtonDirection.stream,
                      builder: (context, snapshot) {
                        return snapshot.data
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GameButton(
                                    width: _screenWH * 50,
                                    height: _screenWH * 50,
                                    style: ButtonStyle.GREEN,
                                    child: DragTarget(
                                      builder: (context,
                                          List<String> candidateData,
                                          rejectedData) {
                                        print(candidateData);
                                        return Center(
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: _screenWH * 20,
                                          ),
                                          // child: Text(
                                          //   "Right",
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontSize: 22.0),
                                          // ),
                                        );
                                      },
                                      onWillAccept: (data) {
                                        return true;
                                      },
                                      onAccept: (data) async {
                                        print(data);
                                        if (data == _gamePageBloc.mainResult) {
                                          print('right');
                                          Flame.audio.play('gameplay.mp3',
                                              volume: 70.0);

                                          _gamePageBloc.timer.cancel();
                                          _gamePageBloc.pickRandom(
                                              context, widget.gamePlay);
                                          print(
                                              'result ${_gamePageBloc.mainResult}');
                                        } else {
                                          await _gamePageBloc
                                              .checkScore(widget.gamePlay);
                                          _gamePageBloc.gameOver(
                                              context, widget.gamePlay);
                                          print('wrong');
                                        }
                                      },
                                    ),
                                  ),
                                  GameButton(
                                    width: _screenWH * 50,
                                    height: _screenWH * 50,
                                    style: ButtonStyle.RED,
                                    child: DragTarget(
                                      builder: (context,
                                          List<String> candidateData,
                                          rejectedData) {
                                        return Center(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: _screenWH * 20,
                                          ),

                                          // child: Text(
                                          //   "Wrong",
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontSize: 22.0),
                                          // ),
                                        );
                                      },
                                      onWillAccept: (data) {
                                        return true;
                                      },
                                      onAccept: (data) async {
                                        if (data != _gamePageBloc.mainResult) {
                                          print('right');
                                          Flame.audio.play('gameplay.mp3',
                                              volume: 70.0);

                                          _gamePageBloc.timer.cancel();
                                          _gamePageBloc.pickRandom(
                                              context, widget.gamePlay);
                                        } else {
                                          await _gamePageBloc
                                              .checkScore(widget.gamePlay);
                                          _gamePageBloc.gameOver(
                                              context, widget.gamePlay);
                                          print('wrong');
                                        }
                                      },
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GameButton(
                                    width: _screenWH * 50,
                                    height: _screenWH * 50,
                                    style: ButtonStyle.RED,
                                    child: DragTarget(
                                      builder: (context,
                                          List<String> candidateData,
                                          rejectedData) {
                                        return Center(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: _screenWH * 20,
                                          ),

                                          // child: Text(
                                          //   "Wrong",
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontSize: 22.0),
                                          // ),
                                        );
                                      },
                                      onWillAccept: (data) {
                                        return true;
                                      },
                                      onAccept: (data) async {
                                        if (data != _gamePageBloc.mainResult) {
                                          print('right');
                                          Flame.audio.play('gameplay.mp3',
                                              volume: 70.0);

                                          _gamePageBloc.timer.cancel();
                                          _gamePageBloc.pickRandom(
                                              context, widget.gamePlay);
                                        } else {
                                          await _gamePageBloc
                                              .checkScore(widget.gamePlay);
                                          _gamePageBloc.gameOver(
                                              context, widget.gamePlay);
                                          print('wrong');
                                        }
                                      },
                                    ),
                                  ),
                                  GameButton(
                                    width: _screenWH * 50,
                                    height: _screenWH * 50,
                                    style: ButtonStyle.GREEN,
                                    child: DragTarget(
                                      builder: (context,
                                          List<String> candidateData,
                                          rejectedData) {
                                        print(candidateData);
                                        return Center(
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: _screenWH * 20,
                                          ),

                                          // child: Text(
                                          //   "Right",
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontSize: 22.0),
                                          // ),
                                        );
                                      },
                                      onWillAccept: (data) {
                                        return true;
                                      },
                                      onAccept: (data) async {
                                        print(data);
                                        if (data == _gamePageBloc.mainResult) {
                                          print('right');
                                          Flame.audio.play('gameplay.mp3',
                                              volume: 70.0);

                                          _gamePageBloc.timer.cancel();
                                          _gamePageBloc.pickRandom(
                                              context, widget.gamePlay);
                                          print(
                                              'result ${_gamePageBloc.mainResult}');
                                        } else {
                                          await _gamePageBloc
                                              .checkScore(widget.gamePlay);
                                          _gamePageBloc.gameOver(
                                              context, widget.gamePlay);
                                          print('wrong');
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                      }),
                  //Container(
                    AdmobBanner(
                      adUnitId: admobService.getBannerAdUnitId(),
                      adSize: bannerSize,
                    ),
                  //),
                ],
              ),
            ),
          )
          // );
          //   }
          // ),
          ),
    );
  }
}
