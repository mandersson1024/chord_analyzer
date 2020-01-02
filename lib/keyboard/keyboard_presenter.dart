
import 'keyboard_model.dart';
import '../event_forwarder.dart';

class KeyboardPresenter {

  KeyboardModel _model;
  EventForwarder<KeyboardNoteSelected> onKeySelected;

  KeyboardPresenter(this._model) {
    onKeySelected = EventForwarder(_model.events);
  }

  void pressKey(int note) {
    _model.keyPressed(note);
  }
}
