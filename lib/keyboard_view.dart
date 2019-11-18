import "dart:html";

class KeyboardView {

  static List<int>_positions = [0, 25, 40, 65, 80, 120, 145, 160, 185, 200, 225, 240];

  static DivElement build() {
    DivElement container = DivElement();

    for (int note = 48; note <= 83; ++note) {
      int normalizedNote = note % 12;
      int octave = note ~/ 12;

      var key = _createKey(note)
        ..style.position = "absolute"
        ..style.left = "${240 * octave + _positions[normalizedNote]}px"
      ;
      container.children.add(key);
    }

    return container;
  }

  static DivElement _createKey(int midiNote) {
    if (_isBlackKey(midiNote)) {
      return DivElement()..classes.toggle("black-key");
    } else {
      return DivElement()..classes.toggle("white-key");
    }
  }

  static bool _isBlackKey(int midiNote) {
    int n = midiNote % 12;
    return n == 1 || n == 3 || n == 6 || n == 8 || n == 10;
  }

}
