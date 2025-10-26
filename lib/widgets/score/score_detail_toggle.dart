import 'package:flutter/material.dart';

class ScoreToggle extends StatelessWidget {
  ScoreToggle({
    required this.title,
    required this.label0,
    required this.label1,
    this.label2,
    required this.groupValue,
    required this.onChanged,
    this.flagNaki = false,
    super.key
  });

  final String title;
  final String label0;
  final String label1;
  final String? label2;
  final int groupValue;
  final void Function(int) onChanged;
  bool flagNaki;

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<int>(
              value: 0,
              groupValue: groupValue,
              onChanged: (i) => onChanged(i!)
            ),
            Text(label0),
            const SizedBox(width: 12),
            Radio<int>(
              value: 1,
              groupValue: groupValue,
              onChanged: flagNaki ? null : (i) => onChanged(i!)
            ),
            Text(label1),
            const SizedBox(width: 12),
            if (label2 != null) ...[
              Radio<int>(
                value: 2,
                groupValue: groupValue,
                onChanged: flagNaki ? null : (i) => onChanged(i!)
              ),
              Text(label2!),
            ]
          ]
        ),
      ],
    );
  }
}
