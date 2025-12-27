import 'package:flutter/material.dart';

class ScoreDetailDora extends StatelessWidget {
  const ScoreDetailDora({
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
        Text(
          'ドラ: $doraCount 枚',
          style: TextStyle(fontSize: 10)
        ),
        IconButton( // ドラの最大値　４０.
          icon: const Icon(Icons.add),
          onPressed: doraCount < 40 ? onPressedAdd : null
        ),
      ],
    );
  }
}