import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/page_a/option_button.dart';
import 'package:mahjong/page_a/select_tiles.dart';


class SelectType extends StatelessWidget {
  SelectType({required this.onChanged, super.key});

  final void Function(int) onChanged; //親から受け取る関数.

  List<String> tileIcon = [
    Images.manzu(1),
    Images.pinzu(1),
    Images.souzu(1),
    Images.zihai(1)
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {

        const cols = 2;
        const rows = 2;
        const spacing = 8.0;

        final cellHeight = (c.maxHeight - (rows - 1) * spacing) / rows;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            mainAxisExtent: cellHeight, //ボタンの高さ.
          ),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return OptionButton(
              onPressed: () => onChanged(index),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Image.asset(
                  tileIcon[index],
                  fit: BoxFit.contain,
                )
              )
            );
          }
        );
      }
    );
  }
}


            // return ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     foregroundColor: Colors.black,
            //     padding: EdgeInsets.all(5), //ボタンの中のアイコンの大きさ.
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(8),
            //       side: const BorderSide(color: Colors.red),
            //     ),
            //     elevation: 3,
            //   ),

            //   /* 親でsetState(() {})を実行して状態を管理するために、ボタンそれぞれにindexを引数とするonChagedを渡す。
            //   親側で_selectTypeを用意して押されたボタンのindexを管理しSelectTilesに渡す。 */
            //   onPressed: () => onChanged(index),

            //   child: Padding(
            //     padding: EdgeInsets.all(0),
            //     child: Image.asset(
            //       tileIcon[index],
            //       fit: BoxFit.contain,
            //     )
            //   )
            // );