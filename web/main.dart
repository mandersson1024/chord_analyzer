import 'dart:html';
import 'package:music_theory/webmidi.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/scales.dart';
import 'package:music_theory/app_state.dart';

AppState state = AppState();

void _hideMidiButtons() {
  querySelector('#enable-midi-button').style.display = "none";
  querySelector('#no-midi-button').style.display = "none";
}

void _enableMidi() {
  WebMidi.enable((var error) {
    if (error != null) {
      window.console.warn("No MIDI");
    } else {
      querySelector('#midi-enabled').text = '${WebMidi.enabled}';
      querySelector('#midi-inputs').text = '${WebMidi.inputs.map((Input input) => input.name)}';
    }
  });
}

bool get debug => true;

void main() {
  if (debug) {
    _hideMidiButtons();
    _enableMidi();
  } else {
    querySelector('#enable-midi-button').onClick.listen((_) {
      _hideMidiButtons();
      _enableMidi();
    });
  }

  querySelector('#no-midi-button').onClick.listen((_) {
    _hideMidiButtons();
  });

  for (int note = 48; note <= 83; ++note) {
    DivElement elt = querySelector("#key-$note");
    elt.onClick.listen((_) {
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
