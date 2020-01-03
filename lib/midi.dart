
import 'package:music_theory/webmidi_js.dart';

typedef MidiStatusCallback = void Function(bool enabled);
typedef MidiInputCallback = void Function(int note, bool on);

class Midi {
  
  static void enableMidi(MidiStatusCallback onEnabledStatus, MidiInputCallback onMidiInput) {
    void onNoteOn(NoteOnEvent event) {
      print("Received '${event.type}' message with note number ${event.note.number}");
      onMidiInput(event.note.number, true);
    }

    void onNoteOff(NoteOffEvent event) {
      print("Received '${event.type}' message with note number ${event.note.number}");
      onMidiInput(event.note.number, false);
    }

    WebMidi.enable((var error) {
      if (error != null) {
        onEnabledStatus(false);
      } else {
        onEnabledStatus(true);
        for (Input input in WebMidi.inputs) {
          input.addListener('noteon', "all", onNoteOn);
          input.addListener('noteoff', "all", onNoteOff);
        }
      }
    });
  }

}
