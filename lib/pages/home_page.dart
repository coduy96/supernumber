import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stupidnumber/components/game_button.dart';
import 'package:stupidnumber/pages/game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWH = _screenHeight / _screenWidth;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff363062),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                size: 30,
              ),
              onPressed: () {}),
        ],
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage()),
                  );
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
                onPressed: () {},
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
                      'Support me',
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
                onPressed: () {},
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
                      'Ranking',
                      style: GoogleFonts.sigmarOne(
                          color: Colors.white, fontSize: _screenWH * 10),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: GameButton(
            //     onPressed: () {},
            //     height: _screenWH * 28,
            //     width: _screenWH * 120,
            //     style: ButtonStyle.DEFAULT,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Padding(
            //           padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            //           child: Icon(Icons.highlight_off, color: Colors.white),
            //         ),
            //         Text(
            //           'Quit',
            //           style: GoogleFonts.sigmarOne(
            //               color: Colors.white, fontSize: _screenWH * 10),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
