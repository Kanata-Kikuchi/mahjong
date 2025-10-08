import 'package:flutter/material.dart';
import 'package:mahjong/images.dart';
import 'dart:math' as math;



class Pon extends StatefulWidget {
  const Pon({super.key});

  @override
  State<Pon> createState() => _PonState();
}

class _PonState extends State<Pon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(10, 18),
              child: Transform.rotate(angle: math.pi/2, child: Image.asset(Images.manzu(5)))
            ),
            Transform.translate(
              offset: Offset(92, 0),
              child: Image.asset(Images.manzu(5))
            ),
            Transform.translate(
              offset: Offset(-88, 0),
              child: Image.asset(Images.manzu(5))
            ),

          ],
        ),
      ),
    );
  }
}



class Chi extends StatefulWidget {
  const Chi({super.key});

  @override
  State<Chi> createState() => _ChiState();
}

class _ChiState extends State<Chi> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child:Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(-71, 18),
              child: Transform.rotate(angle: math.pi/2, child: Image.asset(Images.manzu(3)))
            ),
            Transform.translate(
              offset: Offset(92, 0),
              child: Image.asset(Images.manzu(2))
            ),
            Transform.translate(
              offset: Offset(10, 0),
              child: Image.asset(Images.manzu(1))
            ),
          ],
        )
      ),
    );
  }
}




class Ankan extends StatefulWidget {
  const Ankan({super.key});

  @override
  State<Ankan> createState() => _AnkanState();
}

class _AnkanState extends State<Ankan> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(123, 0),
              child: Image.asset(Images.backTile(1))
            ),
            Transform.translate(
              offset: Offset(41, 0),
              child: Image.asset(Images.pinzu(2))
            ),
            Transform.translate(
              offset: Offset(-41, 0),
              child: Image.asset(Images.pinzu(2))
            ),
            Transform.translate(
              offset: Offset(-123, 0),
              child: Image.asset(Images.backTile(1))
            ),
          ],
        )
      ),
    );
  }
}



class Minkan extends StatefulWidget {
  const Minkan({super.key});

  @override
  State<Minkan> createState() => _MinkanState();
}

class _MinkanState extends State<Minkan> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(-50, 18),
              child: Transform.rotate(
                angle: -math.pi/2, child: Image.asset(Images.backTile(1)),
              )
            ),
            Transform.translate(
              offset: Offset(132, 0),
              child: Image.asset(Images.pinzu(8))
            ),
            Transform.translate(
              offset: Offset(50, 0),
              child: Image.asset(Images.pinzu(8))
            ),
            Transform.translate(
              offset: Offset(-130, 0),
              child: Image.asset(Images.pinzu(8))
            ),
          ],
        )
      ),
    );
  }
}



class Syuntu extends StatefulWidget {
  const Syuntu({super.key});

  @override
  State<Syuntu> createState() => _SyuntuState();
}

class _SyuntuState extends State<Syuntu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(82, 0),
              child: Image.asset(Images.souzu(3))
            ),
            Transform.translate(
              offset: Offset(0, 0),
              child: Image.asset(Images.souzu(2))
            ),
            Transform.translate(
              offset: Offset(-82, 0),
              child: Image.asset(Images.souzu(1))
            ),
          ],
        )
      ),
    );
  }
}



class Anko extends StatefulWidget {
  const Anko({super.key});

  @override
  State<Anko> createState() => _AnkoState();
}

class _AnkoState extends State<Anko> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: Offset(82, 0),
              // child: Image.asset(Images.souzu(7))
              child: Image.asset(Images.zihai(1))
            ),
            Transform.translate(
              offset: Offset(0, 0),
              // child: Image.asset(Images.souzu(7))
              child: Image.asset(Images.zihai(1))
            ),
            Transform.translate(
              offset: Offset(-82, 0),
              // child: Image.asset(Images.souzu(7))
              child: Image.asset(Images.zihai(1))
            ),
          ],
        )
      ),
    );
  }
}


class Tsumo extends StatefulWidget {
  const Tsumo({super.key});

  @override
  State<Tsumo> createState() => _TsumoState();
}

class _TsumoState extends State<Tsumo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.translate(
          offset: Offset(0, 0),
          // child: Image.asset(Images.souzu(7))
          child: Image.asset(Images.zihai(1))
        ),
      )
    );
  }
}


class Ron extends StatefulWidget {
  const Ron({super.key});

  @override
  State<Ron> createState() => _RonState();
}

class _RonState extends State<Ron> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.translate(
          offset: Offset(0, 0),
          // child: Image.asset(Images.souzu(7))
          child: Transform.rotate(
            angle: -math.pi/2, child: Image.asset(Images.zihai(1))
          )
        ),
      )
    );
  }
}