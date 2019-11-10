class AppState {
  Set<int> _notes = {};

  List<int> get noteList => _notes.toList();

  void setNote(int note, bool on) {
    if (on) {
      _notes.add(note);
    } else {
      _notes.remove(note);
    }
  }

  void toggleNote(int note) {
    if (_notes.contains(note)) {
      _notes.remove(note);
    } else {
      _notes.add(note);
    }
  }

  bool getNote(int note) {
    return _notes.contains(note);
  }
}