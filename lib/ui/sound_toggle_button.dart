import 'dart:async';

import 'package:flutter/material.dart';
import 'package:metronome/audio_player_provider.dart';
import 'package:metronome/constants.dart';
import 'package:metronome/store/rhythm_store.dart';

class SoundToggleButton extends StatefulWidget {
  const SoundToggleButton({super.key});

  static Duration getRhythmInterval(int rhythm) =>
      Duration(milliseconds: ((60 / rhythm) * 1000).toInt());

  @override
  State<SoundToggleButton> createState() => _SoundToggleButtonState();
}

class _SoundToggleButtonState extends State<SoundToggleButton> {
  bool isPlaying = false;
  Timer? periodicTimer;

  @override
  void didChangeDependencies() {
    final audioPlayer = AudioPlayerProvider.of(context).audioPlayer;
    periodicTimer?.cancel();
    periodicTimer = Timer.periodic(
      SoundToggleButton.getRhythmInterval(RhythmStore.of(context).rhythm),
      (_) {
        if (isPlaying) {
          audioPlayer.stop();
          audioPlayer.resume();
        }
      }, //
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    periodicTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          isPlaying = !isPlaying;
        });
      },
      child: Icon(
        isPlaying ? kPauseIcon : kPlayIcon,
        size: 120,
      ),
    );
  }
}
