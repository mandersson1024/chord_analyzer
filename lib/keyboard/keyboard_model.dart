import 'package:event_bus/event_bus.dart';

class KeyboardModel {
  EventBus events = EventBus(sync: true);
  Set<int> notes = {};

  KeyboardModel();

  void _addNote(int note) {
    if (!notes.contains(note)) {
      notes.add(note);
      events.fire(KeyboardNoteSelectionChanged(note, true));
      events.fire(KeyboardPlayNote(note));
    }
  }

  void _removeNote(int note) {
    if (notes.contains(note)) {
      notes.remove(note);
      events.fire(KeyboardNoteSelectionChanged(note, false));
    }
  }

  void setNote(int note, bool on) {
    if (on) {
      _addNote(note);
    } else {
      _removeNote(note);
    }
  }

  void toggleNote(int note) {
    setNote(note, !getNote(note));
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

class KeyboardPlayNote {
  int note;

  KeyboardPlayNote(this.note);
}
