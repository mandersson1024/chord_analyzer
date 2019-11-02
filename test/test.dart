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
  test("", () => expect(NoteNames.toText(48), equals("C")));
  test("", () => expect(NoteNames.toText(49), equals("C#/Db")));
  test("", () => expect(NoteNames.toText(50), equals("D")));
  test("", () => expect(NoteNames.toText(51), equals("D#/Eb")));
  test("", () => expect(NoteNames.toText(52), equals("E")));
  test("", () => expect(NoteNames.toText(53), equals("F")));
  test("", () => expect(NoteNames.toText(54), equals("F#/Gb")));
  test("", () => expect(NoteNames.toText(55), equals("G")));
  test("", () => expect(NoteNames.toText(56), equals("G#/Ab")));
  test("", () => expect(NoteNames.toText(57), equals("A")));
  test("", () => expect(NoteNames.toText(58), equals("A#/Bb")));
  test("", () => expect(NoteNames.toText(59), equals("B")));
  test("", () => expect(NoteNames.toText(60), equals("C")));
  test("", () => expect(NoteNames.toText(61), equals("C#/Db")));
  test("", () => expect(NoteNames.toText(62), equals("D")));
  test("", () => expect(NoteNames.toText(63), equals("D#/Eb")));
  test("", () => expect(NoteNames.toText(64), equals("E")));
  test("", () => expect(NoteNames.toText(65), equals("F")));
  test("", () => expect(NoteNames.toText(66), equals("F#/Gb")));
  test("", () => expect(NoteNames.toText(67), equals("G")));
  test("", () => expect(NoteNames.toText(68), equals("G#/Ab")));
  test("", () => expect(NoteNames.toText(69), equals("A")));
  test("", () => expect(NoteNames.toText(70), equals("A#/Bb")));
  test("", () => expect(NoteNames.toText(71), equals("B")));
  test("", () => expect(NoteNames.toText(72), equals("C")));
}

void _chordsTest() {
  test("", () => expect(Chord.fromMidiNoteNumbers([60]).root, equals(null)));
  test("", () => expect(Chord.fromMidiNoteNumbers([60]).name, equals("n.c.")));
  //test("", () => expect(Chord.fromMidiNoteNumbers([60, 67]).name, equals("C(no 3)")));
  test("", () => expect(Chord.fromMidiNoteNumbers([60, 64, 67]).name, equals("C")));
  //test("", () => expect(Chord.fromMidiNoteNumbers([60, 63, 67]).name, equals("Cm")));
}

void _scalesTest() {
}
