import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stupidnumber/components/game_button.dart';
import 'package:stupidnumber/pages/game_page.dart';
import 'package:flutter_audio_player/flutter_audio_player.dart';
import 'package:screenshot/screenshot.dart';

class OverPage extends StatelessWidget {
  final finalScore;
  final bestScore;
  const OverPage({this.finalScore, this.bestScore});

  @override
  Widget build(BuildContext context) {
    AudioPlayer.addSound('assets/gameover.mp3');
    ScreenshotController screenshotController = ScreenshotController();

    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWH = _screenHeight / _screenWidth;
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff363062),
            gradient: LinearGradient(
                //colors: [Colors.indigo, Colors.deepOrange],
                colors: [Color(0xff363062), Color(0xffA04E68)],
                begin: Alignment.center,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/titleOverGame.png'),
              Padding(
                padding: const EdgeInsets.all(30),
                child: GameButton(
                  style: ButtonStyle.WHITE,
                  width: _screenWidth * 50,
                  height: _screenWH * 90,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Current Score: $finalScore',
                          style: GoogleFonts.sigmarOne(
                              color: Color(0xFF45484c), fontSize: 25),
                        ),
                        Text(
                          'Best Score: $bestScore',
                          style: GoogleFonts.sigmarOne(
                              color: Color(0xFF45484c), fontSize: 25),
                        ),
                      ]),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GameButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GamePage()),
                          );
                        },
                        height: _screenWH * 28,
                        width: _screenWH * 70,
                        style: ButtonStyle.YELLOW,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Icon(Icons.replay, color: Colors.white),
                            ),
                            Text(
                              'Replay',
                              style: GoogleFonts.sigmarOne(
                                  color: Colors.white,
                                  fontSize: _screenWH * 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GameButton(
                      onPressed: () {
                        //Sharing function
                        screenshotController.capture(delay: Duration(milliseconds: 10));
                      },
                      height: _screenWH * 28,
                      width: _screenWH * 70,
                      style: ButtonStyle.BLUE,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Icon(Icons.share, color: Colors.white),
                          ),
                          Text(
                            'Share',
                            style: GoogleFonts.sigmarOne(
                                color: Colors.white, fontSize: _screenWH * 10),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
