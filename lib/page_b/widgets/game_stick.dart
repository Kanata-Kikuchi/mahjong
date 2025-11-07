import 'package:flutter/material.dart';
import 'package:mahjong/page_b/models/game.dart';

class GameStick extends StatelessWidget {
  GameStick({
    required this.game,
    super.key
  });

  Game game;
  final gameStick = Image.asset("assets/images/game_stick.png", width: 150);
  final reachStick = Image.asset("assets/images/reach_stick.png", width: 150);
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( // 本場.
          children: [
            gameStick,
            Text("    ×  ${game.gameStick}")
          ],
        ),
        SizedBox(height: 25),
        Row( // 供託.
          children: [
            reachStick,
            Text("    ×  ${game.reachStick}")
          ],
        )
      ],
    );
  }
}