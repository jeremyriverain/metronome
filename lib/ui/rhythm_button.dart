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
      child: Icon(icon),
    );
  }
}
