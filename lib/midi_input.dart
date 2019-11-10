import 'package:music_theory/webmidi.dart';

class MidiInput {
  Set<int> notesOn = {};

  MidiInput.setup() {
    for (Input input in WebMidi.inputs) {
      input.addListener('noteon', "all", _onNoteOn);
      input.addListener('noteoff', "all", _onNoteOff);
    }
  }

  void _onNoteOn(MidiInputEvent event) {
    print("Received '${event.type}' message from ${event.target.name} at ${event.timestamp} with data ${event.data}");
  }

  void _onNoteOff(MidiInputEvent event) {
    print("Received '${event.type}' message from ${event.target.name} at ${event.timestamp} with data ${event.data}");
  }
}
