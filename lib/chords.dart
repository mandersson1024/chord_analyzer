
import "package:collection/collection.dart";
import "package:music_theory/note_names.dart";

class ChordType {

  //
  // https://en.wikibooks.org/wiki/Music_Theory/Complete_List_of_Chord_Patterns
  //

  static final List<ChordType> allValidChords = [
    //major
    ChordType.major,
    ChordType.major.no("3"),
    ChordType.majorSeventh,
    ChordType.majorSeventh.no("3"),
    ChordType.majorSeventh.no("5"),
    ChordType.majorNinth,
    ChordType.majorNinth.no("5"),
    ChordType.major13th,
    //ChordType.major13th.no("5"), // duplicated by simpler chord
    //ChordType.major13th.no("5,9"),  // duplicated by simpler chord
    ChordType.major13th.no("5,11"),
    ChordType.major13th.no("5,9,11"),
    ChordType.major13th.no("9"),
    ChordType.major13th.no("9,11"),
    ChordType.major13th.no("11"),
    ChordType.majorSixth,
    //ChordType.majorSixth.no("5"), // duplicated by simpler chord
    ChordType.majorSixthNinth,
    ChordType.majorSixthNinth.no("5"),
    ChordType.majorLydian,
    //ChordType.majorLydian.no("5"),  // duplicated by simpler chord
    ChordType.majorLydian.no("5,7"),
    ChordType.majorLydian.no("7"),
    ChordType.majorLydian.add("9"),
    ChordType.majorLydian.add("9,13"),
    //ChordType.majorLydian.add("13"), // duplicated by simpler chord
    ChordType.majorSeventhFlat6,
    ChordType.majorSeventhFlat6.no("5"),
    ChordType.majorSeventhFlat6.no("9"),
    ChordType.majorSeventhFlat6.add("11"),
    ChordType.majorSeventhFlat6.no("5").add("11"),
    ChordType.majorSeventhFlat6.no("9").add("11"),

    // dominant/seventh (normal)
    ChordType.dominantSeventh,
    ChordType.dominantSeventh.no("3"),
    //ChordType.dominantSeventh.no("5"), // duplicated by simpler chord
    ChordType.dominantNinth,
    ChordType.dominantNinth.no("5"),
    ChordType.dominantThirteenth,
    ChordType.dominantThirteenth.no("5"),
    ChordType.dominantThirteenth.add("9"),
    ChordType.dominantThirteenth.no("5").add("9"),
    ChordType.lydianDominantSeventh,
    ChordType.lydianDominantSeventh.add("9"),
    ChordType.lydianDominantSeventh.add("13"),
    ChordType.lydianDominantSeventh.add("9,13"),
    ChordType.lydianDominantSeventh.no("5"),
    ChordType.lydianDominantSeventh.no("5").add("9"),
    ChordType.lydianDominantSeventh.no("5").add("13"),
    ChordType.lydianDominantSeventh.no("5").add("9,13"),

    // dominant/seventh (altered)
    ChordType.dominantFlat9,
    ChordType.dominantFlat9.no("5"),
    ChordType.dominantSharp9,
    ChordType.dominantSharp9.no("5"),
    ChordType.altered,

    // dominant/seventh (suspended)
    ChordType.sus4,
    //ChordType.sus4.no("5"), // duplicated by simpler chord
    ChordType.sus2,
    ChordType.sus2.no("5"),
    ChordType.sus47,
    //ChordType.sus47.no("5"), // duplicated by simpler chord
    ChordType.eleventh,
    ChordType.eleventh.no("5"),
    //ChordType.eleventh.no("9"), // duplicated by simpler chord
    //ChordType.eleventh.no("5,9"), // duplicated by simpler chord
    ChordType.sus4Flat9,
    ChordType.sus4Flat9.no("5"),

    // minor
    ChordType.minor,
    ChordType.minor7,
    ChordType.minor7.no("5"),
    ChordType.minorMajor7,
    ChordType.minorMajor7.add("9"),
    ChordType.minorMajor7.add("9,13"),
    ChordType.minorMajor7.add("9,b13"),
    ChordType.minorMajor7.add("13"),
    ChordType.minorMajor7.add("b13"),
    ChordType.minorMajor7.no("5"),
    ChordType.minorMajor7.no("5").add("9"),
    ChordType.minorMajor7.no("5").add("9,13"),
    ChordType.minorMajor7.no("5").add("9,b13"),
    ChordType.minorMajor7.no("5").add("13"),
    ChordType.minorMajor7.no("5").add("b13"),
    ChordType.minor6,
    //ChordType.minor6.no("5"), // duplicated by simpler chord
    ChordType.minor9,
    ChordType.minor9.no("5"),
    ChordType.minor11,
    ChordType.minor11.no("5"),
    //ChordType.minor11.no("5,9"), // duplicated by simpler chord
    //ChordType.minor11.no("9"), // duplicated by simpler chord
    ChordType.minor13,
    ChordType.minor13.no("5"),
    ChordType.minor13.no("5,9"),
    ChordType.minor13.no("9"),

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
  static final ChordType majorSeventh = ChordType("1,3,5,7", "maj7", html: "<small>maj</small>7");
  static final ChordType majorNinth = ChordType("1,3,5,7,9", "maj9", html: "<small>maj</small>9");
  static final ChordType major13th = ChordType("1,3,5,7,9,11,13", "maj13", html: "<small>maj</small>13");
  static final ChordType majorSixth = ChordType("1,3,5,6", "6");
  static final ChordType majorSixthNinth = ChordType("1,3,5,6,9", "6/9");
  static final ChordType majorLydian = ChordType("1,3,5,7,#11", "maj#11", html: "<small>maj</small>#11");
  static final ChordType majorSeventhFlat6 = ChordType("1,3,5,7,9,b13", "maj7b6", html: "<small>maj</small>7b6");

  // dominant/seventh (normal)
  static final ChordType dominantSeventh = ChordType("1,3,5,b7", "7");
  static final ChordType dominantNinth = ChordType("1,3,5,b7,9", "9");
  static final ChordType dominantThirteenth = ChordType("1,3,5,b7,9,13", "13");
  static final ChordType lydianDominantSeventh = ChordType("1,3,5,b7,#11", "7#11");

  // dominant/seventh (altered)
  static final ChordType dominantFlat9 = ChordType("1,3,5,b7,b9", "7b9");
  static final ChordType dominantSharp9 = ChordType("1,3,5,b7,#9", "7#9");
  static final ChordType altered = ChordType("1,3,b7", "alt7", html: "<small>alt</small>7");

  // dominant/seventh (suspended)
  static final ChordType sus4 = ChordType("1,4,5", "sus4", html: "<small>sus</small>4");
  static final ChordType sus2 = ChordType("1,2,5", "sus2", html: "<small>sus</small>2");
  static final ChordType sus47 = ChordType("1,4,5,b7", "7sus4", html: "7<small>sus</small>4");
  static final ChordType eleventh = ChordType("1,5,b7,9,11", "11");
  static final ChordType sus4Flat9 = ChordType("1,4,5,b9", "b9sus", html: "b9<small>sus</small>");

  // minor
  static final ChordType minor = ChordType("1,b3,5", "m", html: "<small>m</small>");
  static final ChordType minor7 = ChordType("1,b3,5,b7", "m7", html: "<small>m</small>7");
  static final ChordType minorMajor7 = ChordType("1,b3,5,7", "m/maj7", html: "<small>m/maj</small>7");
  static final ChordType minor6 = ChordType("1,b3,5,6", "m6", html: "<small>m</small>6");
  static final ChordType minor9 = ChordType("1,b3,5,b7,9", "m9", html: "<small>m</small>9");
  static final ChordType minor11 = ChordType("1,b3,5,b7,9,11", "m11", html: "<small>m</small>11");
  static final ChordType minor13 = ChordType("1,b3,5,b7,9,13", "m13", html: "<small>m</small>13");

  // diminished
  static final ChordType dim = ChordType("1,b3,b5", "o", html: "<sup>o</sup>");
  static final ChordType dim7 = ChordType("1,b3,b5,6", "o7", html: "<sup>o</sup>7");
  static final ChordType halfDim = ChordType("1,b3,b5,b7", "ø", html: "<sup>ø</sup>");

  // other
  static final ChordType aug = ChordType("1,3,#5", "+");
  static final ChordType aug7 = ChordType("1,3,#5,7", "7#5");

  String definitionString;
  List<int> definition;
  String ascii;
  String html;

  ChordType(this.definitionString, this.ascii, {this.html}) {
    definition = DiatonicParser.parseChord(definitionString);
    if (html == null) {
      html = ascii;
    }

    html = html.replaceAll("#", "♯").replaceAll("b", "♭");
  }

  ChordType no(String notes) {
    List<String> diatonicNotes = definitionString.split(",");
    List<String> alteredNotes = notes.split(",");
    diatonicNotes.removeWhere((String note) => alteredNotes.contains(note));
    ChordType variation = ChordType(diatonicNotes.join(","), "${ascii}(no${notes})", html: "$html<sup>(<small>no</small>${notes})</sup>");
    return variation;
  }

  ChordType add(String notes) {
    List<String> diatonicNotes = definitionString.split(",");
    List<String> alteredNotes = notes.split(",");
    diatonicNotes.addAll(alteredNotes);
    ChordType variation = ChordType(diatonicNotes.join(","), "${ascii}(add${notes})", html: "$html<sup>(<small>add</small>${notes})</sup>");
    return variation;
  }

  String toString() {
    return ascii;
  }
}

class Chord {
  String root;
  ChordType type;

  Chord(this.root, this.type);

  String toString() {
    if (type == ChordType.undefined) {
      return "n.c.";
    } else {
      return "${root}${type.html}";
    }
  }

  bool get isNoChord => type == ChordType.undefined;

  bool operator==(dynamic other) {
    if (other == null) return false;
    if (!(other is Chord)) return false;
    if ((other as Chord).root != root) return false;
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

