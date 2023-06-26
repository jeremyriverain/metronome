import 'package:flutter/material.dart';
import 'package:metronome/constants.dart';
import 'package:metronome/store/rhythm_store.dart';

class RhythmProvider extends StatefulWidget {
  static RhythmProviderState of(BuildContext context) {
    final result = context.findAncestorStateOfType<RhythmProviderState>();
    if (result == null) {
      throw 'RythmProviderState ancestor has not been found';
    }

    return result;
  }

  final Widget child;

  const RhythmProvider({
    super.key,
    required this.child,
  });

  @override
  State<RhythmProvider> createState() => RhythmProviderState();
}

class RhythmProviderState extends State<RhythmProvider> {
  int _rhythm = kDefaultRhythm;

  void updateRhythm(int val) {
    setState(() {
      _rhythm = val;
    });
  }

  void increment() {
    if (_rhythm == kMaxRhythm) {
      return;
    }
    setState(() {
      _rhythm++;
    });
  }

  void decrement() {
    if (_rhythm == kMinRhythm) {
      return;
    }
    setState(() {
      _rhythm--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RhythmStore(
      rhythm: _rhythm,
      child: widget.child,
    );
  }
}
