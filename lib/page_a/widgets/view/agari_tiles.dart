import 'package:flutter/material.dart';
import 'package:mahjong/page_a/data/images.dart';
import 'package:mahjong/page_a/models/meld_tiles.dart';

class AgariTiles extends StatelessWidget {
  const AgariTiles({required this.brockTiles, required this.huroTiles, super.key});

  final List<Widget> brockTiles;
  final List<Widget> huroTiles;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Row(children: brockTiles),
                Row(children: huroTiles),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
