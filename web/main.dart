import 'dart:html';
import 'package:music_theory/webmidi.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/scales.dart';

void main() {
  List<int> notes = [60, 64, 67];
  Chord chord = Chord.fromMidiNoteNumbers(notes);
  querySelector('#midi-notes').text = '$notes';
  querySelector('#chord').text = chord.name;
  querySelector('#scales').text = '${Scale.match(chord.notes)}';
  querySelector('#midi').text = '${WebMidi.enabled}';

  WebMidi.enable(() {
    querySelector('#midi').text = '${WebMidi.enabled}';
    querySelector('#midi-inputs').text = '${WebMidi.inputs.map((Input input) => input.name)}';
    querySelector('#midi-outputs').text = '${WebMidi.outputs.map((Output output) => output.name)}';
  });

}

