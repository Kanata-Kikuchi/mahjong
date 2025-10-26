import 'package:flutter/material.dart';
import 'package:mahjong/data/yaku_list.dart';
import 'package:mahjong/models/score_detail.dart';
import 'package:mahjong/models/yaku.dart';

class ScoreCalculator extends StatelessWidget {
  ScoreCalculator({
    required this.agariCal,
    required this.flagRon,
    required this.flagTsumo,
    required this.flagNaki,
    required this.detail,
    required this.agarihai,
    required this.agariDetail,
    super.key
  }) {
    yakuFlag = {
      "平和": (() {
        final melds = agariCal.map((m) => m.$2).toSet(); // meldでsetを作る.
        return melds.length == 2 && melds.contains(0); // meld == 0(順子)が含まれて、順子と単騎だけの構成か.
      })(),
      "断么九": agariCal.every((e) {
        if (e.$1.$1 == 3 || e.$1.$2 == 0 || e.$1.$2 == 8) {return false;} // 字牌と1・9スタートは除外.
        if (e.$1.$2 == 6 && (e.$2 == 0 || e.$2 == 2)) {return false;} // 789を除外.
        return true;
      }),
      "役牌": agariCal.any((a) => a.$1.$1 == 3), // 自風・場風まだ.
      "一盃口": (() {
        final melds = agariCal.where((w) => w.$2 == 0); // 順子で.
        return melds.toSet().length == melds.length - 1; // toSet()で個数が1減れば.
      })(),
      "三色同順": (() {
        final melds = agariCal.where((w) => (w.$2 == 0 || w.$2 == 2)); // 順子とチーで.
        final tileStart = melds.map((m) => m.$1.$2).toSet(); // 起点tileを抜き出し.
        return tileStart.any((a) {
          final suits = melds
              .where((w) => w.$1.$2 == a) // 抜き出した起点で.
              .map((m) => m.$1.$1) // typeだけを取り出して.
              .toSet();
          return suits.containsAll({0, 1, 2});
        });
      })(),
      "三色同刻": (() {
        final melds = agariCal.where((w) => (w.$2 != 0 && w.$2 != 2)); // 暗刻とポンと暗槓と明槓で.
        final tileStart = melds.map((m) => m.$1.$2).toSet(); // 起点tileを抜き出し.
        return tileStart.any((a) {
          final suits = melds
              .where((w) => w.$1.$2 == a) // 抜き出した起点で.
              .map((m) => m.$1.$1) // typeだけを取り出して.
              .toSet();
          return suits.containsAll({0, 1, 2});
        });
      })(),
      "一気通貫": (() {
        final melds = agariCal.where((w) => (w.$2 == 0 || w.$2 == 2)); // 順子とチーで.
        final types = melds.map((m) => m.$1.$1).toSet(); // typeを抜き出し.
        return types.any((a) {
          final suits = melds
              .where((w) => w.$1.$1 == a) // 抜き出したtypeで.
              .map((m) => m.$1.$2) // tileだけを取り出して.
              .toSet();
          return suits.containsAll({0, 3, 6});
        });
      })(),
      "対々和": agariCal.every((e) => (e.$2 != 0 && e.$2 != 2)),
      "三暗刻": (() {
        final melds = agariCal.where((w) => (w.$2 == 1 || w.$2 == 4)); // 暗刻と暗槓で.
        return melds.length == 3;
      })(),
      "三槓子": (() {
        final melds = agariCal.where((w) => (w.$2 == 4 || w.$2 == 5)); // 暗槓と明槓で.
        return melds.length == 3;
      })(),
      "全帯么": (() {
        final types = agariCal.map((m) => m.$1.$1).toSet(); // typeを抜き出し.
        final melds = agariCal.map((m) => m.$2).toSet(); // meldsを抜き出し.
        if (!melds.contains(0) && !melds.contains(2)) {return false;} // 混老頭回避.
        if (types.contains(3)) {
          return agariCal.every((e) {
            if (e.$1.$1 == 3) {return true;}
            if ({1, 2, 3, 4, 5, 7}.contains(e.$1.$2)) {return false;} // tileが7を除く2~8なら.
            if (e.$1.$2 == 6 && (e.$2 != 0 && e.$2 != 2)) {return false;} // tileが7で順子とチー以外のとき.
            return true;
          });
        }
        return false;
      })(),
      "混老頭": (() {
        final types = agariCal.map((m) => m.$1.$1).toSet();
        final melds = agariCal.map((m) => m.$2).toSet();
        if (!types.contains(3)) {return false;} // 字牌が含まれていなかったら.
        if (melds.contains(0) || melds.contains(2)) {return false;} // 順子とチーが含まれていたら.
        final suits = agariCal
            .where((w) => w.$1.$1 != 3) // 字牌以外で.
            .map((m) => m.$1.$2) // tileを抜き出だして.
            .toSet();
        return suits.every((e) => e == 0 || e == 8);
      })(),
      "小三元": (() {
        final types = agariCal
            .where((w) => w.$1.$1 == 3) // 字牌で.
            .where((w) => (w.$1.$2 == 4 || w.$1.$2 == 5 || w.$1.$2 == 6)); // 白・発・中で.
        if (types.length != 3) {return false;} // 白・発・中が全部あれば.
        return types.any((a) {
          return a.$2 == 6; // 大三元回避.
        });
      })(),
      "七対子": agariCal.length == 7,
      "二盃口": (() {
        final melds = agariCal.where((w) => w.$2 == 0); // 順子で.
        if (melds.length != 4) {return false;}
        final typeTile = melds.map((m) => (m.$1.$1, m.$1.$2)).toList();
        if (typeTile.every((e) => e == typeTile.first)) {return true;} // 全てが同一なら.
        final tileStart = typeTile.toSet().toList();
        return tileStart.length == 2
            && typeTile.where((e) => e == tileStart[0]).length == 2
            && typeTile.where((e) => e == tileStart[1]).length == 2;
      })(),
      "混一色": (() {
        final types = agariCal.map((m) => m.$1.$1).toSet(); // typeで.
        return types.length == 2 && types.contains(3); // typeが2種類で、字牌が含まれていれば.
      })(),
      "純全帯么九": (() {
        final types = agariCal.map((m) => m.$1.$1).toSet(); // typeを抜き出し.
        final melds = agariCal.map((m) => m.$2).toSet(); // meldsを抜き出し.
        if (!melds.contains(0) && !melds.contains(2)) {return false;} // 清老頭回避.
        if (!types.contains(3)) {
          return agariCal.every((e) {
            if ({1, 2, 3, 4, 5, 7}.contains(e.$1.$2)) {return false;} // tileが7を除く2~8なら.
            if (e.$1.$2 == 6 && (e.$2 != 0 && e.$2 != 2)) {return false;} // tileが7で順子とチー以外のとき.
            return true;
          });
        }
        return false;
      })(),
      "清一色": (() {
        final types = agariCal.map((m) => m.$1.$1).toSet(); // typeで.
        return types.length == 1 && !types.contains(3); // typeが1種類で、字牌じゃなければ.
      })()
    };
  }

  final List<((int type, int tile), int meld)> agariCal;
  bool flagRon;
  bool flagTsumo;
  bool flagNaki;
  ScoreDetail detail;
  List<(int type, int tile)> agarihai;
  int? agariDetail;

  // 深いコピー.
  final List<Yaku> yaku = yakuList
      .map((y) => Yaku(
        name: y.name,
        hanClosed: y.hanClosed,
        hanOpened: y.hanOpened,
        selected: false
      ))
      .toList();

  late final Map<String, bool> yakuFlag; // コンストラクタで代入.

  @override
  Widget build(BuildContext context) {

    if (yakuFlag["七対子"] ?? false) { // ７ブロック.
      yaku.firstWhere((i) => i.name == "七対子").selected = true;
      if (yakuFlag["断么九"] ?? false) {
        yaku.firstWhere((i) => i.name == "断么九").selected = true;
      }
      if (yakuFlag["全帯么"] ?? false) {
        yaku.firstWhere((i) => i.name == "全帯么").selected = true;
      }
      if (yakuFlag["混老頭"] ?? false) {
        yaku.firstWhere((i) => i.name == "混老頭").selected = true;
      }
      if (yakuFlag["混一色"] ?? false) {
        yaku.firstWhere((i) => i.name == "混一色").selected = true;
      }
      if (yakuFlag["純全帯么九"] ?? false) {
        yaku.firstWhere((i) => i.name == "純全帯么九").selected = true;
      }
      if (yakuFlag["清一色"] ?? false) {
        yaku.firstWhere((i) => i.name == "清一色").selected = true;
      }
    } else { // ５ブロック.
      if (yakuFlag["平和"] ?? false) {
        yaku.firstWhere((i) => i.name == "平和").selected = true;
      }
      if (yakuFlag["断么九"] ?? false) {
        yaku.firstWhere((i) => i.name == "断么九").selected = true;
      }
      if (yakuFlag["役牌"] ?? false) {
        yaku.firstWhere((i) => i.name == "役牌").selected = true;
      }
      if (yakuFlag["一盃口"] ?? false) {
        yaku.firstWhere((i) => i.name == "一盃口").selected = true;
      }
      if (yakuFlag["三色同順"] ?? false) {
        yaku.firstWhere((i) => i.name == "三色同順").selected = true;
      }
      if (yakuFlag["三色同刻"] ?? false) {
        yaku.firstWhere((i) => i.name == "三色同刻").selected = true;
      }
      if (yakuFlag["一気通貫"] ?? false) {
        yaku.firstWhere((i) => i.name == "一気通貫").selected = true;
      }
      if (yakuFlag["対々和"] ?? false) {
        yaku.firstWhere((i) => i.name == "対々和").selected = true;
      }
      if (yakuFlag["三暗刻"] ?? false) {
        yaku.firstWhere((i) => i.name == "三暗刻").selected = true;
      }
      if (yakuFlag["三槓子"] ?? false) {
        yaku.firstWhere((i) => i.name == "三槓子").selected = true;
      }
      if (yakuFlag["全帯么"] ?? false) {
        yaku.firstWhere((i) => i.name == "全帯么").selected = true;
      }
      if (yakuFlag["混老頭"] ?? false) {
        yaku.firstWhere((i) => i.name == "混老頭").selected = true;
      }
      if (yakuFlag["小三元"] ?? false) {
        yaku.firstWhere((i) => i.name == "小三元").selected = true;
      }
      if (yakuFlag["二盃口"] ?? false) {
        yaku.firstWhere((i) => i.name == "二盃口").selected = true;
      }
      if (yakuFlag["混一色"] ?? false) {
        yaku.firstWhere((i) => i.name == "混一色").selected = true;
      }
      if (yakuFlag["純全帯么九"] ?? false) {
        yaku.firstWhere((i) => i.name == "純全帯么九").selected = true;
      }
      if (yakuFlag["清一色"] ?? false) {
        yaku.firstWhere((i) => i.name == "清一色").selected = true;
      }
    }

    List<int> yakuOpened = []; // 翻数の計算に使う.
    List<int> yakuColsed = []; // 翻数の計算に使う.
    int sumHanScore = 0;
    int sumFuScore = 0;
    bool flagYakunashi = false;

    // 翻数計算.
    if (flagNaki) { // 鳴き.
      yakuOpened = yaku
          .where((w) => w.selected == true)
          .map((m) => m.hanOpened)
          .toList();

      if (flagRon) { // ロンなら.
        if (detail.ron == 1) { // 河底.
          yaku.firstWhere((i) => i.name == "河底").selected = true;
          yakuOpened.add(1);
        } else if (detail.ron == 2) { // 槍槓.
          yaku.firstWhere((i) => i.name == "槍槓").selected = true;
          yakuOpened.add(1);
        }
      } else if (flagTsumo) { // ツモなら.
        if (detail.tsumo == 1) { // 海底.
          yaku.firstWhere((i) => i.name == "海底").selected = true;
          yakuOpened.add(1);
        } else if (detail.tsumo == 2) { // 嶺上開花.
          yaku.firstWhere((i) => i.name == "嶺上開花").selected = true;
          yakuOpened.add(1);
        }
      }

      if (yaku.where((w) => w.selected == true).length == 0) { // 役無しチェック.
        flagYakunashi = true;
      }

      if (!flagYakunashi && detail.dora != 0) { // ドラ.
        yaku.firstWhere((i) => i.name == "ドラ").selected = true;
        yaku.firstWhere((i) => i.name == "ドラ").hanOpened = detail.dora;
        yakuOpened.add(detail.dora);
      }

      sumHanScore = yakuOpened.fold(0, (s, f) => s + f); // 合計翻数.
    }
    else if (!flagNaki) { // 面前.
      yakuColsed = yaku
          .where((w) => w.selected == true)
          .map((m) => m.hanClosed)
          .toList();

      if (detail.reach == 1) { // リーチ.
        yaku.firstWhere((i) => i.name == "リーチ").selected = true;
        yakuColsed.add(1);
      } else if (detail.reach == 2) { // ダブリー.
        yaku.firstWhere((i) => i.name == "ダブルリーチ").selected = true;
        yakuColsed.add(2);
      }

      if (flagRon) { // ロンなら.
        if (detail.ron == 1) { // 河底.
          yaku.firstWhere((i) => i.name == "河底").selected = true;
          yakuColsed.add(1);
        } else if (detail.ron == 2) { // 槍槓.
          yaku.firstWhere((i) => i.name == "槍槓").selected = true;
          yakuColsed.add(1);
        }
      } else if (flagTsumo) { // ツモなら.
        if (detail.tsumo == 1) { // 海底.
          yaku.firstWhere((i) => i.name == "海底").selected = true;
          yakuColsed.add(1);
        } else if (detail.tsumo == 2) { // 嶺上開花.
          yaku.firstWhere((i) => i.name == "嶺上開花").selected = true;
          yakuColsed.add(1);
        }
      }

      if (detail.ippatsu) { // 一発.
        yaku.firstWhere((i) => i.name == "一発").selected = true;
        yakuColsed.add(1);
      }

      if (yaku.where((w) => w.selected == true).length == 0) { // 役無しチェック.
        flagYakunashi = true;
      }

      if (!flagYakunashi && detail.dora != 0) { // ドラ.
        yaku.firstWhere((i) => i.name == "ドラ").selected = true;
        yaku.firstWhere((i) => i.name == "ドラ").hanClosed = detail.dora;
        yakuColsed.add(detail.dora);
      }

      sumHanScore = yakuColsed.fold(0, (s, f) => s + f); // 合計翻数.
    }

    // 符計算.
    if (flagNaki) { // 鳴き.

      agarihai[agariDetail!];

      sumFuScore += 20;
      if (flagTsumo) {sumFuScore += 2;}
      final scoreMeld = agariCal
          .map((m) => m.$2)
          .toList();
      
    }
    else if (!flagNaki) { // 面前.

    }

    

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "役一覧",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          flagYakunashi
          ? Text(
            "役無し",
            style: TextStyle(fontSize: 18, color: Colors.black54)
            )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: yaku
                .where((w) => w.selected)
                .map((m) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        m.name,
                        style: TextStyle(fontSize: 16),
                      )
                    ),
                    flagNaki // 鳴きか面前か.
                      ? Expanded(
                          flex: 1,
                          child: Text(
                            "${m.hanOpened} 翻",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          )
                        )
                      : Expanded(
                          flex: 1,
                          child: Text(
                            "${m.hanClosed} 翻",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          )
                        )
                  ],
                ))
                .toList(),
          ),
          Divider(height: 24),
          Text(
            "点数",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            flagYakunashi // 鳴きか面前か.
              ? "役無し"
              : "8000 点 $sumHanScore 翻 40 符",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

