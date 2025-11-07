import 'package:flutter/material.dart';
import 'package:mahjong/layout/boxes.dart';
import 'package:mahjong/page_b/models/game.dart';
import 'package:mahjong/page_b/models/player.dart';
import 'package:mahjong/page_b/widgets/game_content.dart';
import 'package:mahjong/page_b/widgets/game_stick.dart';

class PageB extends StatelessWidget {
  PageB({
    required this.round,
    required this.game,
    required this.players,
    required this.onPressedDraw,
    super.key
  });

  String round;
  Game game;
  List<Player> players;
  void Function(List<List<int>>?) onPressedDraw;

  final Map<int, String> label = {
    0 : "東家 : ",
    1 : "南家 : ",
    2 : "西家 : ",
    3 : "北家 : ",
  };

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Center(
              child: BoxB( // Top.
                "${label[players[2].zikaze]} ${players[2].name}",
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                  child: Text(
                    game.scoreTop.toString(),
                    style: TextStyle(fontSize: 50, letterSpacing: 5)
                  )
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GameContent( // 局数のポップアップ.
                  round: round,
                  game: game,
                  players: players,
                  onPressedDraw: onPressedDraw,
                ),
                SizedBox(width: 200),
                GameStick(game: game,)
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BoxB( // Left.
              "${label[players[3].zikaze]} ${players[3].name}",
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  game.scoreLeft.toString(),
                  style: TextStyle(fontSize: 50, letterSpacing: 5)
                )
              )
            ),
            SizedBox(),
            BoxB( // Right.
              "${label[players[1].zikaze]} ${players[1].name}",
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  game.scoreRight.toString(),
                  style: TextStyle(fontSize: 50, letterSpacing: 5)
                )
              )
            )
          ],
        ),
        BoxB( // Bottom.
          "${label[players[0].zikaze]} ${players[0].name}",
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
            child: Text(
              game.scoreBottom.toString(),
              style: TextStyle(fontSize: 50, letterSpacing: 5)
            )
          )
        )
      ],
    );
  }
}