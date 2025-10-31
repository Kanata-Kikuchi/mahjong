import 'package:flutter/material.dart';
import 'package:mahjong/data/images.dart';

class ScoreOptionAgari extends StatelessWidget {
  ScoreOptionAgari({
    required this.bufAgari,
    required this.value,
    required this.onChanged,
    required this.colectedAgari,
    super.key
  });

  List<(int type, int tile)> bufAgari;
  int? value;
  final ValueChanged<int?> onChanged;
  final void Function(List<(int type, int tile)>) colectedAgari;

  @override
  Widget build(BuildContext context) {

    bufAgari.sort((a, b) {
      int buf = a.$1.compareTo(b.$1);
      return buf != 0 ? buf : a.$2.compareTo(b.$2);
    });

    final List<(int type, int tile)> bufAgarihai = [];

    final List<Widget> agariHai = bufAgari.toSet().map((m) {
      final type = m.$1;
      final tile = m.$2 + 1;

      
        bufAgarihai.add((m.$1, m.$2));

        if (type == 0) {
          return Image.asset(Images.manzu(tile));
        }else if (type == 1) {
          return Image.asset(Images.pinzu(tile));
        } else if (type == 2) {
          return Image.asset(Images.souzu(tile));
        } else {
          return Image.asset(Images.zihai(tile));
        }
      
    }).toList();

    final List<DropdownMenuItem<int>> items = List.generate(
      agariHai.length,
      (g) => DropdownMenuItem(
        value: g,
        child: Center(
          child: agariHai[g]
        )
      )
    );

    return DropdownButton<int>(
      value: value,
      hint: const Text("アガリ牌"),
      items: items,
      alignment: Alignment.center,
      onChanged: (i) {
        colectedAgari(bufAgarihai);
        onChanged(i);
      },
      underline: SizedBox(),
    );
  }
}