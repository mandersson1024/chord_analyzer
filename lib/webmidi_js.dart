@JS()
library webmidi_js;

import 'dart:typed_data';
import "package:js/js.dart";

@JS("WebMidi.enabled")
external bool get WebMidi_enabled;

@JS("WebMidi.inputs")
external List<Input> get WebMidi_inputs;

@JS()
class WebMidi {
  //static bool enabled;
  //static List<Input> inputs;
  external static void enable([Function callback, bool sysex]);
}

@JS()
class Input {
  external String get name;
  external Input addListener(String type, var channel, Function listener);
  external Input removeListener([String type, var channel, Function listener]);
}

@JS()
class Output {
  external String get name;
}

@JS()
class InputEvent {
  external Input get target;
  external Uint8List get data;
  external num get timestamp;
  external String get type;
  external int get channel;
  external MidiNote get note;
}

@JS()
class MidiNote {
  external int get number;
  external String get name;
  external int get octave;
}

@JS()
class Error {
  external String get message;
}
