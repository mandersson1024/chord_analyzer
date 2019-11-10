class AppState {
  Set<int> notes = {};

  void setNote(int note, bool on) {
    if (on) {
      notes.add(note);
    } else {
      notes.remove(note);
    }
  }

  void toggleNote(int note) {
    if (notes.contains(note)) {
      notes.remove(note);
    } else {
      notes.add(note);
    }
  }

  bool getNote(int note) {
    return notes.contains(note);
  }
}
