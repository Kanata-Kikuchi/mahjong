import 'package:flutter/material.dart';
import 'package:mahjong/data/images.dart';
import 'package:mahjong/models/meld_tiles.dart';
import 'dart:math' as math;

import 'package:mahjong/widgets/option_button.dart';

class SelectMeld extends StatelessWidget {
  const SelectMeld({
    required this.typeIndex,
    required this.tileIndex,
    required this.onChanged,
    super.key
  });

  final int typeIndex;
  final int tileIndex;
  final void Function(int) onChanged;

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

    Widget _test = ColoredBox(color: Colors.red, child: Text("data"));

    return LayoutBuilder(
      builder: (context, c) {
        const cols = 2;
        const rows = 4;
        const spacing = 8.0;

        final cellHeight = (c.maxHeight - (rows - 1) * spacing) / rows;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            mainAxisExtent: cellHeight
          ),
          itemCount: tiles.length,
          itemBuilder: (context, index) {
            return OptionButton(
              onPressed: () => onChanged(index),
              child: tiles[index]
            );
          }
        );
      }
    );
  }
}

