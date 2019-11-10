import 'dart:html';
import 'package:music_theory/webmidi.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/scales.dart';
import 'package:music_theory/app_state.dart';
import 'package:music_theory/midi_input.dart';

AppState state = AppState();
MidiInput midiInput;

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
      midiInput = MidiInput.setup(_onMidiInput);
    }
  });
}

void _onMidiInput(int note, bool on) {
  state.setNote(note, on);
  _refreshVisualKeyboardNote(note);
  refreshChordDisplay();
}

void _refreshVisualKeyboardNote(int note) {
  querySelector("#key-$note").classes.toggle("key-selected", state.getNote(note));
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
      _refreshVisualKeyboardNote(note);
      refreshChordDisplay();
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
