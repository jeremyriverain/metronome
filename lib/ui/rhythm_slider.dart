import 'package:flutter/material.dart';
import 'package:metronome2/constants.dart';
import 'package:metronome2/store/rhythm_provider.dart';
import 'package:metronome2/store/rhythm_store.dart';

class RhythmSlider extends StatelessWidget {
  const RhythmSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Slider(
      min: kMinRhythm.toDouble(),
      max: kMaxRhythm.toDouble(),
      value: RhythmStore.of(context).rhythm.toDouble(),
      onChanged: (double value) =>
          RhythmProvider.of(context).updateRhythm(value.toInt()),
    );
  }
}
