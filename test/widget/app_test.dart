import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metronome/audio_player_provider.dart';
import 'package:metronome/constants.dart';
import 'package:metronome/store/rhythm_provider.dart';
import 'package:metronome/ui/app.dart';
import 'package:metronome/ui/sound_toggle_button.dart';
import 'package:mocktail/mocktail.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

createApp() {
  final audioPlayer = MockAudioPlayer();

  when(() => audioPlayer.pause()).thenAnswer((_) async {});
  when(() => audioPlayer.seek(Duration.zero)).thenAnswer((_) async {});
  when(() => audioPlayer.play(soundSource)).thenAnswer((_) async {
    return;
  });

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
      () => audioPlayer.pause(),
      () => audioPlayer.seek(Duration.zero),
      () => audioPlayer.play(soundSource),
      () => audioPlayer.pause(),
      () => audioPlayer.seek(Duration.zero),
      () => audioPlayer.play(soundSource),
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
    verify(() => audioPlayer.play(soundSource)).called(5);
  });

  testWidgets('when I click on + button, the rhythm is incremented',
      (tester) async {
    final (:app, audioPlayer: _) = createApp();
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    expect(find.text(kDefaultRhythm.toString()), findsOneWidget);
    await tester.tap(find.byIcon(kIncrementRhythmIcon));
    await tester.pumpAndSettle();

    expect(find.text((kDefaultRhythm + 1).toString()), findsOneWidget);
  });

  testWidgets('when I click on - button, the rhythm is decremented',
      (tester) async {
    final (:app, audioPlayer: _) = createApp();
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    expect(find.text(kDefaultRhythm.toString()), findsOneWidget);
    await tester.tap(find.byIcon(kDecrementRhythmIcon));
    await tester.pumpAndSettle();

    expect(find.text((kDefaultRhythm - 1).toString()), findsOneWidget);
  });

  testWidgets(
      'i cannot click on the - button when the rhythm is the lowest possible',
      (tester) async {
    final (:app, audioPlayer: _) = createApp();
    await tester.pumpWidget(app);

    await tester.dragUntilVisible(
      find.text(kMinRhythm.toString()), // what you want to find
      find.byType(Slider), // widget you want to scroll
      const Offset(-300, 0), // delta to move
    );
    expect(find.text(kMinRhythm.toString()), findsOneWidget);

    await tester.tap(find.byIcon(kDecrementRhythmIcon));
    await tester.pumpAndSettle();

    expect(find.text(kMinRhythm.toString()), findsOneWidget);
  });

  testWidgets(
      'i cannot click on the + button when the rhythm is the highest possible',
      (tester) async {
    final (:app, audioPlayer: _) = createApp();
    await tester.pumpWidget(app);

    await tester.dragUntilVisible(
      find.text(kMaxRhythm.toString()), // what you want to find
      find.byType(Slider), // widget you want to scroll
      const Offset(300, 0), // delta to move
    );
    expect(find.text(kMaxRhythm.toString()), findsOneWidget);

    await tester.tap(find.byIcon(kIncrementRhythmIcon));
    await tester.pumpAndSettle();

    expect(find.text(kMaxRhythm.toString()), findsOneWidget);
  });
}
