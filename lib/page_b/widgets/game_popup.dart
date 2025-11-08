import 'package:flutter/material.dart';
import 'package:mahjong/page_b/models/game.dart';
import 'package:mahjong/page_b/models/player.dart';

class GamePopup extends StatefulWidget {
  GamePopup({
    required this.round,
    required this.game,
    required this.players,
    super.key
  });

  String round;
  Game game;
  List<Player> players;

  @override
  State<GamePopup> createState() => _GamePopupState();
}

class _GamePopupState extends State<GamePopup> {

  Set<int> _selectedReach = {};
  Set<int> _selectedTenpai = {};
  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 350, vertical: 50),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "${widget.round}",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: 25),
                Text("リーチ者")
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: 0,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[0].name)
                      )
                    ),
                    ButtonSegment(
                      value: 1,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[1].name)
                      )
                    ),
                    ButtonSegment(
                      value: 2,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[2].name)
                      )
                    ),
                    ButtonSegment(
                      value: 3,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[3].name)
                      )
                    )
                  ],
                  multiSelectionEnabled: true,
                  emptySelectionAllowed: true,
                  selected: _selectedReach,
                  onSelectionChanged: (s) => setState(() {
                    _selectedReach = s;
                    for (int i in _selectedReach) { // リーチした人は聴牌だから.
                      _selectedTenpai.add(i+4);
                    }
                  }),
                )
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: 25),
                Text("聴牌者")
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: 4,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[0].name)
                      )
                    ),
                    ButtonSegment(
                      value: 5,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[1].name)
                      )
                    ),
                    ButtonSegment(
                      value: 6,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[2].name)
                      )
                    ),
                    ButtonSegment(
                      value: 7,
                      label: SizedBox(
                        width: 80,
                        child: Text(widget.players[3].name)
                      )
                    )
                  ],
                  multiSelectionEnabled: true,
                  emptySelectionAllowed: true,
                  selected: _selectedTenpai,
                  onSelectionChanged: (s) => setState(() {
                    _selectedTenpai = s;
                    for (int i in _selectedReach) {
                      _selectedTenpai.add(i+4);
                    }
                  }),
                )
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                SizedBox(width: 80),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, [
                    _selectedReach.toList(),
                    _selectedTenpai.toList()
                  ]),
                  child: const Text('流局'),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}