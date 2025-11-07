import 'package:flutter/material.dart';
import 'package:mahjong/page_b/models/game.dart';
import 'package:mahjong/page_b/models/player.dart';
import 'package:mahjong/page_b/widgets/game_popup.dart';

class GameContent extends StatelessWidget {
  GameContent({
    required this.round,
    required this.game,
    required this.players,
    required this.onPressedDraw,
    super.key
  });

  String round;
  Game game;
  List<Player> players;
  final void Function(List<List<int>>?) onPressedDraw;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final r = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => GamePopup(
            round: round,
            game: game,
            players: players
          )
        );
        onPressedDraw(r);
        // print("$r  ${r.runtimeType}");
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "$round",
          style: TextStyle(
            fontSize: 25
          )
        ),
      )
    );
  }
}