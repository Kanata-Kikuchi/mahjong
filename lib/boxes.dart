import 'package:flutter/material.dart';

class BoxA extends StatelessWidget {

  final double width;
  final double height;
  const BoxA(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.red),
      ),
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}

class BoxB extends StatelessWidget {

  final String label;
  final Widget child;

  const BoxB(this.label, {required this.child, super.key});

  @override
  Widget build(BuildContext context) {

    const double horizontal = 10;
    const double vertical = 20;
    
    Widget _test = ColoredBox(color: Colors.lightBlue, child: child,);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black26),
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: _test
          )
        ),
        Transform.translate(
          offset: Offset(12, -10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(label, style: TextStyle(color: Colors.white),),
          ),
        )
      ],
    );
  }
}