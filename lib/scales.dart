
class Scale {

  static Scale ionian = Scale.fromHalfSteps("Ionian", [0, 2, 4, 5, 7, 9, 11]);

  String name;
  List<int> halfStepIntervals;

  Scale.fromHalfSteps(this.name, this.halfStepIntervals);

  String toString() {
    return name;
  }

  static List<Scale> match(List<int> notes) {
    return [];
  }
}

