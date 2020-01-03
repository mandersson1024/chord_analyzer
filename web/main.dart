import 'dart:html';
import 'package:music_theory/keyboard/keyboard_model.dart';
import 'package:music_theory/keyboard/keyboard_presenter.dart';
import 'package:music_theory/midi.dart';
import 'package:music_theory/note_names.dart';
import 'package:music_theory/webmidi_js.dart';
import 'package:music_theory/tone_js.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/keyboard/keyboard_view.dart';

bool get debug => true;

AudioNode _synth;
KeyboardModel _model = KeyboardModel();
KeyboardPresenter _presenter = KeyboardPresenter(_model);



void _refreshVisualKeyboardNote(int note) {
  querySelector("#key-$note").classes.toggle("key-selected", _model.getNote(note));
} 

void main() {
  DivElement keyboard = KeyboardView.build()
    ..style.position = "absolute"
    ..style.top = "345px"
    ..style.left = "125px"
  ;

  document.body.children.add(keyboard);

  void onMidiStatus(bool enabled) {
    if (enabled) {
      querySelector('#midi-enabled').text = '${WebMidi.enabled}';
      querySelector('#midi-inputs').text = '${WebMidi.inputs.map((Input input) => input.name)}';
    } else {
      window.console.warn("No MIDI");
    }
  }

  void onMidiInput(int note, bool on) {
    _presenter.setKey(note, on);
    _refreshVisualKeyboardNote(note);
    _refreshChordDisplay();
  }

  Midi.enableMidi(onMidiStatus, onMidiInput);
  _refreshChordDisplay();

  for (int note = 48; note <= 83; ++note) {
    querySelector("#key-$note")
      ..onClick.listen((_) {
        if (_synth == null) {
          _synth = Synth().toMaster();
        }
        _playNote(note);
        _presenter.toggleKey(note);
        _refreshVisualKeyboardNote(note);
        _refreshChordDisplay();
      });
  }
}

void _playNote(int note) {
  String noteName = NoteNames.name(note, ascii: true);
  int octave = note ~/ 12;
  _synth.triggerAttackRelease("$noteName$octave", '32n');
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
  var c = s.substring(1, s.length-1);
  return _chordNameToHtml(c);
}

void _refreshChordDisplay() {
  querySelector('#midi-notes').text = _model.notes.toString();
  List<Chord> chords = Chords.analyze(_model.notes);
  (querySelector('#chord') as HtmlElement).innerHtml = chords.isEmpty ? "" : _chordNameToHtml(chords.first.toString());
  (querySelector('#alternative-chords') as HtmlElement).innerHtml = _formatChordList(_alternativeChords(chords));
  //querySelector('#scales').text = '${Scale.match(Set.from(chord.notes))}';
}

String _chordNameToHtml(String chord) {
  // todo: maybe the HTML formatting needs to know about the ChordType and not just the String representation
  chord = chord.replaceAll("#", "<sup>#<\/sup>");
  chord = chord.replaceAll("b", "<sup>b<\/sup>");
  chord = chord.replaceAll("♯", "<sup>♯<\/sup>");
  chord = chord.replaceAll("♭", "<sup>♭<\/sup>");
  return chord;
}
