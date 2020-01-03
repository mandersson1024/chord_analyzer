
import 'package:music_theory/note_names.dart';
import 'package:music_theory/tone_js.dart';

class Audio {
  AudioNode _synth;

  void _setup() {
    if (_synth == null) {
      _synth = Synth().toMaster();
    }
  }

  void playNote(int note) {
    _setup();
    String noteName = NoteNames.name(note, ascii: true);
    int octave = note ~/ 12;
    _synth.triggerAttackRelease("$noteName$octave", '32n');
  }

}
