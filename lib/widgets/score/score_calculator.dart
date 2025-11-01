import 'package:flutter/material.dart';
import 'package:mahjong/data/yaku_list.dart';
import 'package:mahjong/models/meld_tiles.dart';
import 'package:mahjong/models/score_detail.dart';
import 'package:mahjong/models/yaku.dart';

class ScoreCalculator extends StatelessWidget {
  ScoreCalculator({
    required this.agariCal,
    required this.flagRon,
    required this.flagTsumo,
    required this.flagNaki,
    required this.detail,
    required this.colectedAgarihai,
    super.key
  }) {
    yakuFlag = { // 役ロジック.
      "ツモ": flagTsumo && !flagNaki,
      "平和": (() {
        final melds = agariCal.map((m) => m.$2).toSet(); // meldでsetを作る.
        if (melds.length == 2 && melds.contains(0)) { // meld == 0(順子)が含まれて、順子と単騎だけの構成か.
          final keyPinhu = colectedAgarihai[detail.agari!];
          final startRyanmen = agariCal.where((w) => w.$2 == 0).map((m) => (m.$1.$1, m.$1.$2));
          final endRyanmen = agariCal.where((w) => w.$2 == 0).map((m) => (m.$1.$1, m.$1.$2 + 2));
          if (keyPinhu.$2 == 2) { // アガリ牌が３.
            return startRyanmen.contains(keyPinhu); // ３４５があれば.
          } else if (keyPinhu.$2 == 6) { // アガリ牌が７.
            return endRyanmen.contains(keyPinhu); // ５６７があれば.
          }
          return startRyanmen.contains(keyPinhu) || endRyanmen.contains(keyPinhu);
        }
        return false;
      })(),
      "断么九": agariCal.every((e) {
        if (e.$1.$1 == 3 || e.$1.$2 == 0 || e.$1.$2 == 8) {return false;} // 字牌と1・9スタートは除外.
        if (e.$1.$2 == 6 && (e.$2 == 0 || e.$2 == 2)) {return false;} // 789を除外.
        return true;
      }),
      "一盃口": (() {
        final melds = agariCal.where((w) => w.$2 == 0); // 順子で.
        return melds.toSet().length == melds.length - 1; // toSet()で個数が1減れば.
      })(),
      "東": (() {
        final ton = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 0 && w.$2 != 6);
        if (ton.contains(detail.bakaze)) { // ダブ東回避.
          return !ton.contains(detail.zikaze);
        } else if (!ton.contains(detail.bakaze)) {
          return ton.contains(detail.zikaze);
        }
        return false;
      })(),
      "南": (() {
        final nan = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 1 && w.$2 != 6);
        if (nan.contains(detail.bakaze)) { // ダブ南回避.
          return !nan.contains(detail.zikaze);
        } else if (!nan.contains(detail.bakaze)) {
          return nan.contains(detail.zikaze);
        }
        return false;
      })(),
      "西": (() {
        final sya = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 2 && w.$2 != 6);
        if (sya.contains(detail.bakaze)) { // ダブ西回避.
          return !sya.contains(detail.zikaze);
        } else if (!sya.contains(detail.bakaze)) {
          return sya.contains(detail.zikaze);
        }
        return false;
      })(),
      "北": (() {
        final pei = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 3 && w.$2 != 6);
        return pei.contains(detail.zikaze);
      })(),
      "白": (() {
        final haku = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 4 && w.$2 != 6);
        return haku.contains(detail.zikaze);
      })(),
      "発": (() {
        final hatsu = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 5 && w.$2 != 6);
        return hatsu.contains(detail.zikaze);
      })(),
      "中": (() {
        final tyun = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 6 && w.$2 != 6);
        return tyun.contains(detail.zikaze);
      })(),
      "ダブ東": (() {
        final dabuton = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 0 && w.$2 != 6);
        return dabuton.contains(detail.bakaze) && dabuton.contains(detail.zikaze);
      })(),
      "ダブ南": (() {
        final dabunan = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 0 && w.$2 != 6);
        return dabunan.contains(detail.bakaze) && dabunan.contains(detail.zikaze);
      })(),
      "ダブ西": (() {
        final dabusya = agariCal.where((w) => w.$1.$1 == 3 && w.$1.$2 == 0 && w.$2 != 6);
        return dabusya.contains(detail.bakaze) && dabusya.contains(detail.zikaze);
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
  List<(int type, int tile)> colectedAgarihai;

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

    // 成立役をtrueにする.
    if (yakuFlag["七対子"] ?? false) { // ７ブロック.
      yaku.firstWhere((i) => i.name == "七対子").selected = true;
      if (yakuFlag["ツモ"] ?? false) {
        yaku.firstWhere((i) => i.name == "ツモ").selected = true;
      }
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
      if (yakuFlag["ツモ"] ?? false) {
        yaku.firstWhere((i) => i.name == "ツモ").selected = true;
      }
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
    String sumScore = "";
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
    if (yakuFlag["平和"] ?? false) { // 平和なら.
      if (flagRon) {sumFuScore += 30;}
      if (flagTsumo) {sumFuScore += 20;}
    }
    else if (yakuFlag["七対子"] ?? false) { // 七対子なら.
      sumFuScore += 25;
    }
    else if (flagNaki) { // 鳴き.

      sumFuScore += 20; // 副低.
      if (flagTsumo) {sumFuScore += 2;} // ツモ符.

      final key = colectedAgarihai[detail.agari!]; // 何でアガリか.atodetsukau
      final keyOffset = (key.$1, key.$2 - 2); // 両面待ち検索.

      /*  ↓ ここからアガリの形につく符 ↓  */
      final agariMelds = agariCal // ブロックの構成.
          .where((w) => w.$1 == key)
          .map((m) => m.$2);
      final startAgariSyuntsu = agariCal // [(type, tile)...].
          .where((w) => w.$2 == 0)
          .map((m) => m.$1);
      final kantyanHai = startAgariSyuntsu.map((m) => (m.$1, m.$2 + 1)).toList();
      final oneSyuntsu = startAgariSyuntsu.where((w) => w.$2 == 0).map((m) => (m.$1, m.$2 + 2)).toList();
      final nineSyuntsu = startAgariSyuntsu.where((w) => w.$2 == 6).toList();
      final pentyanHai = oneSyuntsu + nineSyuntsu;
          
      if (agariMelds.contains(6)) { // 単騎待ち.
        sumFuScore += 2;
        print("単騎待ち");
      }
      // 待ちが両面になるパターン以外の時.
      else if (startAgariSyuntsu.length == 1) {
        if (kantyanHai.contains(key) || pentyanHai.contains(key)) {
          sumFuScore += 2;
          print("順子が１、カンチャン・ペンチャン");
        }
      }
      else if (startAgariSyuntsu.length == 2) {
        if (kantyanHai.contains(key) || pentyanHai.contains(key)) {
          sumFuScore += 2;
          print("順子が２、カンチャン・ペンチャン");
        }
      }
      else if (startAgariSyuntsu.length == 3) {
        if (kantyanHai.contains(key) || pentyanHai.contains(key)) {
          sumFuScore += 2;
          print("順子が３、カンチャン・ペンチャン");
        }
      }

      /*  ↓ ここからブロックの形につく符 ↓  */
      final scoreMeld = agariCal
          .map((m) => m.$2)
          .toList();
      
      if (scoreMeld.contains(1)) { // 暗刻があれば.
        final fuAdjust = agariCal.where((w) => w.$2 == 1).map((m) => m.$1); // 符の調整.
        final anko = agariCal
            .where((w) => w.$1.$1 != 3 && w.$2 == 1) // 字牌以外の暗刻で.
            .map((m) => m.$1.$2)
            .toList();
        int oneNineAnko = anko.where((w) =>  w  == 0 || w  == 8).length;
        int zihaiAnko = agariCal
            .where((w) => w.$2 == 1)
            .where((w) => w.$1.$1 == 3)
            .length;
        int twoEightAnko = anko.where((w) =>  w  != 0 && w != 8).length;

        sumFuScore += (oneNineAnko + zihaiAnko) * 8 + twoEightAnko * 4;

        if (fuAdjust.contains(key) && flagRon) { // シャンポンロンアガリ.
          if (key.$1 != 3 && (key.$2 != 0 && key.$2 != 8)) {sumFuScore -= 2;}
          print("符調整、シャンポン");
        }
      }

      if (scoreMeld.contains(3)) { // ポンがあれば.
        final pon = agariCal
            .where((w) => w.$1.$1 != 3 && w.$2 == 3) // 字牌以外のポンで.
            .map((m) => m.$1.$2)
            .toList();
        int oneNinePon = pon.where((w) =>  w  == 0 || w  == 8).length;
        int zihaiPon = agariCal
            .where((w) => w.$2 == 3)
            .where((w) => w.$1.$1 == 3)
            .length;
        int twoEightPon = pon.where((w) =>  w  != 0 && w != 8).length;

        sumFuScore += (oneNinePon + zihaiPon) * 4 + twoEightPon * 2;
      }

      if (scoreMeld.contains(4)) { // 暗槓があれば.
        final ankan = agariCal
            .where((w) => w.$1.$1 != 3 && w.$2 == 4) // 字牌以外の暗槓で.
            .map((m) => m.$1.$2)
            .toList();
        int oneNineAnkan = ankan.where((w) =>  w  == 0 || w  == 8).length;
        int zihaiAnkan = agariCal
            .where((w) => w.$2 == 4)
            .where((w) => w.$1.$1 == 3)
            .length;
        int twoEightAnkan = ankan.where((w) =>  w  != 0 && w != 8).length;

        sumFuScore += (oneNineAnkan + zihaiAnkan) * 32 + twoEightAnkan * 16;
      }

      if (scoreMeld.contains(5)) { // 明槓があれば.
        final minkan = agariCal
            .where((w) => w.$1.$1 != 3 && w.$2 == 5) // 字牌以外の明槓で.
            .map((m) => m.$1.$2)
            .toList();
        int oneNineMinkan = minkan.where((w) =>  w  == 0 || w  == 8).length;
        int zihaiMinkan = agariCal
            .where((w) => w.$2 == 5)
            .where((w) => w.$1.$1 == 3)
            .length;
        int twoEightMinkan = minkan.where((w) =>  w  != 0 && w != 8).length;

        sumFuScore += (oneNineMinkan + zihaiMinkan) * 16 + twoEightMinkan * 8;
      }

      int tanki = 0;
      final zihaiTanki = agariCal
          .where((w) => w.$1.$1 == 3 && w.$2 == 6)
          .map((m) => m.$1.$2)
          .toList();
      if (zihaiTanki.length == 1) {
        int bakaze = detail.bakaze;
        int zikaze = detail.zikaze;
        if (zihaiTanki.contains(bakaze) || zihaiTanki.contains(zikaze)) {
          tanki += 2;
        } else if ({4, 5, 6}.contains(zihaiTanki.single)) { // 白・発・中なら.
          tanki += 2;
        }
      }

      sumFuScore += tanki;

      if (sumFuScore <= 20) {
        sumFuScore = 20;
      } else if (sumFuScore > 20 && sumFuScore <= 30) {
        sumFuScore = 30;
      } else if (sumFuScore > 30 && sumFuScore <= 40) {
        sumFuScore = 40;
      } else if (sumFuScore > 40 && sumFuScore <= 50) {
        sumFuScore = 50;
      } else if (sumFuScore > 50 && sumFuScore <= 60) {
        sumFuScore = 60;
      } else if (sumFuScore > 60 && sumFuScore <= 70) {
        sumFuScore = 70;
      } else if (sumFuScore > 70 && sumFuScore <= 80) {
        sumFuScore = 80;
      } else if (sumFuScore > 80 && sumFuScore <= 90) {
        sumFuScore = 90;
      } else if (sumFuScore > 90 && sumFuScore <= 100) {
        sumFuScore = 100;
      } else if (sumFuScore > 100 && sumFuScore <= 110) {
        sumFuScore = 110;
      } else if (sumFuScore > 110 && sumFuScore <= 120) {
        sumFuScore = 120;
      } else if (sumFuScore > 120 && sumFuScore <= 130) {
        sumFuScore = 130;
      } else if (sumFuScore > 130 && sumFuScore <= 140) {
        sumFuScore = 140;
      } else if (sumFuScore > 140 && sumFuScore <= 150) {
        sumFuScore = 150;
      } else if (sumFuScore > 150 && sumFuScore <= 160) {
        sumFuScore = 160;
      } else if (sumFuScore > 160 && sumFuScore <= 170) {
        sumFuScore = 170;
      }
    }
    else if (!flagNaki) { // 面前.

      sumFuScore += 20; // 副低.
      if (flagTsumo) {sumFuScore += 2;} // ツモ符.
      if (flagRon) {sumFuScore += 10;} // ロン符.

      final key = colectedAgarihai[detail.agari!]; // 何でアガリか.atodetsukau
      final keyOffset = (key.$1, key.$2 - 2); // 両面待ち検索.

      /*  ↓ ここからアガリの形につく符 ↓  */
      final agariMelds = agariCal // ブロックの構成.
          .where((w) => w.$1 == key)
          .map((m) => m.$2);
      final startAgariSyuntsu = agariCal // [(type, tile)...].
          .where((w) => w.$2 == 0)
          .map((m) => m.$1);
      final kantyanHai = startAgariSyuntsu.map((m) => (m.$1, m.$2 + 1)).toList();
      final oneSyuntsu = startAgariSyuntsu.where((w) => w.$2 == 0).map((m) => (m.$1, m.$2 + 2)).toList();
      final nineSyuntsu = startAgariSyuntsu.where((w) => w.$2 == 6).toList();
      final pentyanHai = oneSyuntsu + nineSyuntsu;
          
      if (agariMelds.contains(6)) { // 単騎待ち.
        sumFuScore += 2;
        print("単騎待ち");
      }
      // 待ちが両面になるパターン以外の時.
      else if (startAgariSyuntsu.length == 1) {
        if (kantyanHai.contains(key) || pentyanHai.contains(key)) {
          sumFuScore += 2;
          print("順子が１、カンチャン・ペンチャン");
        }
      }
      else if (startAgariSyuntsu.length == 2) {
        if (kantyanHai.contains(key) || pentyanHai.contains(key)) {
          sumFuScore += 2;
          print("順子が２、カンチャン・ペンチャン");
        }
      }
      else if (startAgariSyuntsu.length == 3) {
        if (kantyanHai.contains(key) || pentyanHai.contains(key)) {
          sumFuScore += 2;
          print("順子が３、カンチャン・ペンチャン");
        }
      } else if (startAgariSyuntsu.length == 4) { // 平和を排他にしてるから.
        sumFuScore += 2;
        print("順子が４、カンチャン・ペンチャン");
      }

      /*  ↓ ここからブロックの形につく符 ↓  */
      final scoreMeld = agariCal
          .map((m) => m.$2)
          .toList();
      
      if (scoreMeld.contains(1)) { // 暗刻があれば.
        final fuAdjust = agariCal.where((w) => w.$2 == 1).map((m) => m.$1); // 符の調整.
        final anko = agariCal
            .where((w) => w.$1.$1 != 3 && w.$2 == 1) // 字牌以外の暗刻で.
            .map((m) => m.$1.$2)
            .toList();
        int oneNineAnko = anko.where((w) =>  w  == 0 || w  == 8).length;
        int zihaiAnko = agariCal
            .where((w) => w.$2 == 1)
            .where((w) => w.$1.$1 == 3)
            .length;
        int twoEightAnko = anko.where((w) =>  w  != 0 && w != 8).length;

        sumFuScore += (oneNineAnko + zihaiAnko) * 8 + twoEightAnko * 4;

        if (fuAdjust.contains(key) && flagRon) { // シャンポンロンアガリ.
          if (key.$1 != 3 && (key.$2 != 0 && key.$2 != 8)) {sumFuScore -= 2;}
          print("符調整、シャンポン");
        }
      }

      if (scoreMeld.contains(4)) { // 暗槓があれば.
        final ankan = agariCal
            .where((w) => w.$1.$1 != 3 && w.$2 == 4) // 字牌以外の暗槓で.
            .map((m) => m.$1.$2)
            .toList();
        int oneNineAnkan = ankan.where((w) =>  w  == 0 || w  == 8).length;
        int zihaiAnkan = agariCal
            .where((w) => w.$2 == 4)
            .where((w) => w.$1.$1 == 3)
            .length;
        int twoEightAnkan = ankan.where((w) =>  w  != 0 && w != 8).length;

        print("onr: $oneNineAnkan  zihai: $zihaiAnkan two: $twoEightAnkan");

        sumFuScore += (oneNineAnkan + zihaiAnkan) * 32 + twoEightAnkan * 16;
      }

      int tanki = 0;
      final zihaiTanki = agariCal
          .where((w) => w.$1.$1 == 3 && w.$2 == 6)
          .map((m) => m.$1.$2)
          .toList();
      if (zihaiTanki.length == 1) {
        int bakaze = detail.bakaze;
        int zikaze = detail.zikaze;
        if (zihaiTanki.contains(bakaze) || zihaiTanki.contains(zikaze)) {
          tanki += 2;
        } else if ({4, 5, 6}.contains(zihaiTanki.single)) { // 白・発・中なら.
          tanki += 2;
        }
      }

      sumFuScore += tanki;

      if (sumFuScore <= 20) {
        sumFuScore = 20;
      } else if (sumFuScore > 20 && sumFuScore <= 30) {
        sumFuScore = 30;
      } else if (sumFuScore > 30 && sumFuScore <= 40) {
        sumFuScore = 40;
      } else if (sumFuScore > 40 && sumFuScore <= 50) {
        sumFuScore = 50;
      } else if (sumFuScore > 50 && sumFuScore <= 60) {
        sumFuScore = 60;
      } else if (sumFuScore > 60 && sumFuScore <= 70) {
        sumFuScore = 70;
      } else if (sumFuScore > 70 && sumFuScore <= 80) {
        sumFuScore = 80;
      } else if (sumFuScore > 80 && sumFuScore <= 90) {
        sumFuScore = 90;
      } else if (sumFuScore > 90 && sumFuScore <= 100) {
        sumFuScore = 100;
      } else if (sumFuScore > 100 && sumFuScore <= 110) {
        sumFuScore = 110;
      } else if (sumFuScore > 110 && sumFuScore <= 120) {
        sumFuScore = 120;
      } else if (sumFuScore > 120 && sumFuScore <= 130) {
        sumFuScore = 130;
      } else if (sumFuScore > 130 && sumFuScore <= 140) {
        sumFuScore = 140;
      } else if (sumFuScore > 140 && sumFuScore <= 150) {
        sumFuScore = 150;
      } else if (sumFuScore > 150 && sumFuScore <= 160) {
        sumFuScore = 160;
      } else if (sumFuScore > 160 && sumFuScore <= 170) {
        sumFuScore = 170;
      }
    }

    // 点数計算.
    if (detail.zikaze == 0) { // 親なら.
      if (sumFuScore == 20){
        if (sumHanScore == 2) {sumScore = "2100 (700)";}
        if (sumHanScore == 3) {sumScore = "3900 (1300)";}
        if (sumHanScore == 4) {sumScore = "7800 (2600)";}
      } else if (sumFuScore == 25){
        if (sumHanScore == 2) {sumScore = flagRon ? "2400" : "2400 (800)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "4800" : "4800 (1600)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "9600" : "9600 (3200)";}
      } else if (sumFuScore == 30){
        if (sumHanScore == 1) {sumScore = flagRon ? "1500" : "1500 (500)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "2900" : "3000 (1000)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "5800" : "6000 (2000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "11600" : "11700 (3900)";}
      } else if (sumFuScore == 40){
        if (sumHanScore == 1) {sumScore = flagRon ? "2000" : "2100 (700)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "3900" : "3900 (1300)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "7700" : "7800 (2600)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 50){
        if (sumHanScore == 1) {sumScore = flagRon ? "2400" : "2400 (800)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "4800" : "4800 (1600)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "9600" : "9600 (3200)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 60){
        if (sumHanScore == 1) {sumScore = flagRon ? "2900" : "3000 (1000)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "5800" : "6000 (2000)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "11600" : "11700 (3900)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 70){
        if (sumHanScore == 1) {sumScore = flagRon ? "3400" : "3600 (1200)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "6800" : "6900 (2300)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 80){
        if (sumHanScore == 1) {sumScore = flagRon ? "3900" : "3900 (1300)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "7700" : "7800 (2600)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 90){
        if (sumHanScore == 1) {sumScore = flagRon ? "4400" : "4500 (1500)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "8700" : "8700 (2900)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 100){
        if (sumHanScore == 1) {sumScore = flagRon ? "4800" : "4800 (1600)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "9600" : "9600 (3200)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      } else if (sumFuScore == 110){
        if (sumHanScore == 1) {sumScore = flagRon ? "5300" : "5400 (1800)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "10600" : "10800 (3600)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";}
      }
      if (sumHanScore == 5) {
        sumScore = flagRon ? "満貫 (12000)" : "満貫 (4000)";
      } else if (sumHanScore == 6 || sumHanScore == 7) {
        sumScore = flagRon ? "跳満 (18000)" : "跳満 (6000)";
      } else if (sumHanScore == 8 || sumHanScore == 9 || sumHanScore == 10) {
        sumScore = flagRon ? "倍満 (24000)" : "倍満 (8000)";
      } else if (sumHanScore == 11 || sumHanScore == 12) {
        sumScore = flagRon ? "三倍満 (36000)" : "三倍満 (12000)";
      } else if (sumHanScore > 12) {
        sumScore = flagRon ? "数え役満 (48000)" : "数え役満 (16000)";
      }
    } else {
      if (sumFuScore == 20) { // ピンフツモのみ
        if (sumHanScore == 2) {sumScore = "1500 (400/700)";}
        if (sumHanScore == 3) {sumScore = "2700 (700/1300)";}
        if (sumHanScore == 4) {sumScore = "5200 (1300/2600)";}
      } else if (sumFuScore == 25) {
        if (sumHanScore == 2) {sumScore = flagRon ? "1600" : "1600 (400/800)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "3200" : "3200 (800/1600)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "6400" : "6400 (1600/3200)";}
      } else if (sumFuScore == 30) {
        if (sumHanScore == 1) {sumScore = flagRon ? "1000" : "1100 (300/500)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "2000" : "2000 (500/1000)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "3900" : "4000 (1000/2000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "7700" : "7900 (2000/3900)";}
      } else if (sumFuScore == 40) {
        if (sumHanScore == 1) {sumScore = flagRon ? "1300" : "1500 (400/700)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "2600" : "2700 (700/1300)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "5200" : "5200 (1300/2600)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 50) {
        if (sumHanScore == 1) {sumScore = flagRon ? "1600" : "1600 (400/800)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "3200" : "3200 (800/1600)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "6400" : "6400 (1600/3200)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 60) {
        if (sumHanScore == 1) {sumScore = flagRon ? "2000" : "2000 (500/1000)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "3900" : "4000 (1000/2000)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "7700" : "7900 (2000/3900)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 70) {
        if (sumHanScore == 1) {sumScore = flagRon ? "2300" : "2400 (600/1200)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "4500" : "4700 (1200/2300)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 80) {
        if (sumHanScore == 1) {sumScore = flagRon ? "2600" : "2300 (700/1300)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "5200" : "5200 (1300/2600)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 90) {
        if (sumHanScore == 1) {sumScore = flagRon ? "2900" : "3100 (800/1500)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "5800" : "5900 (1500/2900)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 100) {
        if (sumHanScore == 1) {sumScore = flagRon ? "3200" : "3200 (800/1600)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "6400" : "6400 (1600/3200)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      } else if (sumFuScore == 110) {
        if (sumHanScore == 1) {sumScore = flagRon ? "3600" : "3600 (900/1800)";}
        if (sumHanScore == 2) {sumScore = flagRon ? "7100" : "7200 (1800/3600)";}
        if (sumHanScore == 3) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
        if (sumHanScore == 4) {sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";}
      }
      if (sumHanScore == 5) {
        sumScore = flagRon ? "満貫 (8000)" : "満貫 (2000/4000)";
      } else if (sumHanScore == 6 || sumHanScore == 7) {
        sumScore = flagRon ? "跳満 (12000)" : "跳満 (3000/6000)";
      } else if (sumHanScore == 8 || sumHanScore == 9 || sumHanScore == 10) {
        sumScore = flagRon ? "倍満 (16000)" : "倍満 (4000/8000)";
      } else if (sumHanScore == 11 || sumHanScore == 12) {
        sumScore = flagRon ? "三倍満 (24000)" : "三倍満 (6000/12000)";
      } else if (sumHanScore > 12) {
        sumScore = flagRon ? "数え役満 (32000)" : "数え役満 (8000/16000)";
      }
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
              : "$sumScore $sumHanScore 翻 $sumFuScore 符",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

