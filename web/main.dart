import 'dart:html';
import 'package:music_theory/webmidi.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/scales.dart';
import 'package:music_theory/app_state.dart';

AppState state = AppState();

void main() {
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
      //elt.classes.toggle("key-selected");
      state.toggleNote(note);
      elt.classes.toggle("key-selected", state.getNote(note));refreshChordDisplay();
    });
  }

  refreshChordDisplay();
}

void refreshChordDisplay() {
  List<int> notes = state.noteList;
  Chord chord = Chord.fromMidiNoteNumbers(notes);
  querySelector('#midi-notes').text = '$notes';
  querySelector('#chord').text = chord.name;
  querySelector('#scales').text = '${Scale.match(chord.notes)}';
}
