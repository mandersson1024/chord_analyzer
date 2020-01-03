import 'package:event_bus/event_bus.dart';

class KeyboardModel {
  EventBus events = EventBus(sync: true);
  Set<int> notes = {};

  KeyboardModel();

  void setNote(int note, bool on) {
    if (on) {
      notes.add(note);
    } else {
      notes.remove(note);
    }

    events.fire(KeyboardNoteSelectionChanged(note, on));
  }

  void toggleNote(int note) {
    if (notes.contains(note)) {
      notes.remove(note);
    } else {
      notes.add(note);
    }

    events.fire(KeyboardNoteSelectionChanged(note, notes.contains(note)));
  }

  bool getNote(int note) {
    return notes.contains(note);
  }

}

class KeyboardNoteSelectionChanged {
  int note;
  bool selected;

  KeyboardNoteSelectionChanged(this.note, this.selected);
}
