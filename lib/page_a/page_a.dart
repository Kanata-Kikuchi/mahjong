import 'package:flutter/material.dart';
import 'package:mahjong/page_a/agari_tiles.dart';
import 'package:mahjong/boxes.dart';
import 'package:mahjong/page_a/huro.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/page_a/meld_tiles.dart';
import 'package:mahjong/page_a/score.dart';
import 'package:mahjong/page_a/select_option.dart';
import 'package:mahjong/page_a/select_tiles.dart';
import 'package:mahjong/page_a/select_type.dart';
import 'package:mahjong/page_a/select_meld.dart';


final List<Widget> manzu = [
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

final List<Widget> pinzu = [
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

final List<Widget> souzu = [
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

final List<Widget> zihai = [
  Image.asset(Images.zihai(1)),
  Image.asset(Images.zihai(2)),
  Image.asset(Images.zihai(3)),
  Image.asset(Images.zihai(4)),
  Image.asset(Images.zihai(5)),
  Image.asset(Images.zihai(6)),
  Image.asset(Images.zihai(7)),
];

Image back = Image.asset(Images.back.path);



class PageA extends StatefulWidget {
  const PageA({super.key});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {

  double horizontal = 10;
  double sizedBoxWidth = 10;
  double sizedBoxHeight = 10;

  int _selectType = 0;
  int _selectTile = 0;
  int _selectMeld = 0;

  int _countBrock = 0;
  int _countMenzen = 0;
  int _countToitsu = 0;
  int _countHuro = 0;
  int _countPushTsumoRon = 0;

  int _recordPushMeldType = 0;
  
  List<Widget> _menzen = List.generate(14, (_) => back);
  List<Widget> _huro = [];
  List<Widget> _menzenRecord = [];
  List<(int type, int tile)> _bufToitsu = [];
  List<(int type, int tile)> _bufBrock = [];
  List<(int type, int tile)> _bufAgari = [];

  void selectMeldOnChanged(int i) { //AgariTilesに描画する関数
    setState(() {
      _selectMeld = i;

      final List<Widget> tiles =
        (_selectType == 0) ? manzu
      : (_selectType == 1) ? pinzu
      : (_selectType == 2) ? souzu
      : zihai;

      switch(_selectMeld) {
        case 0: // 順子.
          if (_selectType == 3) {break;} // 字牌なら.
          if (_selectTile > 6) {break;} // 数牌が７以上なら.
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 1 > 4
           || _bufAgari.where((e) => e == (_selectType, _selectTile+1)).length + 1 > 4
           || _bufAgari.where((e) => e == (_selectType, _selectTile+2)).length + 1 > 4) {break;} // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.
          // AgariTileに渡す _menzen に追加.
          _menzen.setRange(_countMenzen, _countMenzen+3, [tiles[_selectTile], tiles[_selectTile+1], tiles[_selectTile+2]]);
          // 戻るボタンに渡す _bufBrock.
          _bufBrock.addAll([(_selectType, _selectTile), (_selectType, _selectTile+1), (_selectType, _selectTile+2)]);
          // ４枚以上にならないように管理する _bufAgari. 
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile+1), (_selectType, _selectTile+2)]);

          _countMenzen+=3;
          _countBrock++;
          _recordPushMeldType=1;
          break;
        case 1: // 暗刻.
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 3 > 4) {break;} // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.
          // AgariTileに渡す _menzen に追加.
          _menzen.setRange(_countMenzen, _countMenzen+3, [tiles[_selectTile], tiles[_selectTile], tiles[_selectTile]]);
          // 戻るボタンに渡す _bufBrock.
          _bufBrock.addAll([(_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile)]);
          // ４枚以上にならないように管理する _bufAgari.
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile)]);

          _countMenzen+=3;
          _countBrock++;
          _recordPushMeldType=1;
          break;
        case 2: // チー.
        if (_selectType == 3) {break;} // 字牌なら.
        if (_selectTile > 6) {break;} // 数牌が７以上なら.
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 1 > 4
           || _bufAgari.where((e) => e == (_selectType, _selectTile+1)).length + 1 > 4
           || _bufAgari.where((e) => e == (_selectType, _selectTile+2)).length + 1 > 4) {break;} // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.
          // AgariTileに渡す _menzen に追加.
          _menzen.removeRange(_menzen.length-3, _menzen.length);
          // AgariTileに渡す _huro に追加.
          _huro.add(SizedBox(width: 60));
          _huro.add(Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld));
          _huro.add(SizedBox(width: 60));
          // ４枚以上にならないように管理する _bufAgari.
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile+1), (_selectType, _selectTile+2)]);

          _countHuro++;
          _countBrock++;
          _recordPushMeldType=3;
          break;
        case 3: // ポン.
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 3 > 4) {break;} // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.
          // AgariTileに渡す _menzen に追加.
          _menzen.removeRange(_menzen.length-3, _menzen.length);
          // AgariTileに渡す _huro に追加.
          _huro.add(SizedBox(width: 55));
          _huro.add(Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld));
          _huro.add(SizedBox(width: 55));
          // ４枚以上にならないように管理する _bufAgari.
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile)]);
          
          _countHuro++;
          _countBrock++;
          _recordPushMeldType=3;
          break;
        case 4: // 暗槓.
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 4 > 4) {break;} // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.
          // AgariTileに渡す _menzen に追加.
          _menzen.removeRange(_menzen.length-3, _menzen.length);
          // AgariTileに渡す _huro に追加.
          _huro.add(SizedBox(width: 90));
          _huro.add(Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld));
          _huro.add(SizedBox(width: 90));
          // ４枚以上にならないように管理する _bufAgari.
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile)]);

          _countHuro++;
          _countBrock++;
          _recordPushMeldType=4;
          break;
        case 5: // 明槓.
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 4 > 4) {break;} // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.
          // AgariTileに渡す _menzen に追加.
          _menzen.removeRange(_menzen.length-3, _menzen.length);
          // AgariTileに渡す _huro に追加.
          _huro.add(SizedBox(width: 100));
          _huro.add(Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld));
          _huro.add(SizedBox(width: 100));
          // ４枚以上にならないように管理する _bufAgari.
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile), (_selectType, _selectTile)]);

          _countHuro++;
          _countBrock++;
          _recordPushMeldType=4;
          break;
        case 6: // 対子.
          if (_countToitsu == 7) {break;}
          if (_bufAgari.where((e) => e == (_selectType, _selectTile)).length + 2 > 4) {break;} // ( where.length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_countToitsu == 0) { //対子がないとき.
          // AgariTileに渡す _menzen に追加.
            _menzen.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
            _bufToitsu.add((_selectType, _selectTile));
            
            _countMenzen+=2;
            _countToitsu++;
          }
          /* 七対子制御(ここから) 

                手牌に対子が０組の時の<_menzen>の中身は、[]、[３]、[３，３]、[３，３、３]、[３，３、３、３]の５パターンがある。
                どのタイミングでも<SelectMeld>で対子を選択できるように条件分けをする。
                対子を１回選択しアガリが面子手だった場合、<_countMenzen>の取りうる値は、(２，５，８，１１)となる。
                七対子をアガリとする場合には<_countMenzen>の取りうる値は、(２，４，６，８，１０，１２，１４)となる。

                麻雀のアガリ形において対子は１組 or ７組になるため<_countToitsu>を用意し、上記の<対子==０組>で副露の有無に関係のない分岐を通す。
                面子手だった場合と七対子だった場合に重複する<_countMenzen>の値は、(２、８)である。

                <_countMenzen> == ２の場合は面子手にも七対子にも受け取れるように制御しなければならない。
                面子手の場合<_menzen>は、[２, ３]...a となるか、[２]+[<_huro>]...b となるかの２択。
                a の時は今後[２, ３, ２]のように対子が２組以上にならないように面子手の条件を(５, ８, １１)とし、
                ８枚の時に限り[２, ２, ２, ２]の対子手と重複するため<対子==４組>の条件で分岐をする。
                b の時は<_countHuro>を用意して刻子が１個でもあればブレイクさせる。

          */
          else if (_countMenzen == 5 || _countMenzen == 8 || _countMenzen == 11) { //手牌枚数が５, ８, １１の時.
            if (_countToitsu == 4) { //手牌が８枚の時に[３, ３, ２]と[２, ２, ２, ２]のパターンがあり、後者の対子手だけ通す.
              if (_bufToitsu.contains((_selectType, _selectTile))) {break;}
              _menzen.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
              _bufToitsu.add((_selectType, _selectTile));

              _countMenzen+=2;
              _countToitsu++;
            } else { //対子手じゃなければ.
              break;
            }
          } else if (_countToitsu < 7 && _countHuro == 0) { //対子手で、副露がなくて.
            if (_bufToitsu.contains((_selectType, _selectTile))) {break;} //今までに同じ対子がないか
            _menzen.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
            _bufToitsu.add((_selectType, _selectTile));

            _countMenzen+=2;
            _countToitsu++;
          }
          // 戻るボタンに渡す _bufBrock.
          _bufBrock.addAll([(_selectType, _selectTile), (_selectType, _selectTile)]);
          // ４枚以上にならないように管理する _bufAgari.
          _bufAgari.addAll([(_selectType, _selectTile), (_selectType, _selectTile)]);

          _recordPushMeldType=2;
        case 7: // 単騎.
          // if (_countHuro > 0 || _countMenzen > 0) {break;}
          // _menzen.setRange(0, 14, [manzu[0], manzu[8], pinzu[0], pinzu[8], souzu[0], souzu[8], zihai[0], zihai[1], zihai[2], zihai[3], zihai[4], zihai[5], zihai[6], zihai[6]]);
          // _countMenzen++;
          break;
      }
      // print("_bufAgari: $_bufAgari");
      // print("_menzen: $_menzen");
      // print("_huro: $_huro");
    });
  }




  void onPressedTsumo() {
    if(_bufBrock.length + _huro.length < 14) {return;} // 上がれる形じゃなければ.
    if(_countPushTsumoRon > 0) {return;} // 一度ツモかロンを押していたら.
    
    List<Widget> tiles(int t) =>
        (t == 0) ? manzu
      : (t == 1) ? pinzu
      : (t == 2) ? souzu
      : zihai;

    _bufBrock.sort((a, b) {
      int buf = a.$1.compareTo(b.$1);
      return buf != 0 ? buf : a.$2.compareTo(b.$2);
    });

    _menzenRecord = _menzen;
    _countPushTsumoRon++;
    
    setState(() {
      _menzen = _bufBrock.map((i) => tiles(i.$1)[i.$2]).toList();
    });

    // print("_R: $_menzenRecord");
    // print(_menzen);
  }




  void onPressedRon() {
    if(_bufBrock.length + _huro.length < 14) {return;} // 上がれる形じゃなければ.
    if(_countPushTsumoRon > 0) {return;} // 一度ツモかロンを押していたら.
    
    List<Widget> tiles(int t) =>
        (t == 0) ? manzu
      : (t == 1) ? pinzu
      : (t == 2) ? souzu
      : zihai;
    // print("_bufBrock: $_bufBrock");

    final sorted = _bufBrock.toList() // 参照渡しにならないように！コピー.
    ..sort((a, b) {
      int buf = a.$1.compareTo(b.$1);
      return buf != 0 ? buf : a.$2.compareTo(b.$2);
    });

    _menzenRecord = _menzen;
    _countPushTsumoRon++;
    
    setState(() {
      _menzen = sorted.map((i) => tiles(i.$1)[i.$2]).toList();
    });
    // print("_bufBrock: $_bufBrock");
    // print("soreted: $sorted");

    // print("_R: $_menzenRecord");
    // print(_menzen);
  }




  void onPressedModoru() { 
    print("_bufAgari: $_bufAgari");
    if (_bufAgari.length == 0) {return;} // SelectMeld が何も選択されていなければ.
    if (_countPushTsumoRon == 1) { // 上がれる形なら.
      _countPushTsumoRon--;
      setState(() {
        _menzen = _menzenRecord;  
      });
    }
    
    else if (_recordPushMeldType == 1) { // 順子/暗刻.
      setState(() {
        _menzen.removeRange(_countMenzen-3, _countMenzen);
        _menzen.addAll([back, back, back]);
        _bufBrock.removeRange(_bufBrock.length-3, _bufBrock.length);
        _bufAgari.removeRange(_bufAgari.length-3, _bufAgari.length);

        _countMenzen-=3;
        _countBrock--;
      });
    } else if (_recordPushMeldType == 2) { // 対子.
      setState(() {
        _menzen.removeRange(_countMenzen-2, _countMenzen);
        _menzen.addAll([back, back]);
        _bufBrock.removeRange(_bufBrock.length-2, _bufBrock.length);
        _bufAgari.removeRange(_bufAgari.length-2, _bufAgari.length);
        _bufToitsu.removeLast();

        print("_bufBrock: $_bufBrock");
        print("_bufAgari: $_bufAgari");
        print("_bufToitsu: $_bufToitsu");
        

        _countMenzen-=2;
        _countToitsu--;
      });
    } else if (_recordPushMeldType == 3) { // ポン/チー.
      setState(() {
        _huro.removeRange(_huro.length-3, _huro.length);
        _menzen.addAll([back, back, back]);
        _bufAgari.removeRange(_bufAgari.length-3, _bufAgari.length);

        _countHuro--;
        _countBrock--;
      });
    } else if (_recordPushMeldType == 4) { // 暗槓/明槓.
      setState(() {
        _huro.removeRange(_huro.length-3, _huro.length);
        _menzen.addAll([back, back, back]);
        _bufAgari.removeRange(_bufAgari.length-4, _bufAgari.length);

        _countHuro--;
        _countBrock--;
      });
    }





    
    // print("_R: $_menzenRecord");
    // print(_menzen);
  }




  void onPressedOkuru() {}

  Widget _test = Text("test");

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(flex: 3,
        child: Row(children: [
          Expanded(flex: 1,
            child: Column(children: [
              Expanded(
                child: BoxB("SelectType", child:
                  SelectType(
                    onChanged: (i) => setState(() {
                      _selectType = i;
                      _selectTile = 0;
                    })
                  ),
                )
              ),
              Expanded(
                child: BoxB("SelectTiles", child:
                  SelectTiles(
                    key: ValueKey(_selectType),
                    typeIndex: _selectType,
                    onChanged: (i) => setState(() {
                      _selectTile = i;
                    })
                  )
                )
              )
            ])
          ),
          Expanded(flex: 1,
            child: BoxB("SelectMeld", child:
              SelectMeld(
                typeIndex: _selectType,
                tileIndex: _selectTile,
                onChanged: selectMeldOnChanged
              )
            )
          ),
          Expanded(flex: 2,
            child: Column(children: [
              Expanded(flex: 3,
                child: BoxB("Score", child:
                  Score()
                )
              ),
              Expanded(flex: 1,
                child: BoxB("Option", child:
                  SelectOption(
                    onPressedTsumo: onPressedTsumo,
                    onPressedRon: onPressedRon,
                    onPressedModoru: onPressedModoru,
                    onPressedOkuru: onPressedModoru,
                  )
                )
              )
            ],)
          )
        ]),
      ),
      Expanded(flex: 1,
        child: BoxB("AgariTiles",
          child: AgariTiles(
            brockTiles: _menzen,
            huroTiles: _huro
            )
        )
      )
    ]);
  }
}