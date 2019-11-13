
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class Chords {

  static String match(List<int> normalizedNotes) {
    if (ListEquality().equals(normalizedNotes, [0, 2, 7])) return "sus2";
    if (ListEquality().equals(normalizedNotes, [0, 3, 7])) return "m";
    if (ListEquality().equals(normalizedNotes, [0, 4, 7])) return "";
    if (ListEquality().equals(normalizedNotes, [0, 5, 7])) return "sus4";
    if (ListEquality().equals(normalizedNotes, [0, 3, 7, 10])) return "m<sup>7</sup>";
    if (ListEquality().equals(normalizedNotes, [0, 4, 7, 10])) return "<sup>7</sup>";
    return null;
  }

  static String getBasicName(int root, List<int> normalizedNotes) {
    String matchResult = match(normalizedNotes);
    if (matchResult == null) {
      return null;
    } else {
      return NoteNames.name(root) + matchResult;
    }
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
      if (name != null) {
        names.add(name);
      }
    }

    if (names.isEmpty && notes.length > 2) {
      names = ["n.c."];
    }

    return names;
  }

  static List<int> normalize(int root, Set<int> notes) {
    List<int> noteList = [];
    int normalizedRoot = root % 12;

    for (int note in notes) {
      int normalized = ((note - normalizedRoot) + 12) % 12;
      noteList.add(normalized);
    }

    noteList.sort();
    return noteList;
  }

}

