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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SelectType(
        onChanged: (i) => setState(() {
          _selectType = i;
        }),
      ),
      Transform.translate(offset: Offset(0, -16), child: Stack(children: [
        BoxA(140, 108),
        SizedBox(width: 140, height: 108, child: SelectTiles(

          /* 基本的にWidhetは再利用されるため、牌種(Configuratioon)を変更してもスクロール位置が保持される(State)。
          keyの変更を明示すると再build時にWidgetの作り変えが起き、スクロール位置が初期値になる。*/
          key: UniqueKey(),
          
          typeIndex: _selectType,
        ))
      ]))
    ],);
  }
}