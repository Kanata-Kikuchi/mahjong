import 'package:flutter/material.dart';
import 'package:mahjong/page_a/models/score_detail.dart';
import 'package:mahjong/page_a/page_a.dart';
import 'package:mahjong/page_b/models/game.dart';
import 'package:mahjong/page_b/models/player.dart';
import 'package:mahjong/page_b/page_b.dart';
import 'package:mahjong/page_b/widgets/cal_popup.dart';


class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  int index = 0;
  ScoreDetail? detail;
  int _roundNumber = 0; // ０ ～ １１.
  int _gameStick = 0; // 本場.
  int _reachStick = 0; // 供託.

  final players = [
    Player(name: "Aさん", index: 0, zikaze: 0, score: 25000),
    Player(name: "Bさん", index: 1, zikaze: 1, score: 25000),
    Player(name: "Cさん", index: 2, zikaze: 2, score: 25000),
    Player(name: "Dさん", index: 3, zikaze: 3, score: 25000)
  ];


  Game get _game => Game(
    gameStick: _gameStick,
    reachStick: _reachStick,
    scoreBottom: players[0].score,
    scoreRight: players[1].score,
    scoreTop: players[2].score,
    scoreLeft: players[3].score
  );

  String _round(int i) {
    List<String> bakaze = ["東", "南", "西"];
    String game = "";
    int kyoku = 1;

    if (i >= 0 && i < 4) {
      game = bakaze[0];
      kyoku = (i % 4) + 1;
    } else if (i >= 4 && i < 8) {
      game = bakaze[1];
      kyoku = (i % 4) + 1;
    } else if (i >= 8 && i < 12) {
      game = bakaze[2];
      kyoku = (i % 4) + 1;
    } else {return "終局";}

    return "$game $kyoku 局";
  }

  void _roundProgress() { // 流局時と、親以外があがったら.
    setState(() {
      _roundNumber += 1;
      if (_roundNumber > 11) {_roundNumber = 0;}

      for (int i = 0; i < players.length; i++) {
        players[i].zikaze = (players[i].zikaze -= 1) % 4; // 自風の入れ替わり.
      }
    });
  }

  void _onPressedOkuru(ScoreDetail d) {
    detail = d;
  }

  void _onPressedDraw(List<List<int>>? drawResult) { // 流局時の点数分配と局進行.
    if (drawResult != null) {
      for (int i = 0; i < players.length; i++) {
        if (drawResult[0].contains(i)) { // ０１２３リーチindex.
          setState(() => players[i].score -= 1000); // リーチ棒.
        }
      }
      final tenpai = drawResult[1].length;
      int tenpaiScore;
      int noTenpaiScore;
      if (tenpai == 1) {tenpaiScore = 3000; noTenpaiScore = 1000;}
      else if (tenpai == 2) {tenpaiScore = 1500; noTenpaiScore = 1500;}
      else if (tenpai == 3) {tenpaiScore = 1000; noTenpaiScore = 3000;}
      else {tenpaiScore = 0; noTenpaiScore = 0;}

      for (int i = 0; i < players.length; i++) {
        if (drawResult[1].contains(i + 4)) { // ５６７８聴牌index.
          setState(() => players[i].score += tenpaiScore);
        } else {
          setState(() => players[i].score -= noTenpaiScore);
        }
      }

      final bufReachStick = drawResult[0].length;
      setState(() { // 本場の管理.
       _gameStick += 1;
       _reachStick += bufReachStick;
      });

      final oya = players
          .where((w) => w.zikaze == 0)
          .map((m) => (m.index + 4)).first; // 聴牌indexが５６７８だから＋４.

      if (!drawResult[1].contains(oya)) {_roundProgress();} // 親がノーテンなら.
    }
  }

  void _closedCalPopup((int i, int k, int u, List<int>? s)? r) {
    if (r != null) {
      print("keisa");
      final winner = detail!.zikaze; // 誰がアガリか.
      final reachPlayer = r.$4 != null ? r.$4!.length : 0; // このアガリのリーチ棒数.
      final flag = detail!.flagRon ? 300 : 100; // ロンなら３００点、ツモなら１００点.
      final honba = _gameStick * flag; // 本場.
      final kyoutaku = (_reachStick + reachPlayer) * 1000 + (_gameStick * flag); // リーチ棒＋本場.

      // ロンアガリ.
      if (r.$1 == 0) { // (0, score, playersMap.keys.singleWhere((w) => playersMap[w] == notWinnerPlayer[_selected.first]), _selectedReach.isNotEmpty ? _selectedReach.toList() : null).
        setState(() {
          players.firstWhere((w) => w.zikaze == winner).score += r.$2 + kyoutaku;
          players.firstWhere((w) => w.index == r.$3).score -= r.$2 + honba; //$3はPlayerのindexに相当.
        });
      }
      // 親のツモアガリ.
      else if (r.$1 == 1) { // (1, childrenScore, 0, _selectedReach.isNotEmpty ? _selectedReach.toList() : null).
        setState(() {
          players.firstWhere((w) => w.zikaze == 0).score += (r.$2 * 3) + kyoutaku;
          players.where((w) => w.zikaze != 0).forEach((e) => e.score -= r.$2 + honba);
        });
      }
      // 子のツモアガリ.
      else { // (2, childScore, hostScore, _selectedReach.isNotEmpty ? _selectedReach.toList() : null).
        setState(() {
          players.firstWhere((w) => w.zikaze == winner).score += (r.$2 * 2) + r.$3 + kyoutaku;
          players.firstWhere((w) => w.zikaze == 0).score -= r.$3 + honba;
          players.where((w) => w.zikaze != 0 && w.zikaze != winner).forEach((e) => e.score -= r.$2 + honba);
        });
      }

      setState(() { // リーチ棒のリセット.
        if (r.$4 != null) {
          for (int i in r.$4!) { // リーチした人から１０００点引く.
            players.firstWhere((w) => w.index == i).score -= 1000;
            print("${r.$4} $i");
          }
        }
        _reachStick = 0;
      });

      if (winner != 0) { // 親以外がアガリ.
        setState(() {
          _gameStick = 0; // 本場のリセット.
        });
        _roundProgress();
      }
    }
  }

  void _onChangedPage() {
    setState(() => index = 1); // 表示切替.

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final r = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CalPopup(
          round: _round(_roundNumber),
          roundNumber: _roundNumber,
          detail: detail,
          players: players
        )
      );
      _closedCalPopup(r);
    });
  }

  @override
  Widget build(BuildContext context) {

    final pages = [
      PageA(
        onPressedOkuru: _onPressedOkuru,
        onChangedPage: _onChangedPage
      ),
      PageB(
        round: _round(_roundNumber),
        game: _game,
        players: players,
        onPressedDraw: _onPressedDraw,
      )
    ];
    
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            minWidth: 50,
            selectedIndex: index,
            onDestinationSelected: (i) => setState(() => index=i),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.looks_one),
                label: Text('Page1'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.looks_two),
                label: Text('Page2'),
              ),
            ],
            backgroundColor: Colors.lightGreen,
          ),

          Expanded(
            child: IndexedStack(
              index: index,
              children: pages,
            ),
          )
          
        ],
      ),
    );
  }
}