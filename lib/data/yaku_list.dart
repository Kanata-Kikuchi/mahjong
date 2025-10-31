import 'package:mahjong/models/yaku.dart';


final List<Yaku> yakuList = [
  
  // 1翻.
  Yaku(name: "リーチ",       hanClosed: 1, hanOpened: 0), // 面前のみ.
  Yaku(name: "一発",         hanClosed: 1, hanOpened: 0), // 面前のみ.
  Yaku(name: "ツモ",         hanClosed: 1, hanOpened: 0), // 面前のみ.
  Yaku(name: "平和",         hanClosed: 1, hanOpened: 0), // 面前のみ.
  Yaku(name: "断么九",       hanClosed: 1, hanOpened: 1),
  Yaku(name: "一盃口",       hanClosed: 1, hanOpened: 0), // 面前のみ.
  Yaku(name: "東",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "南",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "西",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "北",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "白",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "発",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "中",           hanClosed: 1, hanOpened: 1),
  Yaku(name: "嶺上開花",     hanClosed: 1, hanOpened: 1),
  Yaku(name: "槍槓",         hanClosed: 1, hanOpened: 1),
  Yaku(name: "海底",         hanClosed: 1, hanOpened: 1),
  Yaku(name: "河底",         hanClosed: 1, hanOpened: 1),

  // 2翻
  Yaku(name: "ダブ東",       hanClosed: 1, hanOpened: 1),
  Yaku(name: "ダブ南",       hanClosed: 1, hanOpened: 1),
  Yaku(name: "ダブ西",       hanClosed: 1, hanOpened: 1),
  Yaku(name: "ダブルリーチ", hanClosed: 2, hanOpened: 0), // 面前のみ.
  Yaku(name: "三色同順",     hanClosed: 2, hanOpened: 1), // 食い下がり.
  Yaku(name: "三色同刻",     hanClosed: 2, hanOpened: 2),
  Yaku(name: "一気通貫",     hanClosed: 2, hanOpened: 1), // 食い下がり.
  Yaku(name: "対々和",       hanClosed: 2, hanOpened: 2),
  Yaku(name: "三暗刻",       hanClosed: 2, hanOpened: 2),
  Yaku(name: "三槓子",       hanClosed: 2, hanOpened: 2),
  Yaku(name: "全帯么",       hanClosed: 2, hanOpened: 1), // 食い下がり.
  Yaku(name: "混老頭",       hanClosed: 2, hanOpened: 2),
  Yaku(name: "小三元",       hanClosed: 2, hanOpened: 2),
  Yaku(name: "七対子",       hanClosed: 2, hanOpened: 0), // 面前のみ.

  // 3翻
  Yaku(name: "二盃口",       hanClosed: 3, hanOpened: 0), // 面前のみ.
  Yaku(name: "混一色",       hanClosed: 3, hanOpened: 2), // 食い下がり.
  Yaku(name: "純全帯么九",   hanClosed: 3, hanOpened: 2), // 食い下がり.

  // 6翻
  Yaku(name: "清一色",       hanClosed: 6, hanOpened: 5), // 食い下がり.

  Yaku(name: "ドラ",         hanClosed: 0, hanOpened: 0)
];
