import 'package:flutter/material.dart';

class RhythmButton extends StatelessWidget {
  final IconData icon;

  final void Function() onPressed;

  const RhythmButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
      child: Icon(icon),
    );
  }
}
