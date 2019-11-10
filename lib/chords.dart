
import "package:music_theory/note_names.dart";

class Chord {
  List<int> notes;

  Chord.fromMidiNoteNumbers(this.notes);

  String toString() {
    return name;
  }

  String get name {
    if (notes.length < 2) {
      return "";
    } else if (root == null) {
      return "n.c.";
    } else {
      return NoteNames.toText(root);
    }
  }

  int get root {
    for (int note in notes) {
      if (hasFifth(note)) {
        return note;
      }
    }

    return null;
  }

  bool hasFifth(int note) {
    return findFifth(note, notes) != null;
  }

  static int findFifth(int note, List<int> otherNotes) {
    for (int otherNote in otherNotes) {
      if (otherNote - note == 7) {
        return otherNote;
      }
    }

    return null;
  }

}
