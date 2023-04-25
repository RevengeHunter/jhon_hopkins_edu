class ScoreEquivalenceConstant {
  static String getEquivalence(double score) {
    if (0.0 <= score && score < 5.0) {
      return "D";
    }
    if (5.0 <= score && score <= 10.5) {
      return "C";
    }
    if (10.6 <= score && score <= 15.5) {
      return "B";
    }
    if (15.6 <= score && score <= 19.5) {
      return "A";
    }
    if (19.6 > score && score <= 20.0) {
      return "AD";
    }
    return "-";
  }
}
