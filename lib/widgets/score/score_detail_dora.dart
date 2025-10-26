import 'package:flutter/material.dart';

class ScoreOptionDora extends StatelessWidget {
  const ScoreOptionDora({
    super.key,
    required this.doraCount,
    required this.onPressedRemove,
    required this.onPressedAdd
  });

  final int doraCount;
  final VoidCallback? onPressedRemove;
  final VoidCallback? onPressedAdd;

  @override
  Widget build(BuildContext context) {
    return Row( // ドラの枚数選択.
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: doraCount > 0 ? onPressedRemove : null
        ),
        Text('ドラ: $doraCount 枚'),
        IconButton( // ドラの最大値　４０.
          icon: const Icon(Icons.add),
          onPressed: doraCount < 40 ? onPressedAdd : null
        ),
      ],
    );
  }
}