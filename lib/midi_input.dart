import 'package:music_theory/webmidi_js.dart';

typedef MidiCallback = void Function(int note, bool on);

class MidiInput {
  MidiCallback _callback;
  Set<int> notesOn = {};

  MidiInput.setup(this._callback) {
    for (Input input in WebMidi.inputs) {
      input.addListener('noteon', "all", _onNoteOn);
      input.addListener('noteoff', "all", _onNoteOff);
    }
  }

  void _onNoteOn(NoteOnEvent event) {
    print("Received '${event.type}' message with note number ${event.note.number}");
    _callback(event.note.number, true);
  }

  void _onNoteOff(NoteOffEvent event) {
    print("Received '${event.type}' message with note number ${event.note.number}");
    _callback(event.note.number, false);
  }
}
