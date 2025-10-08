import 'package:flutter/material.dart';
import 'package:mahjong/meld_tiles.dart';

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Pon(),
            SizedBox(height: 100, width: 200,),
            Chi(),
          ],),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Ankan(),
            SizedBox(height: 100, width: 200,),
            Minkan(),
          ],),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Syuntu(),
            SizedBox(height: 100, width: 200,),
            Anko(),
          ],)
        ],
      )
    );
  }
}