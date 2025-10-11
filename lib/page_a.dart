import 'package:flutter/material.dart';
import 'package:mahjong/agari_tiles.dart';
import 'package:mahjong/boxes.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/meld_tiles.dart';
import 'package:mahjong/select_tiles.dart';
import 'package:mahjong/select_type.dart';
import 'package:mahjong/select_meld.dart';
import 'package:mahjong/test.dart';


Image back = Image.asset(Images.back.path, scale: 5,);

class PageA extends StatefulWidget {
  const PageA({super.key});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {

  int _selectType = 0;
  int _selectTile = 0;

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
              Expanded(flex: 1, //SelectType.
                child: Stack(alignment: Alignment.center, children: [
                  BoxB("SelectType", 9999, 260),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child:Column(children: [
                    SizedBox(height: 16),
                    Column(children: [
                      /* 1: SelectTypeのボタン押下によってSelectTilesの変更(ここから) */
                      SelectType(
                        onChanged: (i) => setState(() {
                          _selectType = i;
                          _selectTile = 0;
                        }),
                      ),
                      Transform.translate(offset: Offset(0, -16), child: Stack(children: [
                        BoxA(140, 108),
                        SizedBox(width: 140, height: 108, child: SelectTiles(
                          /* 基本的にWidhetは再利用されるため、牌種(Configuratioon)を変更してもスクロール位置が保持される(State)。
                          keyの変更を明示すると再build時にWidgetの作り変えが起き、スクロール位置が初期値になる。*/
                          key: ValueKey(_selectType),                        
                          typeIndex: _selectType,
                          onChanged: (i) => setState(() {
                            _selectTile = i;
                          })
                        ))                      
                      ]))
                      /* 1: SelectTypeのボタン押下によってSelectTilesの変更(ここまで) */
                  ])]))
                ],)
              ),
              SizedBox(width: 10),
              Expanded(flex: 1, //SelectTiles.
                child: Stack(alignment: Alignment.center, children: [
                  BoxB("SelectTiles", 9999, 260),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Column(children: [
                    SizedBox(height: 16),
                    SelectMeld(typeIndex: _selectType, tileIndex: _selectTile)
                  ],))
                ],)
              ),
              SizedBox(width: 10),
              Expanded(flex: 2, //Score.
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