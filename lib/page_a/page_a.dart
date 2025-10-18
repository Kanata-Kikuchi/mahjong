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
  
  List<Widget> _menzen = List.generate(14, (_) => back);
  List<Widget> _huro = [];
  List<Widget> _menzenRecord = [];
  List<int> _recordPushMeldType = [];
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
        case 0: { // 順子.

          final key0 = (_selectType, _selectTile);
          final key1 = (_selectType, _selectTile + 1);
          final key2 = (_selectType, _selectTile + 2);
          

          if (_selectType == 3) {break;} // 字牌なら.
          if (_selectTile > 6) {break;} // 数牌が７以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.

          // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_bufAgari.where((e) => e == key0).length + 1 > 4
           || _bufAgari.where((e) => e == key1).length + 1 > 4
           || _bufAgari.where((e) => e == key2).length + 1 > 4) {break;}


          _bufBrock.addAll([key0, key1, key2]); // 戻るボタンに渡す _bufBrock.
          _bufAgari.addAll([key0, key1, key2]); // ４枚以上にならないように管理する _bufAgari.
          _menzen.setRange( // AgariTileに渡す _menzen に追加.
            _countMenzen, _countMenzen+3,
            [tiles[_selectTile], tiles[_selectTile+1], tiles[_selectTile+2]]
          ); 

          _countMenzen+=3;
          _countBrock++;
          _recordPushMeldType.add(0);
          break;
        }

        case 1: { // 暗刻.

          final key = (_selectType, _selectTile);


          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if ( _countBrock > 3) {break;} // 刻子が４組以上なら.

          // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_bufAgari.where((e) => e == key).length + 3 > 4) {break;}
          
          
          _bufBrock.addAll([key, key, key]); // 戻るボタンに渡す _bufBrock.
          _bufAgari.addAll([key, key, key]); // ４枚以上にならないように管理する _bufAgari.
          _menzen.setRange( // AgariTileに渡す _menzen に追加.
            _countMenzen, _countMenzen+3,
            [tiles[_selectTile], tiles[_selectTile], tiles[_selectTile]]
          );

          _countMenzen+=3;
          _countBrock++;
          _recordPushMeldType.add(1);
          break;
        }

        case 2: { // チー.

          final key0 = (_selectType, _selectTile);
          final key1 = (_selectType, _selectTile + 1);
          final key2 = (_selectType, _selectTile + 2);
          

          if (_selectType == 3) {break;} // 字牌なら.
          if (_selectTile > 6) {break;} // 数牌が７以上なら.
          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if (_countBrock > 3) {break;} // 刻子が４組以上なら.

          // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_bufAgari.where((e) => e == key0).length + 1 > 4
           || _bufAgari.where((e) => e == key1).length + 1 > 4
           || _bufAgari.where((e) => e == key2).length + 1 > 4) {break;}


          _bufAgari.addAll([key0, key1, key2]); // ４枚以上にならないように管理する _bufAgari.
          _menzen.removeRange(_menzen.length-3, _menzen.length); // AgariTileに渡す _menzen を１ブロックにつき３枚削除.
          _huro.addAll([// AgariTileに渡す _huro に追加.
            SizedBox(width: 60),
            Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld),
            SizedBox(width: 60)
          ]);

          _countHuro++;
          _countBrock++;
          _recordPushMeldType.add(2);
          break;
        }

        case 3: { // ポン.

          final key = (_selectType, _selectTile);


          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if ( _countBrock > 3) {break;} // 刻子が４組以上なら.

          // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_bufAgari.where((e) => e == key).length + 3 > 4) {break;}


          _bufAgari.addAll([key, key, key]); // ４枚以上にならないように管理する _bufAgari.
          _menzen.removeRange(_menzen.length-3, _menzen.length); // AgariTileに渡す _menzen を１ブロックにつき３枚削除.
          _huro.addAll([ // AgariTileに渡す _huro に追加.
            SizedBox(width: 55),
            Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld),
            SizedBox(width: 55)
          ]);
          
          _countHuro++;
          _countBrock++;
          _recordPushMeldType.add(3);
          break;
        }

        case 4: { // 暗槓.

          final key = (_selectType, _selectTile);


          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if ( _countBrock > 3) {break;} // 刻子が４組以上なら.

          // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_bufAgari.where((e) => e == key).length + 4 > 4) {break;}


          _bufAgari.addAll([key, key, key, key]); // ４枚以上にならないように管理する _bufAgari.
          _menzen.removeRange(_menzen.length-3, _menzen.length); // AgariTileに渡す _menzen を１ブロックにつき３枚削除.
          _huro.addAll([ // AgariTileに渡す _huro に追加.
            SizedBox(width: 90),
            Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld),
            SizedBox(width: 90)
          ]);

          _countHuro++;
          _countBrock++;
          _recordPushMeldType.add(4);
          break;
        }

        case 5: { // 明槓.

          final key = (_selectType, _selectTile);


          if (_countToitsu > 1) {break;} // 対子が２組以上なら.
          if ( _countBrock > 3) {break;} // 刻子が４組以上なら.

          // ( length + 増える数 > 4 )同一牌が４枚以上なら.
          if (_bufAgari.where((e) => e == key).length + 4 > 4) {break;}


          _bufAgari.addAll([key, key, key, key]); // ４枚以上にならないように管理する _bufAgari.
          _menzen.removeRange(_menzen.length-3, _menzen.length); // AgariTileに渡す _menzen を１ブロックにつき３枚削除.
          _huro.addAll([ // AgariTileに渡す _huro に追加.
            SizedBox(width: 100),
            Huro(typeIndex: _selectType, tileIndex: _selectTile, meldIndex: _selectMeld),
            SizedBox(width: 100)
          ]);

          _countHuro++;
          _countBrock++;
          _recordPushMeldType.add(5);
          break;
        }
        case 6: { // 対子.

          final key = (_selectType, _selectTile); 
          bool accepted = false;


          if (_countToitsu == 7) {break;} // 対子が７組なら.
          if (_bufAgari.where((e) => e == key).length + 2 > 4) {break;} // ( where.length + 増える数 > 4 )同一牌が４枚以上なら.

          /* 七対子制御

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

          //対子がないとき.
          if (_countToitsu == 0) {
            _menzen.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
            _bufToitsu.add(key);
            accepted = true;
          }
          //手牌が８枚の時に[３, ３, ２]と[２, ２, ２, ２]のパターンがあり、後者の対子手だけ通す.
          else if (_countMenzen == 8 && _countToitsu == 4) {
            if (!_bufToitsu.contains(key)) {
              _menzen.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
              _bufToitsu.add(key);
              accepted = true;
            }
          }
          //対子手で、副露がなくて.
          else if (_countToitsu < 7 && _countHuro == 0) {
            if (!_bufToitsu.contains(key)) {
              _menzen.setRange(_countMenzen, _countMenzen+2, [tiles[_selectTile], tiles[_selectTile]]);
              _bufToitsu.add(key);
              accepted = true;
            }
          }


          if (accepted) {
            _countMenzen+=2;
            _countToitsu++;

            _bufBrock.addAll([key, key]); // 戻るボタンに渡す _bufBrock.
            _bufAgari.addAll([key, key]); // ４枚以上にならないように管理する _bufAgari.
            _recordPushMeldType.add(6); // 戻るボタンに渡す _recordPushMeldType.
          }
          break;
        }

        case 7: // 単騎.
          // if (_countHuro > 0 || _countMenzen > 0) {break;}
          // _menzen.setRange(0, 14, [manzu[0], manzu[8], pinzu[0], pinzu[8], souzu[0], souzu[8], zihai[0], zihai[1], zihai[2], zihai[3], zihai[4], zihai[5], zihai[6], zihai[6]]);
          // _countMenzen++;
          break;
      }

      // print("_bufAgari: $_bufAgari");
      // print("_menzen: $_menzen");
      // print("_huro: $_huro");
      // print("_recordPushMeldType: $_recordPushMeldType");


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
    if (_bufAgari.length == 0) {return;} // SelectMeld が何も選択されていなければ.
    if (_countPushTsumoRon == 1) { // 上がれる形なら.
      _countPushTsumoRon--;
      setState(() {
        _menzen = _menzenRecord;  
      });
    }
    
    else if (_recordPushMeldType.last == 0) { // 順子.
      setState(() {
        _menzen.removeRange(_countMenzen-3, _countMenzen);
        _menzen.addAll([back, back, back]);
        _bufBrock.removeRange(_bufBrock.length-3, _bufBrock.length);
        _bufAgari.removeRange(_bufAgari.length-3, _bufAgari.length);

        _countMenzen-=3;
        _countBrock--;
        _recordPushMeldType.removeLast();
      });
    } else if (_recordPushMeldType.last == 1) { // 暗刻.
      setState(() {
        _menzen.removeRange(_countMenzen-3, _countMenzen);
        _menzen.addAll([back, back, back]);
        _bufBrock.removeRange(_bufBrock.length-3, _bufBrock.length);
        _bufAgari.removeRange(_bufAgari.length-3, _bufAgari.length);

        _countMenzen-=3;
        _countBrock--;
        _recordPushMeldType.removeLast();
      });
    } else if (_recordPushMeldType.last == 2) { // チー.
      setState(() {
        _huro.removeRange(_huro.length-3, _huro.length);
        _menzen.addAll([back, back, back]);
        _bufAgari.removeRange(_bufAgari.length-3, _bufAgari.length);

        _countHuro--;
        _countBrock--;
        _recordPushMeldType.removeLast();
      });
    } else if (_recordPushMeldType.last == 3) { // ポン.
      setState(() {
        _huro.removeRange(_huro.length-3, _huro.length);
        _menzen.addAll([back, back, back]);
        _bufAgari.removeRange(_bufAgari.length-3, _bufAgari.length);

        _countHuro--;
        _countBrock--;
        _recordPushMeldType.removeLast();
      });
    } else if (_recordPushMeldType.last == 4) { // 暗槓.
      setState(() {
        _huro.removeRange(_huro.length-3, _huro.length);
        _menzen.addAll([back, back, back]);
        _bufAgari.removeRange(_bufAgari.length-4, _bufAgari.length);

        _countHuro--;
        _countBrock--;
        _recordPushMeldType.removeLast();
      });
    } else if (_recordPushMeldType.last == 5) { // 明槓.
      setState(() {
        _huro.removeRange(_huro.length-3, _huro.length);
        _menzen.addAll([back, back, back]);
        _bufAgari.removeRange(_bufAgari.length-4, _bufAgari.length);

        _countHuro--;
        _countBrock--;
        _recordPushMeldType.removeLast();
      });
    } else if (_recordPushMeldType.last == 6) { // 対子.
      setState(() {
        _menzen.removeRange(_countMenzen-2, _countMenzen);
        _menzen.addAll([back, back]);
        _bufBrock.removeRange(_bufBrock.length-2, _bufBrock.length);
        _bufAgari.removeRange(_bufAgari.length-2, _bufAgari.length);
        _bufToitsu.removeLast();

        _countMenzen-=2;
        _countToitsu--;
        _recordPushMeldType.removeLast();
      });
    }


    // print("_bufAgari: $_bufAgari");


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