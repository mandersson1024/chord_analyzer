
import 'package:music_theory/note_names.dart';
import 'package:music_theory/tone_js.dart';

class Audio {
  AudioNode _audioNode;
  Synth _synth;

  void _setup() {
    if (_audioNode == null) {
      _synth = Synth()
        ..oscillator.type = "square"

      ;
      _audioNode =_synth.toMaster();
    }
  }

  void playNote(int note) {
    _setup();
    String noteName = NoteNames.name(note, ascii: true);
    int octave = note ~/ 12;
    _audioNode.triggerAttackRelease("$noteName$octave", '32n');
  }

}
