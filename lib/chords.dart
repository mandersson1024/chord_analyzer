
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class ChordType {

  //
  // https://en.wikibooks.org/wiki/Music_Theory/Complete_List_of_Chord_Patterns
  //

  static final List<ChordType> allValidChords = [
    //major
    ChordType.major,
    ChordType.majorSeventh,
    ChordType.majorNinth,
    ChordType.major13th,
    ChordType.majorSixth,
    ChordType.majorSixthNinth,
    ChordType.majorLydian,
    ChordType.majorSeventhFlat6,

    // dominant/seventh (normal)
    ChordType.dominantSeventh,
    ChordType.dominantNinth,
    ChordType.dominantThirteenth,
    ChordType.lydianDominantSeventh,

    // dominant/seventh (altered)
    ChordType.dominantFlat9,
    ChordType.dominantSharp9,
    ChordType.altered,

    // dominant/seventh (suspended)
    ChordType.sus4,
    ChordType.sus2,
    ChordType.sus47,
    ChordType.eleventh,
    ChordType.sus4Flat9,

    // minor
    ChordType.minor,
    ChordType.minor7,
    ChordType.minorMajor7,
    ChordType.minor6,
    ChordType.minor9,
    ChordType.minor11,
    ChordType.minor13,

    // diminished
    ChordType.dim,
    ChordType.dim7,
    ChordType.halfDim,

    //other
    ChordType.aug,
    ChordType.aug7,
  ];

  static final ChordType undefined = ChordType("", "undefined");

  // major
  static final ChordType major = ChordType("1,3,5", "");
  static final ChordType majorSeventh = ChordType("1,3,5,7", "maj7");
  static final ChordType majorSeventhFlat6 = ChordType("1,3,5,7,b13", "maj7♭6");
  static final ChordType majorNinth = ChordType("1,3,5,7,9", "maj9");
  static final ChordType major13th = ChordType("1,3,5,7,9,11,13", "maj13");
  static final ChordType majorSixth = ChordType("1,3,5,6", "6");
  static final ChordType majorSixthNinth = ChordType("1,3,5,6,9", "6/9");
  static final ChordType majorLydian = ChordType("1,3,5,7,#11", "maj♯11");

  // dominant/seventh (normal)
  static final ChordType dominantSeventh = ChordType("1,3,5,b7", "7");
  static final ChordType dominantNinth = ChordType("1,3,5,b7,9", "9");
  static final ChordType dominantThirteenth = ChordType("1,3,5,b7,9,13", "13");
  static final ChordType lydianDominantSeventh = ChordType("1,3,5,b7,#11", "7♯11");

  // dominant/seventh (altered)
  static final ChordType dominantFlat9 = ChordType("1,3,5,b7,b9", "7♭9");
  static final ChordType dominantSharp9 = ChordType("1,3,5,b7,#9", "7♯9");
  static final ChordType altered = ChordType("1,3,b7", "alt7");

  // dominant/seventh (suspended)
  static final ChordType sus4 = ChordType("1,4,5", "sus4");
  static final ChordType sus2 = ChordType("1,2,5", "sus2");
  static final ChordType sus47 = ChordType("1,4,5,b7", "7sus4");
  static final ChordType eleventh = ChordType("1,5,b7,9,11", "11");
  static final ChordType sus4Flat9 = ChordType("1,4,5,b9", "♭9sus");

  // minor
  static final ChordType minor = ChordType("1,b3,5", "m");
  static final ChordType minor7 = ChordType("1,b3,5,b7", "m7");
  static final ChordType minorMajor7 = ChordType("1,b3,5,7", "m/maj7");
  static final ChordType minor6 = ChordType("1,b3,5,6", "m6");
  static final ChordType minor9 = ChordType("1,b3,5,b7,9", "m9");
  static final ChordType minor11 = ChordType("1,b3,5,b7,9,11", "m11");
  static final ChordType minor13 = ChordType("1,b3,5,b7,9,13", "m13");

  // diminished
  static final ChordType dim = ChordType("1,b3,b5", "<sup>o</sup>");
  static final ChordType dim7 = ChordType("1,b3,b5,6", "<sup>o</sup>7");
  static final ChordType halfDim = ChordType("1,b3,b5,b7", "<sup>ø</sup>");

  // other
  static final ChordType aug = ChordType("1,3,#5", "+");
  static final ChordType aug7 = ChordType("1,3,#5,7", "7♯5");

  List<int> definition;
  String notation;

  ChordType(String definitionString, this.notation) {
    definition = DiatonicParser.parseChord(definitionString);
  }

  String toString() {
    return notation;
  }
}

class Chord {
  String noteName;
  ChordType type;

  Chord(this.noteName, this.type);

  String toString() {
    if (type == ChordType.undefined) {
      return "n.c.";
    } else {
      return noteName + type.notation;
    }
  }

  bool get isNoChord => type == ChordType.undefined;

  bool operator==(dynamic other) {
    if (other == null) return false;
    if (!(other is Chord)) return false;
    if ((other as Chord).noteName != noteName) return false;
    if ((other as Chord).type != type) return false;
    return true;
  }
}


class Chords {

  static ChordType match(List<int> normalizedNotes) {
    for (ChordType ctype in ChordType.allValidChords) {
      //print("comparing ${normalizedNotes} with ${ctype.definition} ($ctype)");
      if (ListEquality().equals(normalizedNotes, ctype.definition)) {
        return ctype;
      }
    }

    return ChordType.undefined;
  }

  static Chord getChord(int root, List<int> notes) {
    String noteName = NoteNames.name(root);
    var normalizedNotes = notes.map((int note) => note % 12).toList();
    normalizedNotes.sort();
    ChordType type = match(normalizedNotes);
    return Chord(noteName, type);
  }

  static List<Chord> analyze(Set<int> notes) {
    List<Chord> chords = [];

    List<int> noteList = List.from(notes);

    // If the chord is ambiguous, then we want to have the lowest note
    // as the main alternative of being the root. We get this by sorting
    // the notes.
    noteList.sort();

    for (int root in noteList) {
      List<int> normalized = normalize(root, notes);
      Chord chord = getChord(root, normalized);
      if (!chord.isNoChord) {
        if (!chords.contains(chord)) {
          chords.add(chord);
        }
      }
    }

    return chords;
  }

  static List<int> normalize(int root, Set<int> notes) {
    int normalizedRoot = root % 12;
    var sameOvtave = notes.map((int note) => ((note - normalizedRoot) + 12) % 12);
    var list = sameOvtave.toSet().toList(); // remove duplicates
    list.sort();
    return list;
  }

}

