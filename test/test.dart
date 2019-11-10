import "package:test/test.dart";

import "package:music_theory/note_names.dart";
import "package:music_theory/chords.dart";
import "package:music_theory/scales.dart";

void main() {
  group("note_names", _noteNamesTest);
  group("chords", _chordsTest);
  group("scales", _scalesTest);
}

void _noteNamesTest() {
  test("", () => expect(NoteNames.name(48), equals("C")));
  test("", () => expect(NoteNames.name(49), equals("C#/Db")));
  test("", () => expect(NoteNames.name(50), equals("D")));
  test("", () => expect(NoteNames.name(51), equals("D#/Eb")));
  test("", () => expect(NoteNames.name(52), equals("E")));
  test("", () => expect(NoteNames.name(53), equals("F")));
  test("", () => expect(NoteNames.name(54), equals("F#/Gb")));
  test("", () => expect(NoteNames.name(55), equals("G")));
  test("", () => expect(NoteNames.name(56), equals("G#/Ab")));
  test("", () => expect(NoteNames.name(57), equals("A")));
  test("", () => expect(NoteNames.name(58), equals("A#/Bb")));
  test("", () => expect(NoteNames.name(59), equals("B")));
  test("", () => expect(NoteNames.name(60), equals("C")));
  test("", () => expect(NoteNames.name(61), equals("C#/Db")));
  test("", () => expect(NoteNames.name(62), equals("D")));
  test("", () => expect(NoteNames.name(63), equals("D#/Eb")));
  test("", () => expect(NoteNames.name(64), equals("E")));
  test("", () => expect(NoteNames.name(65), equals("F")));
  test("", () => expect(NoteNames.name(66), equals("F#/Gb")));
  test("", () => expect(NoteNames.name(67), equals("G")));
  test("", () => expect(NoteNames.name(68), equals("G#/Ab")));
  test("", () => expect(NoteNames.name(69), equals("A")));
  test("", () => expect(NoteNames.name(70), equals("A#/Bb")));
  test("", () => expect(NoteNames.name(71), equals("B")));
  test("", () => expect(NoteNames.name(72), equals("C")));
}

void _chordsTest() {
  test("", () => expect(Chords.normalize(0, {}), equals([])));
  test("", () => expect(Chords.normalize(0, {0}), equals([0])));
  test("", () => expect(Chords.normalize(0, {0, 2}), equals([0, 2])));
  test("", () => expect(Chords.normalize(2, {0, 2}), equals([0, 10])));

  test("", () => expect(Chords.getName(60, []), isNull));
  test("", () => expect(Chords.getName(60, [0]), isNull));
  test("", () => expect(Chords.getName(60, [0, 4]), isNull));
  test("", () => expect(Chords.getName(60, [0, 4, 7]), equals("C")));
  test("", () => expect(Chords.getName(60, [0, 3, 7]), equals("Cm")));
}

void _scalesTest() {
}
