import 'package:mahjong/models/yaku.dart';


final List<Yaku> yakuList = [
  
  // 1翻.
  Yaku(name: "リーチ",       hanClosed: 1, hanOpen: null),
  Yaku(name: "一発",         hanClosed: 1, hanOpen: null),
  Yaku(name: "ツモ",         hanClosed: 1, hanOpen: null),
  Yaku(name: "平和",         hanClosed: 1, hanOpen: null),
  Yaku(name: "断么九",       hanClosed: 1, hanOpen: 1),
  Yaku(name: "役牌",         hanClosed: 1, hanOpen: 1),
  Yaku(name: "一盃口",       hanClosed: 1, hanOpen: null),
  Yaku(name: "嶺上開花",     hanClosed: 1, hanOpen: 1),
  Yaku(name: "槍槓",         hanClosed: 1, hanOpen: 1),
  Yaku(name: "海底",         hanClosed: 1, hanOpen: 1),
  Yaku(name: "河底",         hanClosed: 1, hanOpen: 1),

  // 2翻
  Yaku(name: "ダブルリーチ", hanClosed: 2, hanOpen: null),
  Yaku(name: "三色同順",     hanClosed: 2, hanOpen: 1), // 食い下がり.
  Yaku(name: "三色同刻",     hanClosed: 2, hanOpen: 2),
  Yaku(name: "一気通貫",     hanClosed: 2, hanOpen: 1), // 食い下がり.
  Yaku(name: "対々和",       hanClosed: 2, hanOpen: 2),
  Yaku(name: "三暗刻",       hanClosed: 2, hanOpen: 2),
  Yaku(name: "三槓子",       hanClosed: 2, hanOpen: 2),
  Yaku(name: "全帯么",       hanClosed: 2, hanOpen: 1), // 食い下がり.
  Yaku(name: "混老頭",       hanClosed: 2, hanOpen: 2),
  Yaku(name: "小三元",       hanClosed: 2, hanOpen: 2),
  Yaku(name: "七対子",       hanClosed: 2, hanOpen: null),

  // 3翻
  Yaku(name: "二盃口",       hanClosed: 3, hanOpen: null),
  Yaku(name: "混一色",       hanClosed: 3, hanOpen: 2), // 食い下がり.
  Yaku(name: "純全帯么九",   hanClosed: 3, hanOpen: 2), // 食い下がり.

  // 6翻
  Yaku(name: "清一色",       hanClosed: 6, hanOpen: 5), // 食い下がり.
];
