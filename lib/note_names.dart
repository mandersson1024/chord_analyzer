
class NoteNames {

  static const middleCNoteNumber = 60;
  static const List<String> sharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"];
  static const List<String> flats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"];

  static String name(int note, {bool possiblySharp = true}) {
    // todo: not sure how to handle flats and sharps
    // todo: - set a key?
    // todo: - show both alternatives?

    if (possiblySharp) {
      return sharps[note % 12];
    } else {
      return flats[note % 12];
    }
  }

}
