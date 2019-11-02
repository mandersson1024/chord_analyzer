
class NoteNames {

  static const middleCNoteNumber = 60;
  static const List<String> names = ["C", "C#/Db", "D", "D#/Eb", "E", "F", "F#/Gb", "G", "G#/Ab", "A", "A#/Bb", "B"];

  static String toText(int noteNumber) {
    return names[noteNumber % 12];
  }

}
