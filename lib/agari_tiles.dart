import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/meld_tiles.dart';

Image back = Image.asset(Images.back.path, scale: 1.7);

class AgariTiles extends StatelessWidget {
  AgariTiles({required this.brockTiles, required this.huroTiles, super.key});

  final List<Widget> brockTiles;
  final List<Widget> huroTiles;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: brockTiles,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: huroTiles,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}