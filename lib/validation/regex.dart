class SMSregex {
  /// Returns whether the pattern has a match in the string [input].
  static bool hasMatch(String s, Pattern p) => RegExp(p.toString()).hasMatch(s);
}
