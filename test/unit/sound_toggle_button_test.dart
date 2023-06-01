import 'package:flutter_test/flutter_test.dart';
import 'package:metronome2/ui/sound_toggle_button.dart';

void main() {
  test('getRhythmerval function returns appropriate Duration', () {
    expect(
      SoundToggleButton.getRhythmInterval(60),
      equals(
        const Duration(seconds: 1),
      ),
    );

    expect(
      SoundToggleButton.getRhythmInterval(120),
      equals(
        const Duration(milliseconds: 500),
      ),
    );
  });
}
