import 'package:flutter/material.dart';
import 'package:mahjong/agari_tiles.dart';
import 'package:mahjong/boxes.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/pick_a.dart';
import 'package:mahjong/select_tiles.dart';
import 'package:mahjong/select_type.dart';
import 'package:mahjong/select_action.dart';
import 'package:mahjong/test.dart';


Image back = Image.asset(Images.back.path, scale: 5,);

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10),
              Expanded(flex: 1, //SelectType
                child: Stack(alignment: Alignment.center, children: [
                  BoxB("SelectType", 9999, 260),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child:Column(children: [
                    SizedBox(height: 16),
                    PickA()
                  ]))
                ],)
              ),
              SizedBox(width: 10),
              Expanded(flex: 1, //SelectTiles
                child: Stack(alignment: Alignment.center, children: [
                  BoxB("SelectTiles", 9999, 260),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Column(children: [
                    SizedBox(height: 16),
                    SelectActionWidget()
                  ],))
                ],)
              ),
              SizedBox(width: 10),
              Expanded(flex: 2, //Score
                child: Stack(alignment: Alignment.center, children: [
                  BoxB("Score", 9999, 260),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    BoxA(150, 220),
                    BoxA(150, 220),
                  ],)
                ],)
              ),
              SizedBox(width: 10),
            ],
          )
        ),
        Expanded(flex: 1,
          child: Transform.translate(offset: Offset(0, -10), child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(alignment: Alignment.center, children: [
              BoxB("AgariTiles", 9999, 9999),
              Transform.translate(offset: Offset(0, 8), child: AgariTiles())
            ],)
          ))
        ),       
      ],
    );
  }
}