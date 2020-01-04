
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class ChordType {
  static final List<ChordType> allValidChords = [
    ChordType.sus2,
    ChordType.m,
    ChordType.major,
    ChordType.sus4,
    ChordType.m6,
    ChordType.sixth,
    ChordType.m7,
    ChordType.seventh,
  ];

  static final ChordType undefined = ChordType("", "", "undefined");
  static final ChordType major = ChordType("1,3,5", "", "");
  static final ChordType m = ChordType("1,b3,5", "m", "-");
  static final ChordType sus2 = ChordType.sameName("1,2,5", "sus2");
  static final ChordType sus4 = ChordType.sameName("1,4,5", "sus4");
  static final ChordType sixth = ChordType.sameName("1,3,5,6", "<sup>6</sup>");
  static final ChordType m6 = ChordType.sameName("1,b3,5,6", "m<sup>6</sup>");
  static final ChordType seventh = ChordType.sameName("1,3,5,b7", "<sup>7</sup>");
  static final ChordType m7 = ChordType.sameName("1,b3,5,b7", "m<sup>7</sup>");

  List<int> definition;
  String rockName;
  String jazzName;

  ChordType(String definitionString, this.rockName, this.jazzName) {
    definition = DiatonicParser.parseChord(definitionString);
  }

  ChordType.sameName(String definitionString, String name) {
    definition = DiatonicParser.parseChord(definitionString);
    rockName = name;
    jazzName = name;
  }

  String toString() {
    return rockName;
  }
}

class Chord {
  String noteName;
  ChordType type;

  Chord(this.noteName, this.type);

  String toString() {
    if (type == ChordType.undefined) {
      return "n.c.";
    } else {
      return noteName + type.rockName;
    }
  }

  bool get isNoChord => type == ChordType.undefined;

  bool operator==(dynamic other) {
    if (other == null) return false;
    if (!(other is Chord)) return false;
    if ((other as Chord).noteName != noteName) return false;
    if ((other as Chord).type != type) return false;
    return true;
  }
}


class Chords {

  static ChordType match(List<int> normalizedNotes) {
    for (ChordType ctype in ChordType.allValidChords) {
      if (ListEquality().equals(normalizedNotes, ctype.definition)) {
        return ctype;
      }
    }

    return ChordType.undefined;
  }

  static Chord getChord(int root, List<int> notes) {
    String noteName = NoteNames.name(root);
    ChordType type = match(notes);
    return Chord(noteName, type);
  }

  static List<Chord> analyze(Set<int> notes) {
    List<Chord> chords = [];

    List<int> noteList = List.from(notes);

    // If the chord is ambiguous, then we want to have the lowest note
    // as the main alternative of being the root. We get this by sorting
    // the notes.
    noteList.sort();

    for (int root in noteList) {
      List<int> normalized = normalize(root, notes);
      Chord chord = getChord(root, normalized);
      if (!chord.isNoChord) {
        if (!chords.contains(chord)) {
          chords.add(chord);
        }
      }
    }

    return chords;
  }

  static List<int> normalize(int root, Set<int> notes) {
    int normalizedRoot = root % 12;
    var sameOvtave = notes.map((int note) => ((note - normalizedRoot) + 12) % 12);
    var list = sameOvtave.toSet().toList(); // remove duplicates
    list.sort();
    return list;
  }

}

