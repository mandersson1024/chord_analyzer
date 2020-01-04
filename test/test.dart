import "package:test/test.dart";

import "package:music_theory/note_names.dart";
import "package:music_theory/chords.dart";

void main() {
  group("note_names", _noteNamesTest);
  group("diatonic_to_chromatic", _diatonicStepToChromaticTest);
  group("chords", _chordsTest);
}

void _noteNamesTest() {
  test("", () => expect(NoteNames.name(48), equals("C")));
  test("", () => expect(NoteNames.name(49), equals("D♭")));
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
  test("", () => expect(NoteNames.name(61), equals("D♭")));
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

void _diatonicStepToChromaticTest() {
  test("", () => expect(DiatonicParser.parse("1"), 0));
  test("", () => expect(DiatonicParser.parse("#1"), 1));
  test("", () => expect(DiatonicParser.parse("b2"), 1));
  test("", () => expect(DiatonicParser.parse("2"), 2));
  test("", () => expect(DiatonicParser.parse("#2"), 3));
  test("", () => expect(DiatonicParser.parse("b3"), 3));
  test("", () => expect(DiatonicParser.parse("3"), 4));
  test("", () => expect(DiatonicParser.parse("4"), 5));
  test("", () => expect(DiatonicParser.parse("#4"), 6));
  test("", () => expect(DiatonicParser.parse("b5"), 6));
  test("", () => expect(DiatonicParser.parse("5"), 7));
  test("", () => expect(DiatonicParser.parse("#5"), 8));
  test("", () => expect(DiatonicParser.parse("b6"), 8));
  test("", () => expect(DiatonicParser.parse("6"), 9));
  test("", () => expect(DiatonicParser.parse("#6"), 10));
  test("", () => expect(DiatonicParser.parse("b7"), 10));
  test("", () => expect(DiatonicParser.parse("7"), 11));

  test("", () => expect(DiatonicParser.parse("8"), 0)); // 1
  test("", () => expect(DiatonicParser.parse("#8"), 1)); // #1
  test("", () => expect(DiatonicParser.parse("b9"), 1)); // b2
  test("", () => expect(DiatonicParser.parse("9"), 2)); // 2
  test("", () => expect(DiatonicParser.parse("#9"), 3)); // #2
  test("", () => expect(DiatonicParser.parse("b10"), 3)); // b3
  test("", () => expect(DiatonicParser.parse("10"), 4)); // 3
  test("", () => expect(DiatonicParser.parse("11"), 5)); // 4
  test("", () => expect(DiatonicParser.parse("#11"), 6)); // #4
}

void _chordsTest() {
  test("", () => expect(Chords.getChord(60, []).type, ChordType.undefined));
  test("", () => expect(Chords.getChord(60, [0]).type, ChordType.undefined));
  test("", () => expect(Chords.getChord(60, [0, 4]).type, ChordType.undefined));

  // triads
  test("", () => expect(Chords.getChord(60, [0, 4, 7]).type, ChordType.major));
  test("", () => expect(Chords.getChord(60, [0, 3, 7]).type, ChordType.m));
  test("", () => expect(Chords.getChord(60, [0, 3, 6]).type, ChordType.dim));
  test("", () => expect(Chords.getChord(60, [0, 4, 8]).type, ChordType.aug));
  test("", () => expect(Chords.getChord(60, [0, 2, 7]).type, ChordType.sus2));
  test("", () => expect(Chords.getChord(60, [0, 5, 7]).type, ChordType.sus4));

  test("", () => expect(Chords.getChord(60, [0, 3, 7, 10]).type, ChordType.m7));
  test("", () => expect(Chords.getChord(60, [0, 4, 7, 11]).type, ChordType.majorSeventh));
  test("", () => expect(Chords.getChord(60, [0, 4, 7, 11, 14]).type, ChordType.majorNinth));

  test("duplicates of notes", () => expect(Chords.analyze({60, 60, 64, 67}), equals([Chord("C", ChordType.major)])));
  test("same note in octaves", () => expect(Chords.analyze({60, 64, 67, 72}), equals([Chord("C", ChordType.major)])));

  test("", () => expect(Chords.analyze({60, 62, 67}), equals([Chord("C", ChordType.sus2), Chord("G", ChordType.sus4)])));
  test("", () => expect(Chords.analyze({60, 63, 67}), equals([Chord("C", ChordType.m)])));
  test("", () => expect(Chords.analyze({60, 64, 67}), equals([Chord("C", ChordType.major)])));
  test("", () => expect(Chords.analyze({60, 64, 67, 69}), equals([Chord("C", ChordType.sixth), Chord("A", ChordType.m7)])));
  test("", () => expect(Chords.analyze({60, 63, 67, 69}), equals([Chord("C", ChordType.m6)])));
  test("", () => expect(Chords.analyze({60, 65, 67}), equals([Chord("C", ChordType.sus4), Chord("F", ChordType.sus2)])));
}
