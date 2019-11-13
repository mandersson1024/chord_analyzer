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
  test("", () => expect(NoteNames.name(49), equals("C♯")));
  test("", () => expect(NoteNames.name(50), equals("D")));
  test("", () => expect(NoteNames.name(51), equals("E♭")));
  test("", () => expect(NoteNames.name(52), equals("E")));
  test("", () => expect(NoteNames.name(53), equals("F")));
  test("", () => expect(NoteNames.name(54), equals("F♯")));
  test("", () => expect(NoteNames.name(55), equals("G")));
  test("", () => expect(NoteNames.name(56), equals("A♭")));
  test("", () => expect(NoteNames.name(57), equals("A")));
  test("", () => expect(NoteNames.name(58), equals("B♭")));
  test("", () => expect(NoteNames.name(59), equals("B")));
  test("", () => expect(NoteNames.name(60), equals("C")));
  test("", () => expect(NoteNames.name(61), equals("C♯")));
  test("", () => expect(NoteNames.name(62), equals("D")));
  test("", () => expect(NoteNames.name(63), equals("E♭")));
  test("", () => expect(NoteNames.name(64), equals("E")));
  test("", () => expect(NoteNames.name(65), equals("F")));
  test("", () => expect(NoteNames.name(66), equals("F♯")));
  test("", () => expect(NoteNames.name(67), equals("G")));
  test("", () => expect(NoteNames.name(68), equals("A♭")));
  test("", () => expect(NoteNames.name(69), equals("A")));
  test("", () => expect(NoteNames.name(70), equals("B♭")));
  test("", () => expect(NoteNames.name(71), equals("B")));
  test("", () => expect(NoteNames.name(72), equals("C")));
}

void _chordsTest() {
  test("", () => expect(Chords.normalize(0, {}), equals([])));
  test("", () => expect(Chords.normalize(0, {0}), equals([0])));
  test("", () => expect(Chords.normalize(0, {0, 2}), equals([0, 2])));
  test("", () => expect(Chords.normalize(2, {0, 2}), equals([0, 10])));

  test("", () => expect(Chords.getBasicName(60, []), isNull));
  test("", () => expect(Chords.getBasicName(60, [0]), isNull));
  test("", () => expect(Chords.getBasicName(60, [0, 4]), isNull));
  test("", () => expect(Chords.getBasicName(60, [0, 2, 7]), equals("Csus2")));
  test("", () => expect(Chords.getBasicName(60, [0, 3, 7]), equals("Cm")));
  test("", () => expect(Chords.getBasicName(60, [0, 4, 7]), equals("C")));
  test("", () => expect(Chords.getBasicName(60, [0, 5, 7]), equals("Csus4")));
  test("", () => expect(Chords.getBasicName(60, [0, 3, 7, 10]), equals("Cm<sup>7</sup>")));
  test("", () => expect(Chords.getBasicName(60, [0, 4, 7, 10]), equals("C<sup>7</sup>")));

  test("", () => expect(Chords.analyse({60, 62, 67}), equals(["Csus2", "Gsus4"])));
  test("", () => expect(Chords.analyse({60, 63, 67}), equals(["Cm"])));
  test("", () => expect(Chords.analyse({60, 64, 67}), equals(["C"])));
  test("", () => expect(Chords.analyse({60, 65, 67}), equals(["Csus4", "Fsus2"])));
}

void _scalesTest() {
}
