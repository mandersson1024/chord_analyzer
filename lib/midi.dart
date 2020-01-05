
import "package:js/js.dart";

import 'package:music_theory/webmidi_js.dart';

typedef MidiStatusCallback = void Function(bool enabled);
typedef MidiInputCallback = void Function(int note, bool on);

class Midi {
  
  static void enableMidi(MidiStatusCallback onEnabledStatus, MidiInputCallback onMidiInput) {
    void onNoteOn(InputEvent event) {
      //print("Received '${event.type}' message with note number ${event.note.number}");
      onMidiInput(event.note.number, true);
    }

    void onNoteOff(InputEvent event) {
      //print("Received '${event.type}' message with note number ${event.note.number}");
      onMidiInput(event.note.number, false);
    }

    void onError([Error error]) {
      if (error == null) {
        print("midi enabled");
        onEnabledStatus(true);
        for (Input input in WebMidi_inputs) {
          input.addListener('noteon', "all", allowInterop(onNoteOn));
          input.addListener('noteoff', "all", allowInterop(onNoteOff));

          // todo: For some reason, use the lines below for webdev
          // input.addListener('noteon', "all", onNoteOn);
          // input.addListener('noteoff', "all", onNoteOff);
        }
      } else {
        print("midi error");
        onEnabledStatus(false);
      }
    }

    print("trying to enable midi...");
    WebMidi.enable(allowInterop(onError));
  }

}
