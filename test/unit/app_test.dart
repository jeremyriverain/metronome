import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:metronome/constants.dart';
import 'package:metronome/ui/app.dart';

void main() {
  test('calculateColor', () {
    const app = App();
    expect(app.calculateColor(kMinRhythm.toDouble()), kLowestColor);
    expect(app.calculateColor(kMaxRhythm.toDouble()), kHighestColor);
    expect(app.calculateColor(100), const Color(0xffc53477));
  });
}
