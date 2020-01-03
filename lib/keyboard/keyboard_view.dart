import "dart:html";

class KeyboardView {

  static const int _whiteKeyWidth = 40;
  static const int _blackKeyWidth = 25;
  static const int _octaveWidth = _whiteKeyWidth * 7;
  static List<int> _positions = [
    0,
    _blackKeyWidth,
    _whiteKeyWidth,
    _whiteKeyWidth + _blackKeyWidth,
    2 * _whiteKeyWidth,
    3 * _whiteKeyWidth,
    3 * _whiteKeyWidth + _blackKeyWidth,
    4 * _whiteKeyWidth,
    4 * _whiteKeyWidth + _blackKeyWidth,
    5 * _whiteKeyWidth,
    5 * _whiteKeyWidth + _blackKeyWidth,
    6 * _whiteKeyWidth,
  ];

  static DivElement build({ HtmlElement parent }) {
    DivElement container = DivElement();

    int startNote = 48;
    int numKeys = 36;
    int startOffset = (startNote ~/ 12) * _octaveWidth;

    for (int i = 0; i < numKeys; ++i) {
      int note = startNote + i;
      int normalizedNote = note % 12;
      int octave = note ~/ 12;

      var key = _createKey(note)
        ..style.position = "absolute"
        ..style.left = "${_octaveWidth * octave + _positions[normalizedNote] - startOffset}px"
      ;
      container.children.add(key);
    }

    if (parent != null) {
      parent.children.add(container);
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
