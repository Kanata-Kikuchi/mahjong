import 'package:flutter/material.dart';
import 'package:mahjong/page_a/models/score_detail.dart';
import 'package:mahjong/page_a/widgets/score/score_calculator.dart';
import 'package:mahjong/page_a/widgets/score/score_detail_agari.dart';
import 'package:mahjong/page_a/widgets/score/score_detail_dora.dart';
import 'package:mahjong/page_a/widgets/score/score_detail_ippatsu.dart';
import 'package:mahjong/page_a/widgets/score/score_detail_toggle.dart';


class Score extends StatefulWidget {
  Score({
    required this.agariCal,
    required this.bufAgari,
    required this.flagRon,
    required this.flagTsumo,
    required this.flagCal,
    required this.onDetailChanged,
    super.key
  });

  final List<((int type, int tile), int meld)> agariCal;
  final List<(int type, int tile)> bufAgari;
  bool flagRon;
  bool flagTsumo;
  bool flagCal;
  void Function(ScoreDetail) onDetailChanged; // アガリ状況のコールバック.

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {

  int _reachDetail = 0; // 0:なし、1:リーチ、2:ダブリー
  int _tsumoDetail = 0; // 0:なし、1:海底、2:嶺上開花
  int _ronDetail = 0; // 0:なし、1:河底、2:槍槓
  int _bakazeDetail = 0; // 0:東場、1:南場、2:西場.
  int _oyakoDetail= 0; // 0:東家、1:南家、2:西家、3:北家.
  int _doraDetail = 0; // ドラ枚数.
  bool _ippatsuDetail = false; // 一発の有無.
  bool flagNaki = false;
  bool flagKan = false;
  int? _agariDetail; // アガリ牌.
  int? _score;
  List<(int type, int tile)> _colectedAgarihai = []; // アガリ選択.

  double sizeBoxSpace = 5;

  ScoreDetail get _detail => ScoreDetail(
    reach: _reachDetail,
    tsumo: _tsumoDetail,
    ron: _ronDetail,
    bakaze: _bakazeDetail,
    zikaze: _oyakoDetail,
    dora: _doraDetail,
    ippatsu: _ippatsuDetail,
    agari: _agariDetail,
    score: _score,
    flagRon: widget.flagRon,
    flagTsumo: widget.flagTsumo
  );

  void _helper() => widget.onDetailChanged(_detail); // 念のためアクションごとに呼ぶ.

  @override
  Widget build(BuildContext context) {

    flagNaki = widget.agariCal.any((a) { // チー・ポン・明槓があれば.
      return a.$2 == 2 || a.$2 == 3 || a.$2 ==5;
    });

    flagKan = widget.agariCal.any((a) { // 槓があれば.
      return a.$2 == 4 || a.$2 == 5;
    });

    void sendScore(int score) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _score = score);
      });
      _helper();
    }

    void _onChangedReach(int i) {
      setState(() {
        _reachDetail = i;
        if (_reachDetail == 0) _ippatsuDetail = false;
      });
      _helper();
    }

    void _onChangedTsumo(int i) {
      setState(() => _tsumoDetail = i);
      _helper();
    }

    void _onChangedRon(int i) {
      setState(() => _ronDetail = i);
      _helper();
    }

    void _onChangedBakaze(int i) {
      setState(() => _bakazeDetail = i);
      _helper();
    }

    void _onChangedOyako(int i) {
      setState(() => _oyakoDetail = i);
      _helper();
    }

    void _onPressedRemove() {
      setState(() => _doraDetail--);
      _helper();
    }

    void _onPressedAdd() {
      setState(() => _doraDetail++);
      _helper();
    }

    void _onCheackedIppatsu(bool? i) {
      setState(() => _ippatsuDetail = i ?? false);
      _helper();
    }
    
    void _onChangedAgari(int? i) {
      setState(() => _agariDetail = i);
      _helper();
    }

    void _colectedAgari(List<(int type, int tile)> i) {
      setState(() => _colectedAgarihai = i);
      _helper();
    }

    Widget content;

    if (widget.flagCal) {
      if (_detail.agari == null) {
        content = Center(
          child: Text("アガリ牌を選択してください"),
        );
      } else {
        content = ScoreCalculator(
          agariCal: widget.agariCal,
          flagRon: widget.flagRon,
          flagTsumo: widget.flagTsumo,
          flagNaki: flagNaki,
          detail: _detail,
          colectedAgarihai: _colectedAgarihai,
          sendScore: sendScore,
        );
      }
    } else if (widget.flagTsumo) { // ツモが押されたら.
      content = SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flagNaki // 鳴いていたら.
              ? ScoreDetailToggle(
                  title: "リーチ系",
                  label0: "なし",
                  groupValue: _reachDetail,
                  onChanged: _onChangedReach,
                )
              : ScoreDetailToggle(
                  title: "リーチ系",
                  label0: "なし",
                  label1: "リーチ",
                  label2: "ダブルリーチ",
                  groupValue: _reachDetail,
                  onChanged: _onChangedReach,
                ),
              SizedBox(height: sizeBoxSpace),
              flagKan // 槓されていたら.
              ? ScoreDetailToggle(
                  title: "ツモ系",
                  label0: "なし",
                  label1: "海底",
                  label2: "嶺上開花",
                  groupValue: _tsumoDetail,
                  onChanged: _onChangedTsumo,
                )
              : ScoreDetailToggle(
                  title: "ツモ系",
                  label0: "なし",
                  label1: "海底",
                  groupValue: _tsumoDetail,
                  onChanged: _onChangedTsumo,
                ),
              SizedBox(height: sizeBoxSpace),
              ScoreDetailToggle(
                title: "場風",
                label0: "東場",
                label1: "南場",
                label2: "西場",
                groupValue: _bakazeDetail,
                onChanged: _onChangedBakaze
              ),
              SizedBox(height: sizeBoxSpace),
              ScoreDetailToggle(
                title: "自風",
                label0: "東家",
                label1: "南家",
                label2: "西家",
                label3: "北家",
                groupValue: _oyakoDetail,
                onChanged: _onChangedOyako
              ),
              SizedBox(height: sizeBoxSpace),
              Text("オプション", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center, // 縦中央で安定
                children: [
                  ScoreDetailDora( // ドラ.
                    doraCount: _doraDetail,
                    onPressedRemove: _onPressedRemove,
                    onPressedAdd: _onPressedAdd,
                  ),
                  ScoreDetailIppatsu( // 一発.
                    enabled: _reachDetail != 0,
                    value: _ippatsuDetail,
                    onChanged: _onCheackedIppatsu,
                  ),
                  SizedBox(width: 20),
                  ScoreDetailAgari( // アガリ牌.
                    bufAgari: widget.bufAgari,
                    value: _agariDetail,
                    onChanged: _onChangedAgari,
                    colectedAgari: _colectedAgari
                  )
                ],
              )
            ],
          )
        )
      );
    } else if (widget.flagRon) { // ロンが押されたら.
      content = SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flagNaki
              ? ScoreDetailToggle(
                  title: "リーチ系",
                  label0: "なし",
                  groupValue: _reachDetail,
                  onChanged: _onChangedReach,
                )
              : ScoreDetailToggle(
                  title: "リーチ系",
                  label0: "なし",
                  label1: "リーチ",
                  label2: "ダブルリーチ",
                  groupValue: _reachDetail,
                  onChanged: _onChangedReach,
                ),
              SizedBox(height: sizeBoxSpace),
              ScoreDetailToggle(
                title: "ロン系",
                label0: "なし",
                label1: "河底",
                label2: "槍槓",
                groupValue: _ronDetail,
                onChanged: _onChangedRon
              ),
              SizedBox(height: sizeBoxSpace),
              ScoreDetailToggle(
                title: "場風",
                label0: "東場",
                label1: "南場",
                label2: "西場",
                groupValue: _bakazeDetail,
                onChanged: _onChangedBakaze
              ),
              SizedBox(height: sizeBoxSpace),
              ScoreDetailToggle(
                title: "自風",
                label0: "東家",
                label1: "南家",
                label2: "西家",
                label3: "北家",
                groupValue: _oyakoDetail,
                onChanged: _onChangedOyako
              ),
              SizedBox(height: sizeBoxSpace),
              Text("オプション", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScoreDetailDora( // ドラ.
                    doraCount: _doraDetail,
                    onPressedRemove: _onPressedRemove,
                    onPressedAdd: _onPressedAdd,
                  ),
                  ScoreDetailIppatsu( // 一発.
                    enabled: _reachDetail != 0,
                    value: _ippatsuDetail,
                    onChanged: _onCheackedIppatsu
                  ),
                  SizedBox(width: 20),
                  ScoreDetailAgari( // アガリ牌.
                    bufAgari: widget.bufAgari,
                    value: _agariDetail,
                    onChanged: _onChangedAgari,
                    colectedAgari: _colectedAgari
                  )
                ],
              )
            ],
          )
        )
      );
    } else {
      // リセット.
      _reachDetail = 0;
      _tsumoDetail = 0;
      _ronDetail = 0;
      _bakazeDetail = 0;
      _oyakoDetail= 0;
      _doraDetail = 0;
      _ippatsuDetail = false;
      _agariDetail = null;

      content = const Center(
        child: Text(
          "アガリ形を選択してください",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: content
    );
  }
}