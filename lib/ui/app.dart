// lib/ui/app.dart

import 'package:flutter/material.dart';
import 'package:metronome/constants.dart';
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
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          final labelAndButtons = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RhythmButton(
                icon: kDecrementRhythmIcon,
                onPressed: () => RhythmProvider.of(context).decrement(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RhythmLabel(),
              ),
              RhythmButton(
                icon: kIncrementRhythmIcon,
                onPressed: () => RhythmProvider.of(context).increment(),
              ),
            ],
          );
          if (constraints.maxWidth > 500) {
            // Mise en page grand écran
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      labelAndButtons,
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: RhythmSlider(),
                      ),
                    ],
                  ),
                ),
                const SoundToggleButton(),
              ],
            );
          }

          // Mise en page petit écran (téléphone)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              labelAndButtons,
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: RhythmSlider(),
              ),
              const SoundToggleButton(),
            ],
          );
        }),
      ),
    );
  }
}
