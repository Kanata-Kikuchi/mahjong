import 'package:flutter/material.dart';
import 'package:mahjong/agari_tiles.dart';
import 'package:mahjong/images.dart';
import 'dart:math' as math;

  List<Widget> manzu = [
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

  List<Widget> pinzu = [
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

  List<Widget> souzu = [
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

  List<Widget> zihai = [
    Image.asset(Images.zihai(1)),
    Image.asset(Images.zihai(2)),
    Image.asset(Images.zihai(3)),
    Image.asset(Images.zihai(4)),
    Image.asset(Images.zihai(5)),
    Image.asset(Images.zihai(6)),
    Image.asset(Images.zihai(7)),
  ];

  final back = Image.asset(Images.backTile(1));

class Pon extends StatelessWidget {
  Pon({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate( //中.
              offset: Offset(10, 18),
              child: Transform.rotate(angle: math.pi/2, child: tiles[tileIndex])
            ),
            Transform.translate( //右.
              offset: Offset(92, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //左.
              offset: Offset(-88, 0),
              child: tiles[tileIndex]
            ),
          ],
        ),
      ),
    );
  }
}

class Chi extends StatelessWidget {
  const Chi({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    if (typeIndex > 2) {
      return SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          fit: BoxFit.contain,
          child:Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Transform.translate( //左.
                offset: Offset(-71, 18),
                child: Transform.rotate(angle: math.pi/2, child: back)
              ),
              Transform.translate( //右.
                offset: Offset(92, 0),
                child: back
              ),
              Transform.translate( //中.
                offset: Offset(10, 0),
                child: back
              ),
            ],
          )
        ),
      );
    }

    if (tileIndex > 6) {
      return SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          fit: BoxFit.contain,
          child:Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Transform.translate( //左.
                offset: Offset(-71, 18),
                child: Transform.rotate(angle: math.pi/2, child: back)
              ),
              Transform.translate( //右.
                offset: Offset(92, 0),
                child: back
              ),
              Transform.translate( //中.
                offset: Offset(10, 0),
                child: back
              ),
            ],
          )
        ),
      );
    }

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child:Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate( //左.
              offset: Offset(-71, 18),
              child: Transform.rotate(angle: math.pi/2, child: tiles[tileIndex])
            ),
            Transform.translate( //右.
              offset: Offset(92, 0),
              child: tiles[tileIndex + 2]
            ),
            Transform.translate( //中.
              offset: Offset(10, 0),
              child: tiles[tileIndex + 1]
            ),
          ],
        )
      ),
    );
  }
}

class Ankan extends StatelessWidget {
  const Ankan({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate( //右.
              offset: Offset(123, 0),
              child: Image.asset(Images.backTile(1))
            ),
            Transform.translate( //中右.
              offset: Offset(41, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //中左.
              offset: Offset(-41, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //左.
              offset: Offset(-123, 0),
              child: Image.asset(Images.backTile(1))
            ),
          ],
        )
      ),
    );
  }
}

class Minkan extends StatelessWidget {
  const Minkan({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate( //中左.
              offset: Offset(-50, 18),
              child: Transform.rotate(
                angle: -math.pi/2, child: Image.asset(Images.backTile(1)),
              )
            ),
            Transform.translate( //右.
              offset: Offset(132, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //中右.
              offset: Offset(50, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //左.
              offset: Offset(-130, 0),
              child: tiles[tileIndex]
            ),
          ],
        )
      ),
    );
  }
}

class Syuntu extends StatelessWidget {
  const Syuntu({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    if (typeIndex > 2) {
      return SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Transform.translate( //右.
                offset: Offset(82, 0),
                child: back
              ),
              Transform.translate( //中.
                offset: Offset(0, 0),
                child: back
              ),
              Transform.translate( //左.
                offset: Offset(-82, 0),
                child: back
              ),
            ],
          )
        ),
      );
    }

    if (tileIndex > 6) {
      return SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Transform.translate( //右.
                offset: Offset(82, 0),
                child: back
              ),
              Transform.translate( //中.
                offset: Offset(0, 0),
                child: back
              ),
              Transform.translate( //左.
                offset: Offset(-82, 0),
                child: back
              ),
            ],
          )
        ),
      );
    }

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate( //右.
              offset: Offset(82, 0),
              child: tiles[tileIndex + 2]
            ),
            Transform.translate( //中.
              offset: Offset(0, 0),
              child: tiles[tileIndex + 1]
            ),
            Transform.translate( //左.
              offset: Offset(-82, 0),
              child: tiles[tileIndex]
            ),
          ],
        )
      ),
    );
  }
}

class Anko extends StatelessWidget {
  const Anko({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate( //右.
              offset: Offset(82, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //中.
              offset: Offset(0, 0),
              child: tiles[tileIndex]
            ),
            Transform.translate( //左.
              offset: Offset(-82, 0),
              child: tiles[tileIndex]
            ),
          ],
        )
      ),
    );
  }
}

class Tsumo extends StatelessWidget {
  const Tsumo({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.translate(
          offset: Offset(0, 0),
          child: tiles[tileIndex]
        ),
      )
    );
  }
}

class Ron extends StatelessWidget {
  const Ron({required this.typeIndex, required this.tileIndex, super.key});

  final int typeIndex;
  final int tileIndex;

  @override
  Widget build(BuildContext context) {

    final List<Widget> tiles = //PickBで管理している状態によって表示するリストを変更.
      (typeIndex == 0) ? manzu
    : (typeIndex == 1) ? pinzu
    : (typeIndex == 2) ? souzu
    : zihai;

    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.translate(
          offset: Offset(0, 0),
          child: Transform.rotate(
            angle: -math.pi/2, child: tiles[tileIndex]
          )
        ),
      )
    );
  }
}