extension StringExtension on String {
  bool isAlphaNumericWithUnderscores() =>
      RegExp(r'^[a-zA-Z0-9_]*$').hasMatch(this);
}
