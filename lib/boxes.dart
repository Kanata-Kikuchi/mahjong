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
  final double width;
  final double height;

  const BoxB(this.label, this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: width, height: height, color: Colors.lightBlue),
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