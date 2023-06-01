import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metronome2/audio_player_provider.dart';
import 'package:metronome2/constants.dart';
import 'package:metronome2/store/rhythm_provider.dart';
import 'package:metronome2/ui/app.dart';
import 'package:metronome2/ui/sound_toggle_button.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

createApp() {
  final audioPlayer = MockAudioPlayer();

  when(() => audioPlayer.stop()).thenAnswer((_) async {});
  when(() => audioPlayer.resume()).thenAnswer((_) async {});

  return (
    app: AudioPlayerProvider(
      audioPlayer: audioPlayer,
      child: const RhythmProvider(
        child: App(),
      ),
    ),
    audioPlayer: audioPlayer,
  );
}

void main() {
  testWidgets('App default state OK', (tester) async {
    final (:app, audioPlayer: _) = createApp();
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    expect(find.text(kDefaultRhythm.toString()), findsOneWidget);
    expect(
      find.byIcon(kPlayIcon),
      findsOneWidget,
    );
  });

  testWidgets('when I click on play button, a sound is emitted regularly',
      (tester) async {
    final (:app, :audioPlayer) = createApp();
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(kPlayIcon));
    await tester.pumpAndSettle();

    expect(
      find.byIcon(kPlayIcon),
      findsNothing,
    );

    expect(
      find.byIcon(kPauseIcon),
      findsOneWidget,
    );

    await tester.pump(SoundToggleButton.getRhythmInterval(kDefaultRhythm) +
        SoundToggleButton.getRhythmInterval(kDefaultRhythm));
    verifyInOrder([
      () => audioPlayer.stop(),
      () => audioPlayer.resume(),
      () => audioPlayer.stop(),
      () => audioPlayer.resume(),
    ]);

    await tester.tap(find.byIcon(kPauseIcon));

    await tester.pump(SoundToggleButton.getRhythmInterval(kDefaultRhythm) * 2);

    verifyNoMoreInteractions(audioPlayer);
  });

  testWidgets('drag the slider to the minimum', (tester) async {
    final (:app, :audioPlayer) = createApp();
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text(kMinRhythm.toString()), // what you want to find
      find.byType(Slider), // widget you want to scroll
      const Offset(-300, 0), // delta to move
    );
    expect(find.text(kMinRhythm.toString()), findsOneWidget);

    await tester.pumpAndSettle();

    verifyZeroInteractions(audioPlayer);

    await tester.tap(find.byIcon(kPlayIcon));

    await tester.pump(SoundToggleButton.getRhythmInterval(kMinRhythm) * 5);
    verify(() => audioPlayer.stop()).called(5);
    verify(() => audioPlayer.resume()).called(5);
  });
}
