import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/select_tiles.dart';


class SelectType extends StatelessWidget {
  SelectType({required this.onChanged, super.key});

  final void Function(int) onChanged;

  List<String> tileIcon = [
    Images.manzu(1),
    Images.pinzu(1),
    Images.souzu(1),
    Images.zihai(1)
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 50, //ボタンの高さ
      ),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: EdgeInsets.all(5), //ボタンの中のアイコンの大きさ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.red),
            ),
            elevation: 3,
          ),
          onPressed: () => onChanged(index),
          child: Image.asset(
            tileIcon[index],
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        );
      }
    );
  }
}
