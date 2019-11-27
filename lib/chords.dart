
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class ChordType {
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
  int root;
  ChordType type;

  Chord(this.root, this.type);

  String getName() {
    if (type == null) {
      return "";
    } else {
      return NoteNames.name(root) + type.rockName;
    }
  }
}


class Chords {

  static ChordType match(List<int> normalizedNotes) {
    if (ListEquality().equals(normalizedNotes, [0, 2, 7])) return ChordType.sus2;
    if (ListEquality().equals(normalizedNotes, [0, 3, 7])) return ChordType.m;
    if (ListEquality().equals(normalizedNotes, [0, 4, 7])) return ChordType.major;
    if (ListEquality().equals(normalizedNotes, [0, 5, 7])) return ChordType.sus4;
    if (ListEquality().equals(normalizedNotes, [0, 3, 7, 9])) return ChordType.m6;
    if (ListEquality().equals(normalizedNotes, [0, 4, 7, 9])) return ChordType.sixth;
    if (ListEquality().equals(normalizedNotes, [0, 3, 7, 10])) return ChordType.m7;
    if (ListEquality().equals(normalizedNotes, [0, 4, 7, 10])) return ChordType.seventh;
    return null;
  }

  static Chord getChord(int root, List<int> notes) {
    ChordType type = match(notes);
    return Chord(root, type);
  }

  static List<String> analyse(Set<int> notes) {
    List<String> names = [];

    List<int> noteList = List.from(notes);

    // If the chord is ambiguous, then we want to have the lowest note
    // as the main alternative of being the root. We get this by sorting
    // the notes.
    noteList.sort();

    for (int root in noteList) {
      List<int> normalized = normalize(root, notes);
      String name = getBasicName(root, normalized);
      if (name != "" && !names.contains(name)) {
        names.add(name);
      }
    }

    if (names.isEmpty && notes.length > 2) {
      names = ["n.c."];
    }

    return names;
  }

  static List<int> normalize(int root, Set<int> notes) {
    int normalizedRoot = root % 12;
    var sameOvtave = notes.map((int note) => ((note - normalizedRoot) + 12) % 12);
    var list = sameOvtave.toSet().toList(); // remove duplicates
    list.sort();
    return list;
  }

}

