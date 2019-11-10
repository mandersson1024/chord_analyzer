import 'package:music_theory/webmidi.dart';

class MidiInput {
  Set<int> notesOn = {};

  MidiInput.setup() {
    for (Input input in WebMidi.inputs) {
      input.addListener('noteon', "all", _onNoteOn);
      input.addListener('noteoff', "all", _onNoteOff);
    }
  }

  void _onNoteOn(NoteOnEvent event) {
    print("Received '${event.type}' message with note number ${event.note.number}");
  }

  void _onNoteOff(NoteOffEvent event) {
    print("Received '${event.type}' message with note number ${event.note.number}");
  }
}
