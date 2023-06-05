import 'package:flutter/material.dart';
import 'package:metronome/audio_player_provider.dart';
import 'package:metronome/store/rhythm_provider.dart';
import 'package:metronome/ui/app.dart';

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
