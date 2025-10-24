import 'package:flutter/material.dart';
import 'package:mahjong/data/images.dart';

class SelectTiles extends StatelessWidget {
  SelectTiles({required this.typeIndex, required this.onChanged, super.key});

  final int typeIndex; //PageAで管理するための変数.
  final void Function(int) onChanged;

  List<Widget> manzu = [
    Image.asset(Images.manzu(1)),
    Image.asset(Images.manzu(2)),
    Image.asset(Images.manzu(3)),
    Image.asset(Images.manzu(4)),
    Image.asset(Images.manzu(5)),
    Image.asset(Images.manzu(6)),
    Image.asset(Images.manzu(7)),
    Image.asset(Images.manzu(8)),
    Image.asset(Images.manzu(9)),
  ];

  List<Widget> pinzu = [
    Image.asset(Images.pinzu(1)),
    Image.asset(Images.pinzu(2)),
    Image.asset(Images.pinzu(3)),
    Image.asset(Images.pinzu(4)),
    Image.asset(Images.pinzu(5)),
    Image.asset(Images.pinzu(6)),
    Image.asset(Images.pinzu(7)),
    Image.asset(Images.pinzu(8)),
    Image.asset(Images.pinzu(9)),
  ];

  List<Widget> souzu = [
    Image.asset(Images.souzu(1)),
    Image.asset(Images.souzu(2)),
    Image.asset(Images.souzu(3)),
    Image.asset(Images.souzu(4)),
    Image.asset(Images.souzu(5)),
    Image.asset(Images.souzu(6)),
    Image.asset(Images.souzu(7)),
    Image.asset(Images.souzu(8)),
    Image.asset(Images.souzu(9)),
  ];

  List<Widget> zihai = [
    Image.asset(Images.zihai(1)),
    Image.asset(Images.zihai(2)),
    Image.asset(Images.zihai(3)),
    Image.asset(Images.zihai(4)),
    Image.asset(Images.zihai(5)),
    Image.asset(Images.zihai(6)),
    Image.asset(Images.zihai(7)),
  ];

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickAで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return RotatedBox(
      quarterTurns: -1,
      child: LayoutBuilder(
        builder: (context, c) {
          return ListWheelScrollView(
            itemExtent: c.maxHeight / 3.5, //子の高さ.
            physics: FixedExtentScrollPhysics(),
            diameterRatio: 2.0, //カーブの強さ.
            perspective: 0.001, //奥行の見え方.
            useMagnifier: true, //中央だけ拡大.
            magnification: 1.1, //拡大比率.
            overAndUnderCenterOpacity: 0.4, //端の透明度.
            onSelectedItemChanged: (i) => onChanged(i),
            children: tiles.map((buf) => RotatedBox(quarterTurns: 1, child: buf)).toList(),
          );
        },
      )
    );
  }
}
