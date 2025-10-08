import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';

Image back = Image.asset(Images.back.path, scale: 1.7);

class AgariTiles extends StatelessWidget {
  const AgariTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(13, (_) => back),
    );
  }
}