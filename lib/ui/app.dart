// lib/ui/app.dart

import 'package:flutter/material.dart';
import 'package:metronome/constants.dart';
import 'package:metronome/store/rhythm_store.dart';
import 'package:metronome/ui/rhythm_button.dart';
import 'package:metronome/ui/rhythm_label.dart';
import 'package:metronome/store/rhythm_provider.dart';
import 'package:metronome/ui/rhythm_slider.dart';
import 'package:metronome/ui/sound_toggle_button.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final rhythm = RhythmStore.of(context).rhythm;
    return MaterialApp(
      theme: ThemeData(
        sliderTheme:
            SliderThemeData(overlayShape: SliderComponentShape.noThumb),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RhythmLabel(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RhythmButton(
                      icon: kDecrementRhythmIcon,
                      onPressed: () => RhythmProvider.of(context).decrement(),
                      canPress: rhythm != kMinRhythm,
                    ),
                    const Expanded(
                      child: RhythmSlider(),
                    ),
                    RhythmButton(
                      icon: kIncrementRhythmIcon,
                      onPressed: () => RhythmProvider.of(context).increment(),
                      canPress: rhythm != kMaxRhythm,
                    ),
                  ],
                ),
              ),
            ),
            const SoundToggleButton(),
          ],
        ),
      ),
    );
  }
}
