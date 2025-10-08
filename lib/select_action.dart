import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/meld_tiles.dart';

class SelectActionWidget extends StatefulWidget {
  const SelectActionWidget({super.key});

  @override
  State<SelectActionWidget> createState() => _SelectActionWidgetState();
}

class _SelectActionWidgetState extends State<SelectActionWidget> {

  List<Widget> tileIconAction = [
    Syuntu(),
    Anko(),
    Chi(),
    Pon(),
    Transform.scale(scale: 0.8, child: Ankan()),
    Transform.scale(scale: 0.8, child: Minkan()),
    Transform.scale(scale: 1.6, child: Tsumo()),
    Transform.scale(scale: 1.6, child: Ron()),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 50
      ),
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: EdgeInsets.all(12), //ボタンの中のアイコンの大きさ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.red),
            ),
            elevation: 3,
          ),
          onPressed: () {
            print("$index");
          },
          child: tileIconAction[index],
        );
      }
    );
  }
}
