import 'package:flutter/material.dart';

class ScoreToggle extends StatelessWidget {
  ScoreToggle({
    required this.title,
    required this.label0,
    this.label1,
    this.label2,
    this.label3,
    required this.groupValue,
    required this.onChanged,
    super.key
  });

  final String title;
  final String label0;
  final String? label1;
  final String? label2;
  final String? label3;
  final int groupValue;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio<int>(
              value: 0,
              groupValue: groupValue,
              onChanged: (i) => onChanged(i!)
            ),
            Text(label0),
            if (label1 != null) ...[
              const SizedBox(width: 12),
              Radio<int>(
                value: 1,
                groupValue: groupValue,
                onChanged: (i) => onChanged(i!)
              ),
              Text(label1!),
            ],
            if (label2 != null) ...[
              const SizedBox(width: 12),
              Radio<int>(
                value: 2,
                groupValue: groupValue,
                onChanged: (i) => onChanged(i!)
              ),
              Text(label2!),
            ],
            if (label3 != null) ...[
              const SizedBox(width: 12),
              Radio<int>(
                value: 3,
                groupValue: groupValue,
                onChanged: (i) => onChanged(i!)
              ),
              Text(label3!),
            ]
          ]
        ),
      ],
    );
  }
}
