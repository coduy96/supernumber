import 'package:admob_flutter/admob_flutter.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stupidnumber/components/game_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stupidnumber/pages/home_page.dart';
import 'package:stupidnumber/services/admob_service.dart';

class OverPage extends StatelessWidget {
  final finalScore;
  final bestScore;
  final gamePlay;
  const OverPage({this.finalScore, this.bestScore, this.gamePlay});

  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    int counterPlay = 0;
    AdmobInterstitial interstitialAd;
    AdMobService adMobService = AdMobService();

    interstitialAd = AdmobInterstitial(
      adUnitId: adMobService.getInterstitialAdUnitId(),
    );

    Flame.audio.play('gameover.mp3', volume: 30.0);
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
                        Builder(builder: (context) {
                          if (gamePlay == 'baby') {
                            return Image.asset('assets/baby.png',
                                width: _screenWH * 20);
                          } else if (gamePlay == 'human') {
                            return Image.asset('assets/human.png',
                                width: _screenWH * 20);
                          } else {
                            return Image.asset('assets/superhuman.png',
                                width: _screenWH * 20);
                          }
                        }),
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
                        onPressed: () async {
                          final SharedPreferences prefs = await _prefs;
                          int counterPlay = prefs.getInt('counterPlay');
                          print('coutneerrererererer: $counterPlay');
                          if (counterPlay == null) {
                            prefs.setInt('counterPlay', 0);
                          }
                          prefs.setInt('counterPlay', counterPlay + 1);
                          
                          if (counterPlay == 5) {
                            print('SHOWWWWADDDD');
                            prefs.setInt('counterPlay', 1);
                            interstitialAd.load();
                          }

                          Navigator.pop(
                            context,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
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
                    // GameButton(
                    //   onPressed: () {
                    //     //Sharing function
                    //     screenshotController.capture(
                    //         delay: Duration(milliseconds: 10));
                    //   },
                    //   height: _screenWH * 28,
                    //   width: _screenWH * 70,
                    //   style: ButtonStyle.BLUE,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //         child: Icon(Icons.share, color: Colors.white),
                    //       ),
                    //       Text(
                    //         'Share',
                    //         style: GoogleFonts.sigmarOne(
                    //             color: Colors.white, fontSize: _screenWH * 10),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
