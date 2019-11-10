@JS()
library temp_web_midi;

import 'dart:typed_data';
import "package:js/js.dart";

@JS()
class WebMidi {
  static bool enabled;
  static List<Input> inputs;
  static List<Output> outputs;
  external static void enable([Function callback, bool sysex=false]);
}

@JS()
class Input {
  String name;
  external Input addListener(String type, var channel, Function listener);
  external Input removeListener([String type, var channel, Function listener]);
}

@JS()
class Output {
  String name;
}

@JS()
class InputEvent {
  Input target;
  Uint8List data;
  num timestamp;
  String type;
}

@JS()
class NoteOnEvent extends InputEvent {
  int channel;
  MidiNote note;
}

@JS()
class NoteOffEvent extends InputEvent {
  int channel;
  MidiNote note;
}

@JS()
class MidiNote {
  int number;
  String name;
  int octave;
}
