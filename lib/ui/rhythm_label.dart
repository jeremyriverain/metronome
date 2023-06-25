import 'package:flutter/material.dart';
import 'package:metronome/store/rhythm_store.dart';

class RhythmLabel extends StatelessWidget {
  const RhythmLabel({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          RhythmStore.of(context).rhythm.toString(),
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9.0, left: 6),
          child: Text(
            'bpm',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        )
      ],
    );
  }
}
