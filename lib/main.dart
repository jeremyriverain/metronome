import 'package:flutter/material.dart';
import 'package:metronome2/audio_player_provider.dart';
import 'package:metronome2/store/rhythm_provider.dart';
import 'package:metronome2/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    AudioPlayerProvider(
      audioPlayer: await AudioPlayerProvider.createAudioPlayer(),
      child: const RhythmProvider(
        child: App(),
      ),
    ),
  );
}
