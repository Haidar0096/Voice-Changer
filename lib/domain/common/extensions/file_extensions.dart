import 'dart:io';

extension FileExtension on File {
  String getName({bool withExtension = false}) {
    if (withExtension) return path.split(Platform.pathSeparator).last;
    return path.split('/').last.split('.').first;
  }

  String getExtension() => path.split('.').last;
}
