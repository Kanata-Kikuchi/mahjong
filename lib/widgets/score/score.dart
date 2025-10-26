import 'package:flutter/material.dart';
import 'package:mahjong/models/score_detail.dart';
import 'package:mahjong/widgets/score/score_calculator.dart';
import 'package:mahjong/widgets/score/score_detail_agari.dart';
import 'package:mahjong/widgets/score/score_detail_dora.dart';
import 'package:mahjong/widgets/score/score_detail_ippatsu.dart';
import 'package:mahjong/widgets/score/score_detail_toggle.dart';


class Score extends StatefulWidget {
  Score({
    required this.agariCal,
    required this.bufAgari,
    required this.flagRon,
    required this.flagTsumo,
    required this.flagCal,
    super.key
  });

  final List<((int type, int tile), int meld)> agariCal;
  final List<(int type, int tile)> bufAgari;
  bool flagRon;
  bool flagTsumo;
  bool flagCal;

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {

  int _reachDetail = 0; // 0:なし、1:リーチ、2:ダブリー
  int _tsumoDetail = 0; // 0:なし、1:海底、2:嶺上開花
  int _ronDetail = 0; // 0:なし、1:河底、2:槍槓
  int _oyakoDetail= 0; // 0:親、1:子.
  int _doraDetail = 0; // ドラ枚数.
  bool _ippatsuDetail = false; // 一発の有無.
  bool flagNaki = false;
  int? _agariDetail; // アガリ牌.
  List<(int type, int tile)> _agarihai = []; // アガリ選択.



  @override
  Widget build(BuildContext context) {

    bool flagNaki = widget.agariCal.any((a) { // チー・ポン・明槓があれば.
      return a.$2 == 2 || a.$2 == 3 || a.$2 ==5;
    });

    final _detail = ScoreDetail(
      reach: _reachDetail,
      tsumo: _tsumoDetail,
      ron: _ronDetail,
      oyako: _oyakoDetail,
      dora: _doraDetail,
      ippatsu: _ippatsuDetail,
      agari: _agariDetail
    );

    void _onChangedReach(int i) {
      setState(() {
        _reachDetail = i;
        if (_reachDetail == 0) _ippatsuDetail = false;
      });
    }

    void _onChangedTsumo(int i) {
      setState(() => _tsumoDetail = i);
    }

    void _onChangedRon(int i) {
      setState(() => _ronDetail = i);
    }

    void _onChangedOyako(int i) {
      setState(() => _oyakoDetail = i);
    }

    void _onPressedRemove() {
      setState(() => _doraDetail--);
    }

    void _onPressedAdd() {
      setState(() => _doraDetail++);
    }

    void _onCheackedIppatsu(bool? i) {
      setState(() => _ippatsuDetail = i ?? false);
    }
    
    void _onChangedAgari(int? i) {
      setState(() => _agariDetail = i);
    }

    void _selectedAgari(List<(int type, int tile)> i) {
      setState(() => _agarihai = i);
    }

    Widget content;

    if (widget.flagCal) {
      content = ScoreCalculator(
        agariCal: widget.agariCal,
        flagRon: widget.flagRon,
        flagTsumo: widget.flagTsumo,
        flagNaki: flagNaki,
        detail: _detail,
        agarihai: _agarihai,
        agariDetail: _agariDetail
      );
    } else if (widget.flagTsumo) { // ツモが押されたら.
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreToggle(
            title: "リーチ系",
            label0: "なし",
            label1: "リーチ",
            label2: "ダブルリーチ",
            groupValue: _reachDetail,
            onChanged: _onChangedReach,
            flagNaki: flagNaki
          ),
          const SizedBox(height: 16),
          ScoreToggle(
            title: "ツモ系",
            label0: "なし",
            label1: "海底",
            label2: "嶺上開花",
            groupValue: _tsumoDetail,
            onChanged: _onChangedTsumo
          ),
          const SizedBox(height: 16),
          ScoreToggle(
            title: "状況",
            label0: "親",
            label1: "子",
            groupValue: _oyakoDetail,
            onChanged: _onChangedOyako
          ),
          const SizedBox(height: 16),
          Text("オプション", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center, // 縦中央で安定
            children: [
              ScoreOptionDora( // ドラ.
                doraCount: _doraDetail,
                onPressedRemove: _onPressedRemove,
                onPressedAdd: _onPressedAdd,
              ),
              ScoreOptionIppatsu( // 一発.
                enabled: _reachDetail != 0,
                value: _ippatsuDetail,
                onChanged: _onCheackedIppatsu,
              ),
              SizedBox(width: 20),
              ScoreOptionAgari( // アガリ牌.
                bufAgari: widget.bufAgari,
                value: _agariDetail,
                onChanged: _onChangedAgari,
                selectedAgari: _selectedAgari
              )
            ],
          )
        ],
      );
    } else if (widget.flagRon) { // ロンが押されたら.
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScoreToggle(
            title: "リーチ系",
            label0: "なし",
            label1: "リーチ",
            label2: "ダブルリーチ",
            groupValue: _reachDetail,
            onChanged: _onChangedReach,
            flagNaki: flagNaki
          ),
          const SizedBox(height: 16),
          ScoreToggle(
            title: "ロン系",
            label0: "なし",
            label1: "河底",
            label2: "槍槓",
            groupValue: _ronDetail,
            onChanged: _onChangedRon
          ),
          const SizedBox(height: 16),
          ScoreToggle(
            title: "状況",
            label0: "親",
            label1: "子",
            groupValue: _oyakoDetail,
            onChanged: _onChangedOyako
          ),
          const SizedBox(height: 16),
          Text("オプション", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ScoreOptionDora( // ドラ.
                doraCount: _doraDetail,
                onPressedRemove: _onPressedRemove,
                onPressedAdd: _onPressedAdd,
              ),
              ScoreOptionIppatsu( // 一発.
                enabled: _reachDetail != 0,
                value: _ippatsuDetail,
                onChanged: _onCheackedIppatsu
              ),
              SizedBox(width: 20),
              ScoreOptionAgari( // アガリ牌.
                bufAgari: widget.bufAgari,
                value: _agariDetail,
                onChanged: _onChangedAgari,
                selectedAgari: _selectedAgari
              )
            ],
          )
        ],
      );
    } else {
      // リセット.
      _reachDetail = 0;
      _tsumoDetail = 0;
      _ronDetail = 0;
      _oyakoDetail= 0;
      _doraDetail = 0;
      _ippatsuDetail = false;

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