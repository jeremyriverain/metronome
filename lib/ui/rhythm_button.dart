import 'package:flutter/material.dart';

class RhythmButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final bool canPress;

  const RhythmButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.canPress = true,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: canPress ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
      child: Icon(
        icon,
        size: 35,
      ),
    );
  }
}
