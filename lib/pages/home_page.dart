import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stupidnumber/components/game_button.dart';
import 'package:stupidnumber/pages/game_page.dart';
import 'package:stupidnumber/services/admob_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdmobInterstitial interstitialAd;
    AdMobService adMobService = AdMobService();

    interstitialAd = AdmobInterstitial(
      adUnitId: adMobService.getInterstitialAdUnitId(),
    );
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWH = _screenHeight / _screenWidth;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff363062),
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.settings,
        //     size: 30,
        //   ),
        // ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(
        //         Icons.share,
        //         size: 30,
        //       ),
        //       onPressed: () {}),
        // ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff363062),
          gradient: LinearGradient(
              //colors: [Colors.indigo, Colors.deepOrange],
              colors: [Color(0xff363062), Color(0xffA04E68)],
              begin: Alignment.center,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/title.png',
              width: _screenWH * 160,
              height: _screenWH * 160,
            ),
            // Text(
            //   'Stupid Number',
            //   style: GoogleFonts.sigmarOne(
            //       color: Colors.white, fontSize: _screenWH * 15),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GameButton(
                onPressed: () {
                  Flame.audio.play('click.mp3', volume: 50.0);

                  // Navigator.pop(context);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => GamePage(gamePlay: 'superhuman',)),
                  // );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xffA04E68),
                          title: Center(
                            child: Text(
                              'Select your level',
                              style: GoogleFonts.sigmarOne(
                                  //color: Color(0xFFc62f2f),
                                  color: Colors.white),
                            ),
                          ),
                          content: Container(
                            // decoration: BoxDecoration(
                            //   color: Color(0xff363062),
                            //   gradient: LinearGradient(
                            //       //colors: [Colors.indigo, Colors.deepOrange],
                            //       colors: [
                            //         Color(0xff363062),
                            //         Color(0xffA04E68)
                            //       ],
                            //       begin: Alignment.center,
                            //       end: Alignment.bottomCenter),
                            // ),
                            child: Container(
                              width: _screenWH * 40,
                              height: _screenWH * 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Flame.audio
                                          .play('click.mp3', volume: 50.0);

                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GamePage(
                                            gamePlay: 'baby',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: _screenWH * 30,
                                      height: _screenWH * 40,
                                      child: Image.asset('assets/baby.png'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Flame.audio
                                          .play('click.mp3', volume: 50.0);

                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GamePage(
                                            gamePlay: 'human',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: _screenWH * 30,
                                      height: _screenWH * 40,
                                      child: Image.asset('assets/human.png'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Flame.audio
                                          .play('click.mp3', volume: 50.0);

                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GamePage(
                                            gamePlay: 'superhuman',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: _screenWH * 30,
                                      height: _screenWH * 50,
                                      child:
                                          Image.asset('assets/superhuman.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                height: _screenWH * 28,
                width: _screenWH * 120,
                style: ButtonStyle.PINK,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(Icons.play_arrow, color: Colors.white),
                    ),
                    Text(
                      'Play',
                      style: GoogleFonts.sigmarOne(
                          color: Colors.white, fontSize: _screenWH * 10),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GameButton(
                onPressed: () {
                  Flame.audio.play('click.mp3', volume: 50.0);
                  //Ads
                  interstitialAd.load();
                },
                height: _screenWH * 28,
                width: _screenWH * 120,
                style: ButtonStyle.BLUE,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(Icons.wc, color: Colors.white),
                    ),
                    Text(
                      'Support us',
                      style: GoogleFonts.sigmarOne(
                          color: Colors.white, fontSize: _screenWH * 10),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GameButton(
                onPressed: () {
                  Flame.audio.play('click.mp3', volume: 50.0);

                  // Navigator.pop(context);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => GamePage(gamePlay: 'superhuman',)),
                  // );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          //backgroundColor: Color(0xffA04E68),
                          backgroundColor: Colors.white,
                          content: Container(
                            width: _screenWH * 40,
                            height: _screenWH * 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Product of FINME',
                                  style: GoogleFonts.sigmarOne(
                                      color: Colors.black,
                                      fontSize: _screenWH * 8),
                                ),
                                Text(
                                  'Develop by Dver',
                                  style: GoogleFonts.sigmarOne(
                                      color: Colors.black,
                                      fontSize: _screenWH * 8),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Hide',
                                style: GoogleFonts.sigmarOne(
                                    color: Colors.red,
                                    fontSize: _screenWH * 5),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                launch('https://dver.now.sh/');
                              },
                              child: Text(
                                'More',
                                style: GoogleFonts.sigmarOne(
                                    color: Colors.blue,
                                    fontSize: _screenWH * 5),
                              ),
                            ),
                          ],
                        );
                      });
                },
                height: _screenWH * 28,
                width: _screenWH * 120,
                style: ButtonStyle.YELLOW,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(Icons.data_usage, color: Colors.white),
                    ),
                    Text(
                      'About',
                      style: GoogleFonts.sigmarOne(
                          color: Colors.white, fontSize: _screenWH * 10),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GameButton(
                onPressed: () {
                  exit(0);
                },
                height: _screenWH * 28,
                width: _screenWH * 120,
                style: ButtonStyle.DEFAULT,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(Icons.highlight_off, color: Colors.white),
                    ),
                    Text(
                      'Quit',
                      style: GoogleFonts.sigmarOne(
                          color: Colors.white, fontSize: _screenWH * 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
