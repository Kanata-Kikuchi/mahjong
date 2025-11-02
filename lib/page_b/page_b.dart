import 'package:flutter/material.dart';
import 'package:mahjong/main.dart';
import 'package:mahjong/layout/boxes.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  @override
  State<PageB> createState() => _PageBState();
}

class _PageBState extends State<PageB> {

  String _labelTop = "東";
  String _labelRight = "西";
  String _labelLeft = "南";
  String _labelBottom = "北";

  String _scoreTop = "25000";
  String _scoreRight = "25000";
  String _scoreLeft = "25000";
  String _scoreBottom = "25000";
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BoxB( // Top.
              _labelTop,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  _scoreTop,
                  style: TextStyle(fontSize: 50, letterSpacing: 5)
                )
              )
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BoxB( // Left.
              _labelLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  _scoreLeft,
                  style: TextStyle(fontSize: 50, letterSpacing: 5)
                )
              )
            ),
            SizedBox(),
            BoxB( // Right.
              _labelRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  _scoreRight,
                  style: TextStyle(fontSize: 50, letterSpacing: 5)
                )
              )
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BoxB( // Bottom.
              _labelBottom,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  _scoreBottom,
                  style: TextStyle(fontSize: 50, letterSpacing: 5)
                )
              )
            )
          ],
        )
      ],
    );
  }
}