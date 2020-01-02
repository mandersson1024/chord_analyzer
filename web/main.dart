import 'dart:html';
import 'package:music_theory/note_names.dart';
import 'package:music_theory/webmidi_js.dart';
import 'package:music_theory/tone_js.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/scales.dart';
import 'package:music_theory/app_state.dart';
import 'package:music_theory/midi_input.dart';
import 'package:music_theory/keyboard_view.dart';

AppState state = AppState();
MidiInput midiInput;

bool get debug => true;

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
  _refreshChordDisplay();
}

void _refreshVisualKeyboardNote(int note) {
  querySelector("#key-$note").classes.toggle("key-selected", state.getNote(note));
} 

AudioNode _synth;

void main() {
  DivElement keyboard = KeyboardView.build()
    ..style.position = "absolute"
    ..style.top = "100px"
    ..style.left = "100px"
  ;

  //document.body.children.add(keyboard);

  _enableMidi();
  _refreshChordDisplay();

  for (int note = 48; note <= 83; ++note) {
    querySelector("#key-$note")
      ..onClick.listen((_) {
        if (_synth == null) {
          _synth = Synth().toMaster();
        }
        _playNote(note);
        state.toggleNote(note);
        _refreshVisualKeyboardNote(note);
        _refreshChordDisplay();
      });
  }
}

void _playNote(int note) {
  String noteName = NoteNames.name(note, ascii: true);
  int octave = note ~/ 12;
  _synth.triggerAttackRelease("$noteName$octave", '8n');
}

List<Chord> _alternativeChords(List<Chord> chords) {
  if (chords.isEmpty) {
    return [];
  } else {
    return chords.sublist(1);
  }
}

String _formatChordList(List<Chord> chords) {
  var s = chords.toString();
  return s.substring(1, s.length-1);
}

void _refreshChordDisplay() {
  querySelector('#midi-notes').text = state.notes.toString();
  List<Chord> chords = Chords.analyze(state.notes);
  (querySelector('#chord') as HtmlElement).innerHtml = chords.isEmpty ? "" : chords.first.toString();
  (querySelector('#alternative-chords') as HtmlElement).innerHtml = _formatChordList(_alternativeChords(chords));
  //querySelector('#scales').text = '${Scale.match(Set.from(chord.notes))}';
}
