import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class ButtonStyle {
  final Color topColor;
  final Color backColor;
  const ButtonStyle({@required this.topColor, @required this.backColor});
  static const DEFAULT = const ButtonStyle(
      topColor: const Color(0xFF45484c), backColor: const Color(0xFF191a1c));
  static const RED = const ButtonStyle(
      topColor: const Color(0xFFc62f2f), backColor: const Color(0xFF922525));
  static const PINK = const ButtonStyle(
      topColor: const Color(0xFFE8586F), backColor: const Color(0xFFAE475B));
  static const BLUE = const ButtonStyle(
      topColor: const Color(0xFF4BA8DF), backColor: const Color(0xFF478CBC));
  static const YELLOW = const ButtonStyle(
      topColor: const Color(0xFFf39c1e), backColor: const Color(0xFFbf7a25));
  static const WHITE = const ButtonStyle(
      topColor: const Color(0xFFFFFDEA), backColor: const Color(0xFFE8586F));
       static const GREEN = const ButtonStyle(
      topColor: const Color(0xFF1DB957), backColor: const Color(0xFF259050));
}

class GameButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ButtonStyle style;
  final double width;
  final double height;

  GameButton(
      {@required this.onPressed,
      @required this.child,
      this.style = ButtonStyle.YELLOW,
      this.width = 100.0,
      this.height = 90.0});

  @override
  State<StatefulWidget> createState() => GameButtonState();
}

class GameButtonState extends State<GameButton> {
  static const BORDER_RADIUS = 7.0;
  static const BUTTON_Z = 8.0;
  static const DOWN_PADDING = 7.0;

  bool isTapped = false;

  Widget _buildBackLayout() {
    return Padding(
      padding: EdgeInsets.only(top: BUTTON_Z),
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS)),
            boxShadow: [BoxShadow(color: widget.style.backColor)]),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
              width: widget.width, height: widget.height - BUTTON_Z),
        ),
      ),
    );
  }

  Widget _buildTopLayout() {
    return Padding(
      padding: EdgeInsets.only(top: isTapped ? BUTTON_Z - DOWN_PADDING : 0.0),
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS)),
            boxShadow: [BoxShadow(color: widget.style.topColor)]),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
              width: widget.width, height: widget.height - BUTTON_Z),
          child: Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[_buildBackLayout(), _buildTopLayout()],
        ),
        onTapDown: (TapDownDetails event) {
          setState(() {
            isTapped = true;
            Flame.audio.play('assets/gameplay.mp3', volume: 100.0);
          });
        },
        onTapUp: (TapUpDetails event) {
          setState(() {
            isTapped = false;
          });
          widget.onPressed();
        });
  }
}
