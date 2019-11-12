
class NoteNames {

  static const middleCNoteNumber = 60;
  static const List<String> sharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"];
  static const List<String> flats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"];
  static const List<String> notes = ["C", "C♯", "D", "E♭", "E", "F", "F♯", "G", "A♭", "A", "B♭", "B"];

  static String name(int note, {bool possiblySharp = true}) {
    // Not sure how to handle flats and sharps, pick a soluton for now
    // [ ] define a key?
    // [ ] show both alternatives?
    // [x] use C# and F#, the rest flat
    return notes[note % 12];
  }

}
