import 'package:flutter/material.dart';
import 'package:mahjong/agari_tiles.dart';
import 'package:mahjong/boxes.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/meld_record.dart';
import 'package:mahjong/meld_tiles.dart';
import 'package:mahjong/select_tiles.dart';
import 'package:mahjong/select_type.dart';
import 'package:mahjong/select_meld.dart';
import 'package:mahjong/test.dart';


Image back = Image.asset(Images.back.path, scale: 2);

class PageA extends StatefulWidget {
  const PageA({super.key});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {

  int _selectType = 0;
  int _selectTile = 0;
  int _selectMeld = 0;
  int _countMeld = 0;
  int _countMenzen = 0;
  int _countToitsu = 0;
  int _countHuro = 0;
  List<Widget> _brock = List.generate(14, (_) => back);
  List<Widget> _huro = [];
  Set<(int type, int tile)> _bufToitsu = {};

  void selectMeldOnChanged(int i) { //AgariTilesに描画する関数
    setState(() {
      _selectMeld = i;

      List<Widget> manzu = [
        Image.asset(Images.manzu(1), scale: 2),
        Image.asset(Images.manzu(2), scale: 2),
        Image.asset(Images.manzu(3), scale: 2),
        Image.asset(Images.manzu(4), scale: 2),
        Image.asset(Images.manzu(5), scale: 2),
        Image.asset(Images.manzu(6), scale: 2),
        Image.asset(Images.manzu(7), scale: 2),
        Image.asset(Images.manzu(8), scale: 2),
        Image.asset(Images.manzu(9), scale: 2),
      ];

      List<Widget> pinzu = [
        Image.asset(Images.pinzu(1), scale: 2),
        Image.asset(Images.pinzu(2), scale: 2),
        Image.asset(Images.pinzu(3), scale: 2),
        Image.asset(Images.pinzu(4), scale: 2),
        Image.asset(Images.pinzu(5), scale: 2),
        Image.asset(Images.pinzu(6), scale: 2),
        Image.asset(Images.pinzu(7), scale: 2),
        Image.asset(Images.pinzu(8), scale: 2),
        Image.asset(Images.pinzu(9), scale: 2),
      ];

      List<Widget> souzu = [
        Image.asset(Images.souzu(1), scale: 2),
        Image.asset(Images.souzu(2), scale: 2),
        Image.asset(Images.souzu(3), scale: 2),
        Image.asset(Images.souzu(4), scale: 2),
        Image.asset(Images.souzu(5), scale: 2),
        Image.asset(Images.souzu(6), scale: 2),
        Image.asset(Images.souzu(7), scale: 2),
        Image.asset(Images.souzu(8), scale: 2),
        Image.asset(Images.souzu(9), scale: 2),
      ];

      List<Widget> zihai = [
        Image.asset(Images.zihai(1), scale: 2),
        Image.asset(Images.zihai(2), scale: 2),
        Image.asset(Images.zihai(3), scale: 2),
        Image.asset(Images.zihai(4), scale: 2),
        Image.asset(Images.zihai(5), scale: 2),
        Image.asset(Images.zihai(6), scale: 2),
        Image.asset(Images.zihai(7), scale: 2),
      ];

      final List<Widget> tiles = //PageAで管理している状態によって表示するリストを変更.
        (_selectType == 0) ? manzu
      : (_selectType == 1) ? pinzu
      : (_selectType == 2) ? souzu
      : zihai;

      switch(_selectMeld) {
        case 0: // 順子.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countMeld > 3) {break;} // 刻子が４組以上なら.
          _brock.setRange(_countMenzen, _countMenzen+3, [tiles[_selectTile], tiles[_selectTile+1], tiles[_selectTile+2]]);
          _countMenzen+=3;
          _countMeld++;
          break;
        case 1: // 暗刻.
          if (_countToitsu > 1) {break;}
          if (_countMeld > 3) {break;}
          _brock.setRange(_countMenzen, _countMenzen+3, [tiles[_selectTile], tiles[_selectTile], tiles[_selectTile]]);
          _countMenzen+=3;
          _countMeld++;
          break;
        case 2: // チー.
          if (_countToitsu > 1) {break;}
          if (_countMeld > 3) {break;}
          _brock.removeRange(_brock.length-3, _brock.length);
          _huro.add(SizedBox(width: 45));
          _huro.add(Transform.scale(scale: 1.2, child: Chi(typeIndex: _selectType, tileIndex: _selectTile)));
          _huro.add(SizedBox(width: 45));
          _countHuro++;
          _countMeld++;
          break;
        case 3: // ポン.
          if (_countToitsu > 1) {break;}
          if (_countMeld > 3) {break;}
          _brock.removeRange(_brock.length-3, _brock.length);
          _huro.add(SizedBox(width: 45));
          _huro.add(Transform.scale(scale: 1.2, child: Pon(typeIndex: _selectType, tileIndex: _selectTile)));
          _huro.add(SizedBox(width: 45));
          _countHuro++;
          _countMeld++;
          break;
        case 4: // 暗槓.
          if (_countToitsu > 1) {break;}
          if (_countMeld > 3) {break;}
          _brock.removeRange(_brock.length-3, _brock.length);
          _huro.add(SizedBox(width: 61));
          _huro.add(Transform.scale(scale: 1.2, child: Ankan(typeIndex: _selectType, tileIndex: _selectTile)));
          _huro.add(SizedBox(width: 61));
          _countHuro++;
          _countMeld++;
          break;
        case 5: // 明槓.
          if (_countToitsu > 1) {break;}
          if (_countMeld > 3) {break;}
          _brock.removeRange(_brock.length-3, _brock.length);
          _huro.add(SizedBox(width: 65));
          _huro.add(Transform.scale(scale: 1.2, child: Minkan(typeIndex: _selectType, tileIndex: _selectTile)));
          _huro.add(SizedBox(width: 65));
          _countHuro++;
          _countMeld++;
          break;
        case 6: // 対子.
          if (_countToitsu == 0) { //対子がないとき.
            _brock.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
            _bufToitsu.add((_selectType, _selectTile));
            _countMenzen+=2;
            _countToitsu++;
          }
          /* 七対子制御(ここから) 

                手牌に対子が０組の時の<_brock>の中身は、[]、[３]、[３，３]、[３，３、３]、[３，３、３、３]の５パターンがある。
                どのタイミングでも<SelectMeld>で対子を選択できるように条件分けをする。
                対子を１回選択しアガリが面子手だった場合、<_countMenzen>の取りうる値は、(２，５，８，１１)となる。
                七対子をアガリとする場合には<_countMenzen>の取りうる値は、(２，４，６，８，１０，１２，１４)となる。

                麻雀のアガリ形において対子は１組 or ７組になるため<_countToitsu>を用意し、上記の<対子==０組>で副露の有無に関係のない分岐を通す。
                面子手だった場合と七対子だった場合に重複する<_countMenzen>の値は、(２、８)である。

                <_countMenzen> == ２の場合は面子手にも七対子にも受け取れるように制御しなければならない。
                面子手の場合<_brock>は、[２, ３]...a となるか、[２]+[<_huro>]...b となるかの２択。
                a の時は今後[２, ３, ２]のように対子が２組以上にならないように面子手の条件を(５, ８, １１)とし、
                ８枚の時に限り[２, ２, ２, ２]の対子手と重複するため<対子==４組>の条件で分岐をする。
                b の時は<_countHuro>を用意して刻子が１個でもあればブレイクさせる。

          */
          else if (_countMenzen == 5 || _countMenzen == 8 || _countMenzen == 11) { //手牌枚数が５, ８, １１の時.
            if (_countToitsu == 4) { //手牌が８枚の時に[３, ３, ２]と[２, ２, ２, ２]のパターンがあり、後者の対子手だけ通す.
              if (_bufToitsu.contains((_selectType, _selectTile))) {break;}
              _brock.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
              _bufToitsu.add((_selectType, _selectTile));
              _countMenzen+=2;
              _countToitsu++;
            } else { //対子手じゃなければ.
              break;
            }
          } else if (_countToitsu < 7 && _countHuro == 0) { //対子手で、副露がなくて.
            if (_bufToitsu.contains((_selectType, _selectTile))) {break;} //今までに同じ対子がないか
            _brock.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
            _bufToitsu.add((_selectType, _selectTile));
            _countMenzen+=2;
            _countToitsu++;
          }
        case 7: // 単騎.
          break;
          // if (_countHuro > 0 || _countMenzen > 0) {break;}
          // _brock.setRange(0, 14, [manzu[0], manzu[8], pinzu[0], pinzu[8], souzu[0], souzu[8], zihai[0], zihai[1], zihai[2], zihai[3], zihai[4], zihai[5], zihai[6], zihai[6]]);
          // _countMenzen++;
          // break;
      }
    });
  }

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
                  BoxB("SelectMeld", 9999, 260),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Column(children: [
                    SizedBox(height: 16),
                    SelectMeld(
                      typeIndex: _selectType,
                      tileIndex: _selectTile,
                      onChanged: selectMeldOnChanged
                    )
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
              Transform.translate(offset: Offset(0, 8), child: AgariTiles(
                brockTiles: _brock, huroTiles: _huro,
              ))
            ],)
          ))
        ),       
      ],
    );
  }
}