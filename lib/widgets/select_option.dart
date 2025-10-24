import 'package:flutter/material.dart';
import 'package:mahjong/widgets/option_button.dart';


class SelectOption extends StatelessWidget {
  SelectOption({
    required this.onPressedTsumo,
    required this.onPressedRon,
    required this.onPressedModoru,
    required this.onPressedOkuru,
    required this.label,
    super.key
  });

  VoidCallback onPressedTsumo;
  VoidCallback onPressedRon;
  VoidCallback onPressedModoru;
  VoidCallback onPressedOkuru;
  String label;

  @override
  Widget build(BuildContext context) {

    const spacing = 8.0;

    return Row(children: [
      Expanded(
        child: OptionButton(
          onPressed: onPressedTsumo,
          child: SizedBox(height: 100, child: Center(child: Text("ツモ")))
        )
      ),
      SizedBox(width: spacing),
      Expanded(
        child: OptionButton(
          onPressed: onPressedRon,
          child: SizedBox(height: 100, child: Center(child: Text("ロン")))
        )
      ),
      SizedBox(width: spacing),
      Expanded(
        child: OptionButton(
          onPressed: onPressedModoru,
          child: SizedBox(height: 100, child: Center(child: Text("戻る")))
        )
      ),
      SizedBox(width: spacing),
      Expanded(
        child: OptionButton(
          onPressed: onPressedOkuru,
          child: SizedBox(height: 100, child: Center(child: Text(label)))
        )
      ),
    ]);
  }
}