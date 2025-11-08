import 'package:flutter/material.dart';
import 'package:mahjong/page_a/models/score_detail.dart';
import 'package:mahjong/page_b/models/game.dart';
import 'package:mahjong/page_b/models/player.dart';

class CalPopup extends StatefulWidget {
  CalPopup({
    required this.round,
    required this.roundNumber,
    required this.detail,
    required this.players,
    super.key
  });

  String round;
  int roundNumber;
  ScoreDetail? detail;
  List<Player> players;

  @override
  State<CalPopup> createState() => _CalPopupState();
}

class _CalPopupState extends State<CalPopup> {

  Set<int> _selected = {0};
  int score = 0;
  int hostScore = 0;
  int childScore = 0;
  int childrenScore = 0;
  int zikaze = 0;
  final notWinnerPlayer = [];
  Map<int, String> playersMap = {};
  Set<int> _selectedReach = {};

  void _subTsumo(int score) { // ツモの場合の点数分配.
    if (zikaze == 0) { // 親なら.
      if (score % 3 == 0) {
        childrenScore = score ~/ 3;
      } else {
        score += 100;
        if (score % 3 == 0) { // 2000、2900、4400、5300、6800、7700、11600.
          childrenScore = score ~/ 3;
        } else { // 3400、5800、10600.
          score += 100;
          childrenScore = score ~/ 3;
        }
      }
    } else { // 子なら.
      int bufScore = score ~/ 100;
      if (bufScore % 4 == 0) {
        hostScore = score ~/ 2;
        childScore = score ~/ 4;
      } else if (bufScore % 2 == 0) { // 1000、2600、5800.
        hostScore = score ~/ 2;
        childScore = (hostScore + 100) ~/ 2;
      } else {
        bufScore += 1;
        score += 100;
        if (bufScore % 4 == 0) { // 2300、3900、7100.
          hostScore = score ~/ 2;
          childScore = score ~/ 4;
        } else { // 1300、2900、4500、7700.
          hostScore = score ~/ 2;
          childScore = (hostScore + 100) ~/ 2;
        }
      }
    }
  }

  @override
  void initState() { // WidgetとStateの紐づけが終わってから実行.
    super.initState();
    score = widget.detail!.score!;
    zikaze = widget.detail!.zikaze;

    if (widget.detail!.flagTsumo) {_subTsumo(score);}

    if (widget.detail!.flagRon) {
      final winnerNumber = widget.detail!.zikaze;
      playersMap = {
        0 : widget.players[0].name,
        1 : widget.players[1].name,
        2 : widget.players[2].name,
        3 : widget.players[3].name
      };

      if (widget.roundNumber % 4 == 0) {
        final _ = playersMap.remove(winnerNumber); // winner.
      } else if (widget.roundNumber % 4 == 1) {
        final _ = playersMap.remove((winnerNumber + 1) % 4); // winner.
      } else if (widget.roundNumber % 4 == 2) {
        final _ = playersMap.remove((winnerNumber + 2) % 4); // winner.
      } else {
        final _ = playersMap.remove((winnerNumber + 3) % 4); // winner.
      }
      for (String v in playersMap.values) {
        notWinnerPlayer.add(v);
      }
    }
  }

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
            SizedBox(height: 25),
            /***************************************************************************/
            if (widget.detail?.flagRon == true) ...[ // ロンなら.
              Text(
                "$score 点", // 点数.
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: 25),
            /***************************************************************************/
              Row(
                children: [
                  SizedBox(width: 80),
                  Text("誰から")
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
                          child: Text(notWinnerPlayer[0])
                        )
                      ),
                      ButtonSegment(
                        value: 1,
                        label: SizedBox(
                          width: 80,
                          child: Text(notWinnerPlayer[1])
                        )
                      ),
                      ButtonSegment(
                        value: 2,
                        label: SizedBox(
                          width: 80,
                          child: Text(notWinnerPlayer[2])
                        )
                      ),
                    ],
                    selected: _selected,
                    onSelectionChanged: (s) {
                      setState(() => _selected = {s.first}); // 排他にしたいから一応.
                    }
                  )
                ],
              ),
              SizedBox(height: 50),
            /***************************************************************************/
              Row(
                children: [
                  SizedBox(width: 25),
                  Text("リーチ者")
                ],
              ),
              SizedBox(height: 10),
              Row( // リーチ者選択.
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
                    onSelectionChanged: (s) => setState(() => _selectedReach = s),
                  )
                ],
              ),
              SizedBox(height: 50),
            /***************************************************************************/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('キャンセル'),
                  ),
                  SizedBox(width: 80),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, (
                      0,
                      score,
                      playersMap.keys.singleWhere((w) => playersMap[w] == notWinnerPlayer[_selected.first]), // ロンされた人
                      _selectedReach.isNotEmpty ? _selectedReach.toList() : null
                    )),
                    child: const Text('ロン'),
                  ),
                ],
              )
            ]
            /***************************************************************************/
            else if (widget.detail?.flagTsumo == true) ...[ // ツモなら.
            /***************************************************************************/
              if (widget.detail?.zikaze == 0) ...[ // 親なら.
                Text(
                  "$childrenScore 点 オール", // 点数.
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 25),
              /***************************************************************************/
                Row(
                  children: [
                    SizedBox(width: 25),
                    Text("リーチ者")
                  ],
                ),
                SizedBox(height: 10),
                Row( // リーチ者選択.
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
                      onSelectionChanged: (s) => setState(() => _selectedReach = s),
                    )
                  ],
                ),
                SizedBox(height: 50),
              /***************************************************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                    SizedBox(width: 80),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, (
                        1,
                        childrenScore,
                        0, // ３個目の値は使わない、個数合わせ.
                        _selectedReach.isNotEmpty ? _selectedReach.toList() : null
                      )),
                      child: const Text('ツモ'),
                    ),
                  ],
                )
              /***************************************************************************/
              ] else ...[ // 子なら.
                Text(
                  "$childScore / $hostScore 点", // 点数.
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: 25),
              /***************************************************************************/
                Row(
                  children: [
                    SizedBox(width: 25),
                    Text("リーチ者")
                  ],
                ),
                SizedBox(height: 10),
                Row( // リーチ者選択.
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
                      onSelectionChanged: (s) => setState(() => _selectedReach = s),
                    )
                  ],
                ),
                SizedBox(height: 50),
              /***************************************************************************/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                    SizedBox(width: 80),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, (
                        2,
                        childScore,
                        hostScore,
                        _selectedReach.isNotEmpty ? _selectedReach.toList() : null
                      )),
                      child: const Text('ツモ'),
                    ),
                  ],
                )
              ]
            ]
          ],
        ),
      )
    );
  }
}