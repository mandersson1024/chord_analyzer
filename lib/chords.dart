
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class Chords {

  static String match(List<int> normalizedNotes) {
    if (ListEquality().equals(normalizedNotes, [0, 4, 7])) return "";
    if (ListEquality().equals(normalizedNotes, [0, 3, 7])) return "m";
    return null;
  }

  static String getName(int root, List<int> normalizedNotes) {
    String matchResult = match(normalizedNotes);
    if (matchResult == null) {
      return null;
    } else {
      return NoteNames.name(root) + matchResult;
    }
  }

  static List<String> analyse(Set<int> notes) {
    List<String> names = [];

    for (int root in notes) {
      List<int> normalized = normalize(root, notes);
      String name = getName(root, normalized);
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

