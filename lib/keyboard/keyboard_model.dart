import 'package:event_bus/event_bus.dart';

class KeyboardModel {
  EventBus events = EventBus(sync: true);
  Set<int> notes = {};

  KeyboardModel();

  void initializeViews() {
  }

  void keyPressed(int note) {
    notes.add(note);
    events.fire(KeyboardNoteSelected(note));
  }

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

class KeyboardNoteSelected {
  int note;

  KeyboardNoteSelected(this.note);
}

class KeyboardNoteUnselected {
  int note;

  KeyboardNoteUnselected(this.note);
}
