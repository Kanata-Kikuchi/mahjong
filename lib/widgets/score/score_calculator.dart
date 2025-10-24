import 'package:flutter/material.dart';
import 'package:mahjong/data/yaku_list.dart';
import 'package:mahjong/models/yaku.dart';

class ScoreCalculator extends StatelessWidget {
  ScoreCalculator({
    required this.flagRon,
    required this.flagTsumo,
    required this.agariCal,
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
        if (melds.toSet().length == 1) {return true;} // 全てが同一の順子なら.
        return melds.toSet().length == melds.length - 2; // toSet()で個数が2減れば.
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

  bool flagRon;
  bool flagTsumo;
  final List<((int type, int tile), int meld)> agariCal;

  // 深いコピー.
  final List<Yaku> yaku = yakuList
      .map((y) => Yaku(
        name: y.name,
        hanClosed: y.hanClosed,
        hanOpen: y.hanOpen,
        selected: false
      ))
      .toList();

  late final Map<String, bool> yakuFlag; // コンストラクタで代入.

  @override
  Widget build(BuildContext context) {

    List<Yaku> agariYaku = [];

    if (yakuFlag["七対子"] ?? false) {
      agariYaku.add(yaku.firstWhere((i) => i.name == "七対子"));
      if (yakuFlag["断么九"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "断么九"));
      }
      if (yakuFlag["全帯么"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "全帯么"));
      }
      if (yakuFlag["混老頭"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "混老頭"));
      }
      if (yakuFlag["混一色"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "混一色"));
      }
      if (yakuFlag["純全帯么九"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "純全帯么九"));
      }
      if (yakuFlag["清一色"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "清一色"));
      }
    } else {
      if (yakuFlag["平和"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "平和"));
      }
      if (yakuFlag["断么九"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "断么九"));
      }
      if (yakuFlag["役牌"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "役牌"));
      }
      if (yakuFlag["一盃口"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "一盃口"));
      }
      if (yakuFlag["三色同順"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "三色同順"));
      }
      if (yakuFlag["三色同刻"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "三色同刻"));
      }
      if (yakuFlag["一気通貫"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "一気通貫"));
      }
      if (yakuFlag["対々和"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "対々和"));
      }
      if (yakuFlag["三暗刻"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "三暗刻"));
      }
      if (yakuFlag["三槓子"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "三槓子"));
      }
      if (yakuFlag["全帯么"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "全帯么"));
      }
      if (yakuFlag["混老頭"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "混老頭"));
      }
      if (yakuFlag["小三元"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "小三元"));
      }
      if (yakuFlag["二盃口"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "二盃口"));
      }
      if (yakuFlag["混一色"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "混一色"));
      }
      if (yakuFlag["純全帯么九"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "純全帯么九"));
      }
      if (yakuFlag["清一色"] ?? false) {
        agariYaku.add(yaku.firstWhere((i) => i.name == "清一色"));
      }
    }
    
    
    List<String> test = agariYaku.map((m) => m.name).toList();

    return Center(
      child: Text(
        "agariYaku : $test",
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
    );
  }
}


