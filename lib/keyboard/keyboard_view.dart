import "dart:html";

typedef KeyboardClickCallback = void Function(int note);

class KeyboardView {

  static const int _whiteKeyWidth = 41;
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

  DivElement div;
  Map<int, DivElement> _keys = {};

  KeyboardView(KeyboardClickCallback clickCallback, { HtmlElement parent }) {
    div = DivElement();

    if (parent != null) {
      parent.children.add(div);
    }

    int startNote = 48;
    int numKeys = 36;
    int numWhiteKeysCounter = 0;

    for (int i = 0; i < numKeys; ++i) {
      int note = startNote + i;
      int normalizedNote = note % 12;
      int octave = i ~/ 12;

      var key = _createKey(note, parent: div)
        ..style.left = "${_octaveWidth * octave + _positions[normalizedNote]}px"
        ..onClick.listen((_) => clickCallback(note))
      ;

      if (!_isBlackKey(note)) {
        ++numWhiteKeysCounter;
      }

      _keys[note] = key;
    }

    div
      ..style.position = "absolute"
      ..style.width = "${numWhiteKeysCounter * _whiteKeyWidth}px"
    ;
  }

  DivElement _createKey(int midiNote, { HtmlElement parent }) {
    DivElement div = DivElement()
      ..classes.toggle(_isBlackKey(midiNote) ? "black-key" : "white-key")
    ;

    if (parent != null) {
      parent.children.add(div);
    }

    return div;
  }

  bool _isBlackKey(int midiNote) {
    int n = midiNote % 12;
    return n == 1 || n == 3 || n == 6 || n == 8 || n == 10;
  }

  void setKeySelected(int note, bool selected) {
    _keys[note].classes.toggle("key-selected", selected);
  }

}
