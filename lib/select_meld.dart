import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/meld_tiles.dart';

class SelectMeld extends StatelessWidget {
  SelectMeld({required this.typeIndex, required this.tileIndex, required this.onChanged, super.key});

  final int typeIndex;
  final int tileIndex;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {

    List<Widget> tileIconMeld = [
      Syuntu(typeIndex: typeIndex, tileIndex: tileIndex),
      Anko(typeIndex: typeIndex, tileIndex: tileIndex),
      Chi(typeIndex: typeIndex, tileIndex: tileIndex),
      Pon(typeIndex: typeIndex, tileIndex: tileIndex),
      Transform.scale(scale: 0.8, child: Ankan(typeIndex: typeIndex, tileIndex: tileIndex)),
      Transform.scale(scale: 0.8, child: Minkan(typeIndex: typeIndex, tileIndex: tileIndex)),
      Transform.scale(scale: 1.6, child: Toitsu(typeIndex: typeIndex, tileIndex: tileIndex)),
      Transform.scale(scale: 1.6, child: Tanki(typeIndex: typeIndex, tileIndex: tileIndex)),
    ];

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
          onPressed: () => onChanged(index),
          child: tileIconMeld[index],
        );
      }
    );
  }
}

