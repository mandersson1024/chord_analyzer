@JS()
library tone_js;

import "package:js/js.dart";

@JS("Tone.Synth")
class Synth {
  external AudioNode toMaster();
  OmniOscillator oscillator;
  //volume;
  //envelope;
}

@JS("Tone.AudioNode")
class AudioNode {
  external Instrument triggerAttackRelease(note, duration, [time, velocity]);
}

@JS("Tone.Instrument")
class Instrument {
}

@JS("Tone.OmniOscillator")
class OmniOscillator {
  String type;
}

