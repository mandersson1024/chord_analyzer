class AppState {
  Set<int> _notes = {};

  List<int> get noteList => _notes.toList();

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