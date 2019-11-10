import 'package:music_theory/webmidi.dart';

class MidiInput {
  Set<int> notesOn = {};

  MidiInput.setup() {
    for (Input input in WebMidi.inputs) {
      input.addListener('noteon', "all", _onNoteOn);
      input.addListener('noteoff', "all", _onNoteOff);
    }
  }

  void _onNoteOn(e) {
    print("Received 'noteon' message");
  }

  void _onNoteOff(e) {
    print("Received 'noteoff' message");
  }
}
