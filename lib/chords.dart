
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class ChordType {
  static final ChordType undefined = ChordType("", "");
  static final ChordType major = ChordType("", "");
  static final ChordType m = ChordType("m", "-");
  static final ChordType sus2 = ChordType.same("sus2");
  static final ChordType sus4 = ChordType.same("sus4");
  static final ChordType sixth = ChordType.same("<sup>6</sup>");
  static final ChordType m6 = ChordType.same("m<sup>6</sup>");
  static final ChordType seventh = ChordType.same("<sup>7</sup>");
  static final ChordType m7 = ChordType.same("m<sup>7</sup>");

  String rockName;
  String jazzName;

  ChordType(this.rockName, this.jazzName);

  ChordType.same(String name) {
    rockName = name;
    jazzName = name;
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
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,2,5"))) return ChordType.sus2;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,b3,5"))) return ChordType.m;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,3,5"))) return ChordType.major;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,4,5"))) return ChordType.sus4;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,b3,5,6"))) return ChordType.m6;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,3,5,6"))) return ChordType.sixth;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,b3,5,b7"))) return ChordType.m7;
    if (ListEquality().equals(normalizedNotes, DiatonicParser.parseChord("1,3,5,b7"))) return ChordType.seventh;

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

