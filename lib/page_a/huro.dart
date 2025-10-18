import 'package:flutter/material.dart';
import 'package:mahjong/page_a/meld_tiles.dart';

class Huro extends StatelessWidget {
  const Huro({required this.typeIndex, required this.tileIndex, required this.meldIndex, super.key});

  final int typeIndex;
  final int tileIndex;
  final int meldIndex;

  @override
  Widget build(BuildContext context) {

    List<Widget> tiles = [
      Syuntu(typeIndex: typeIndex, tileIndex: tileIndex),
      Anko(typeIndex: typeIndex, tileIndex: tileIndex),
      Chi(typeIndex: typeIndex, tileIndex: tileIndex),
      Pon(typeIndex: typeIndex, tileIndex: tileIndex),
      Ankan(typeIndex: typeIndex, tileIndex: tileIndex),
      Minkan(typeIndex: typeIndex, tileIndex: tileIndex),
      Toitsu(typeIndex: typeIndex, tileIndex: tileIndex),
      Tanki(typeIndex: typeIndex, tileIndex: tileIndex),
    ];

    // int offsetIndex = meldIndex - 2;

    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        height: 160,
        width: 160,
        child:Padding(
          padding: EdgeInsets.all(20),
          child: tiles[meldIndex]
        )
      )
    );
  }
}