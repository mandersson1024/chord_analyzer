import 'dart:html';
import 'package:music_theory/keyboard/keyboard_model.dart';
import 'package:music_theory/keyboard/keyboard_presenter.dart';
import 'package:music_theory/midi.dart';
import 'package:music_theory/webmidi_js.dart';
import 'package:music_theory/chords.dart';
import 'package:music_theory/keyboard/keyboard_view.dart';

KeyboardModel _model = KeyboardModel();
KeyboardPresenter _presenter = KeyboardPresenter(_model);
KeyboardView _view;


void main() {
  _presenter.onKeySelectionChanged.listen((event) => _onKeySelectionChanged(event.note, event.selected));

  Midi.enableMidi(_onMidiStatus, _onMidiInput);
  _view = KeyboardView(_onKeyboardClick, parent: querySelector('#keyboard-holder'));
  _refreshChordDisplay();
}

void _onKeyboardClick(int note) {
  _presenter.toggleKey(note);
}

void _onKeySelectionChanged(int note, bool selected) {
  _view.setKeySelected(note, selected);
  _refreshChordDisplay();
}

void _onMidiStatus(bool enabled) {
  if (enabled) {
    querySelector('#midi-enabled').text = '${WebMidi.enabled}';
    querySelector('#midi-inputs').text = '${WebMidi.inputs.map((Input input) => input.name)}';
  } else {
    window.console.warn("No MIDI");
  }
}

void _onMidiInput(int note, bool on) {
  _presenter.setKey(note, on);
}

void _refreshChordDisplay() {
  var notes = _model.notes.toList();
  notes.sort();
  querySelector('#midi-notes').text = "$notes";
  List<Chord> chords = Chords.analyze(_model.notes);
  //List<Chord> chords = Chords.analyze({60, 62, 67});
  (querySelector('#chord') as HtmlElement).innerHtml = chords.isEmpty ? "" : chords.first.toString();
  (querySelector('#alternative-chords') as HtmlElement).innerHtml = _formatChordList(_alternativeChords(chords));
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
