import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const OptionButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.red),
        ),
        elevation: 3,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
