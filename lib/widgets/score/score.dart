import 'package:flutter/material.dart';
import 'package:mahjong/widgets/score/score_calculator.dart';
import 'package:mahjong/widgets/score/score_option_dora.dart';
import 'package:mahjong/widgets/score/score_option_ippatsu.dart';
import 'package:mahjong/widgets/score/score_toggle.dart';


class Score extends StatefulWidget {
  Score({
    required this.agariCal,
    required this.flagRon,
    required this.flagTsumo,
    required this.flagCal,
    super.key
  });

  final List<((int type, int tile), int meld)> agariCal;
  bool flagRon;
  bool flagTsumo;
  bool flagCal;

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {

  int _reachGroup = 0;     // 0:なし, 1:リーチ, 2:ダブリー
  int _tsumoDetail = 0;    // 0:なし, 1:海底, 2:嶺上開花
  int _ronDetail = 0;      // 0:なし, 1:河底, 2:槍槓

  bool _ippatsu = false;
  int _doraCount = 0;

  // // 深いコピー.
  // final List<Yaku> _yaku = yakuList
  //     .map((y) => Yaku(
  //       name: y.name,
  //       hanClosed: y.hanClosed,
  //       hanOpen: y.hanOpen,
  //       selected: false
  //     ))
  //     .toList();


  // // 偶然役
  // static const Set<String> _situational = {
  //   'リーチ',
  //   'ダブルリーチ',
  //   '海底',
  //   '河底',
  //   '一発',
  //   'ツモ',
  //   '嶺上開花',
  //   '槍槓',
  // };

  @override
  Widget build(BuildContext context) {


    void _onPressedRemove() {
      setState(() => _doraCount--);
    }

    void _onPressedAdd() {
      setState(() => _doraCount++);
    }

    void _onCheacked(bool? v) {
      setState(() => _ippatsu = v ?? false);
    }


    Widget content;

    if (widget.flagCal) {
      content = ScoreCalculator(
        flagRon: widget.flagRon,
        flagTsumo: widget.flagTsumo,
        agariCal: widget.agariCal,
      );
    } else if (widget.flagTsumo) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreToggle(
            title: "リーチ系",
            label0: "なし",
            label1: "リーチ",
            label2: "ダブルリーチ",
            groupValue: _reachGroup,
            onChanged: (i) => setState(() {
              _reachGroup = i;
              if (_reachGroup == 0) _ippatsu = false;
            })
          ),
          const SizedBox(height: 24),
          ScoreToggle(
            title: "ツモ系",
            label0: "なし",
            label1: "海底",
            label2: "嶺上開花",
            groupValue: _tsumoDetail,
            onChanged: (i) => setState(() => _tsumoDetail = i),
          ),
          const SizedBox(height: 24),
          Text("オプション", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ScoreOptionDora(
                doraCount: _doraCount,
                onPressedRemove: _onPressedRemove,
                onPressedAdd: _onPressedAdd,
              ),
              ScoreOptionIppatsu(
                enabled: _reachGroup != 0,
                value: _ippatsu,
                onChanged: _onCheacked
              )
            ],
          )
        ],
      );
    } else if (widget.flagRon) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreToggle(
            title: "リーチ系",
            label0: "なし",
            label1: "リーチ",
            label2: "ダブルリーチ",
            groupValue: _reachGroup,
            onChanged: (i) => setState(() {
              _reachGroup = i;
              if (_reachGroup == 0) _ippatsu = false;
            })
          ),
          const SizedBox(height: 24),
          ScoreToggle(
            title: "ロン系",
            label0: "なし",
            label1: "河底",
            label2: "槍槓",
            groupValue: _ronDetail,
            onChanged: (i) => setState(() => _ronDetail = i),
          ),
          const SizedBox(height: 24),
          Text("オプション", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ScoreOptionDora(
                doraCount: _doraCount,
                onPressedRemove: _onPressedRemove,
                onPressedAdd: _onPressedAdd,
              ),
              ScoreOptionIppatsu(
                enabled: _reachGroup != 0,
                value: _ippatsu,
                onChanged: _onCheacked
              )
            ],
          )
        ],
      );
    } else {
      content = const Center(
        child: Text(
          "ロンかツモボタンを押してください",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: content
    );
  }
}