import 'package:flutter/material.dart';
import 'package:mahjong/data/images.dart';
import 'package:mahjong/models/meld_tiles.dart';

class AgariTiles extends StatelessWidget {
  AgariTiles({required this.brockTiles, required this.huroTiles, super.key});

  final List<Widget> brockTiles;
  final List<Widget> huroTiles;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Row(
        children: [
          SizedBox(width: 10),
          Row(children: brockTiles),

          Row(children: huroTiles),
          SizedBox(width: 10)
        ]
      ),
    );
  }
}