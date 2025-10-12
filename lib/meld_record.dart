import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/meld_tiles.dart';

class MeldRecord extends StatelessWidget {
  MeldRecord({required this.typeIndex, required this.tileIndex, required this.meldIndex, super.key});

  final int typeIndex; //マン・ピン・ソウ・ジ
  final int tileIndex; //1~9, 東~中
  final int meldIndex; //順子・暗刻・チー・ポン・暗槓・明槓・対子・アガリ

  List<Widget> manzu = [
    Image.asset(Images.manzu(1), scale: 1.7),
    Image.asset(Images.manzu(2), scale: 1.7),
    Image.asset(Images.manzu(3), scale: 1.7),
    Image.asset(Images.manzu(4), scale: 1.7),
    Image.asset(Images.manzu(5), scale: 1.7),
    Image.asset(Images.manzu(6), scale: 1.7),
    Image.asset(Images.manzu(7), scale: 1.7),
    Image.asset(Images.manzu(8), scale: 1.7),
    Image.asset(Images.manzu(9), scale: 1.7),
  ];

  List<Widget> pinzu = [
    Image.asset(Images.pinzu(1), scale: 1.7),
    Image.asset(Images.pinzu(2), scale: 1.7),
    Image.asset(Images.pinzu(3), scale: 1.7),
    Image.asset(Images.pinzu(4), scale: 1.7),
    Image.asset(Images.pinzu(5), scale: 1.7),
    Image.asset(Images.pinzu(6), scale: 1.7),
    Image.asset(Images.pinzu(7), scale: 1.7),
    Image.asset(Images.pinzu(8), scale: 1.7),
    Image.asset(Images.pinzu(9), scale: 1.7),
  ];

  List<Widget> souzu = [
    Image.asset(Images.souzu(1), scale: 1.7),
    Image.asset(Images.souzu(2), scale: 1.7),
    Image.asset(Images.souzu(3), scale: 1.7),
    Image.asset(Images.souzu(4), scale: 1.7),
    Image.asset(Images.souzu(5), scale: 1.7),
    Image.asset(Images.souzu(6), scale: 1.7),
    Image.asset(Images.souzu(7), scale: 1.7),
    Image.asset(Images.souzu(8), scale: 1.7),
    Image.asset(Images.souzu(9), scale: 1.7),
  ];

  List<Widget> zihai = [
    Image.asset(Images.zihai(1), scale: 1.7),
    Image.asset(Images.zihai(2), scale: 1.7),
    Image.asset(Images.zihai(3), scale: 1.7),
    Image.asset(Images.zihai(4), scale: 1.7),
    Image.asset(Images.zihai(5), scale: 1.7),
    Image.asset(Images.zihai(6), scale: 1.7),
    Image.asset(Images.zihai(7), scale: 1.7),
  ];


  @override
  Widget build(BuildContext context) {

    List<Widget> agari = [
      back,
      back,
      back,
      back,
      back,
      back,
      back,
      back,
      back,
      back,
      back,
      back,
      back,
    ];

    final List<Widget> tiles = //PageAで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    if (meldIndex == 0) {
      agari.addAll([tiles[tileIndex], tiles[tileIndex+1], tiles[tileIndex+2]]);
    } else if (meldIndex == 1) {
      agari.addAll([tiles[tileIndex], tiles[tileIndex], tiles[tileIndex]]);
    }

    return Row(children: agari);
  }
}