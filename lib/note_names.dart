
class NoteNames {

  static const middleCNoteNumber = 60;
  static const List<String> sharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"];
  static const List<String> flats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"];
  static const List<String> notes = ["C", "D♭", "D", "E♭", "E", "F", "F♯", "G", "A♭", "A", "B♭", "B"];

  static String name(int note, {bool possiblySharp = true, bool ascii = false}) {
    // Not sure how to handle flats and sharps, pick a soluton for now
    // [ ] define a key?
    // [ ] show both alternatives?
    // [x] use C# and F#, the rest flat

    String str = notes[note % 12];

    if (ascii) {
      str = str.replaceAll("♯", "#");
      str = str.replaceAll("♭", "b");
    }

    return str;
  }

}


class DiatonicParser {

  static const Map<int, int> diatonicMap =  {
    1: 0,
    2: 2,
    3: 4,
    4: 5,
    5: 7,
    6: 9,
    7: 11,
    8: 12 + 0,
    9: 12 + 2,
    10: 12 + 4,
    11: 12 + 5,
    12: 12 + 7,
    13: 12 + 9,
    14: 12 + 11,
  };

  static const Map<String, int> accidentalMap =  {
    "#": 1,
    "b": -1,
  };

  static int parse(String name) {
    if (name.startsWith("#") || name.startsWith("b")) {
      String diatonicName = name.substring(1);
      int diatonic = int.parse(diatonicName);
      return diatonicMap[diatonic] + accidentalMap[name[0]];
    } else {
      int diatonic = int.parse(name);
      return diatonicMap[diatonic];
    }
  }

}