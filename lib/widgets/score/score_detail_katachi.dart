import 'package:flutter/material.dart';

class ScoreOptionKatachi extends StatelessWidget {
  ScoreOptionKatachi({
    required this.value,
    required this.onChanged,
    super.key
  });

  int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      hint: const Text("アガリ形"),
      items: [
        DropdownMenuItem(
          value: 0,
          child: Center(
            child: Text("両面")
          )
        ),
        DropdownMenuItem(
          value: 0,
          child: Center(
            child: Text("カンチャン・ペンチャン")
          )
        ),
        DropdownMenuItem(
          value: 0,
          child: Center(
            child: Text("シャンポン")
          )
        ),DropdownMenuItem(
          value: 0,
          child: Center(
            child: Text("単騎")
          )
        ),
      ],
      alignment: Alignment.center,
      onChanged: onChanged,
      underline: SizedBox(),
    );
  }
}