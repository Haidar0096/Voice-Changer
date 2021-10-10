extension DateTimeExtension on DateTime {
  ///A string representation of this DateTime which is suitable for a file path String
  String toPathSuitableString() =>
      toIso8601String().split('.')[0].replaceAllMapped(RegExp(r'(:|-)'),
          (_) => '_'); //replace special characters with underscores
}
