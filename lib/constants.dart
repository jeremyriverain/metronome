import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// représente le rythme du métronome par défaut quand on arrive dans l'application
const kDefaultRhythm = 50;

// rythme minimum du métronome
const kMinRhythm = 30;

// rythme maximum du métronome
const kMaxRhythm = 180;

const kLowestColor = Color(0xff9c27b0);
const kHighestColor = Color(0xfff44336);

// icône du bouton "lecture"
const kPlayIcon = Icons.play_arrow;

// icône du bouton "pause"
const kPauseIcon = Icons.pause;

// icône du bouton permettant d'incrémenter le rythme
const kIncrementRhythmIcon = Icons.add;

// icône du bouton permettant d'incrémenter le rythme
const kDecrementRhythmIcon = Icons.remove;

final soundSource = AssetSource('metronome-sound.mp3');
