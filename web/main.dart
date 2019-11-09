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

  querySelector('#enable-midi-button').onClick.listen((_) {
    querySelector('#enable-midi-button').style.display = "none";
    WebMidi.enable(() {
      querySelector('#midi-enabled').text = '${WebMidi.enabled}';
      querySelector('#midi-inputs').text = '${WebMidi.inputs.map((Input input) => input.name)}';
    });
  });

  for (int note = 48; note <= 83; ++note) {
    DivElement elt = querySelector("#key-$note");
    elt.onClick.listen((_) {
      elt.classes.toggle("key-selected");
      // todo:
      // todo: keyboard.toggleNote(note);
      // todo: elt.classes.toggle("key-selected", keyboard.getNote(note));
    });
  }
}

