import 'package:flutter/material.dart';

class ScoreOptionIppatsu extends StatelessWidget {
  const ScoreOptionIppatsu({
    super.key,
    required this.enabled,       // リーチ時のみ有効
    required this.value,         // チェックON/OFF状態
    required this.onChanged,     // 押されたときの処理
  });

  final bool enabled;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.45, // 無効時は半透明
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: enabled ? value : false,
            onChanged: enabled ? onChanged : null, // 無効時は押せない
          ),
          const Text('一発')
        ],
      ),
    );
  }
}
