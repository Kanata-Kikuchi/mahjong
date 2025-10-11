import 'package:flutter/material.dart';
import 'package:mahjong/boxes.dart';
import 'package:mahjong/select_tiles.dart';
import 'package:mahjong/select_type.dart';

class PickA extends StatefulWidget {
  const PickA({super.key});

  @override
  State<PickA> createState() => _PickAState();
}

class _PickAState extends State<PickA> {

  int _selectType = 0;
  int _selectTilesIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SelectType(
        onChanged: (i) => setState(() {
          _selectType = i;
          _selectTilesIndex = 0;
        }),
      ),
      Transform.translate(offset: Offset(0, -16), child: Stack(children: [
        BoxA(140, 108),
        SizedBox(width: 140, height: 108, child: SelectTiles(
          key: ValueKey(_selectType),
          typeIndex: _selectType,
          initialIndex: _selectTilesIndex,
          onTileChanged: (i) => setState(() {
            _selectTilesIndex = i;
          }),
        ))
      ]))
    ],);
  }
}