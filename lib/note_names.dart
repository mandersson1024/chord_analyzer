
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

  static const Map<String, int> diatonicMap =  {
    "1": 0,
    "2": 2,
    "3": 4,
    "4": 5,
    "5": 7,
    "6": 9,
    "7": 11,
    "8": 0,
    "9": 2,
    "10": 4,
    "11": 5,
    "12": 7,
    "13": 9,
    "14": 11,
  };

  static const Map<String, int> accidentalMap =  {
    "#": 1,
    "b": -1,
  };

  static int parse(String name) {
    if (name.startsWith("#") || name.startsWith("b")) {
      String diatonicName = name.substring(1);
      return diatonicMap[diatonicName] + accidentalMap[name[0]];
    } else {
      return diatonicMap[name];
    }
  }

  static List<int> parseChord(String chord) {
    if (chord.isEmpty) {
      return [];
    } else {
      List<String> textNotes = chord.split(",");
      List<int> notes = textNotes.map((String name) => DiatonicParser.parse(name)).toList();
      notes.sort();
      return notes;
    }
  }

}
