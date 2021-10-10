import 'dart:io';

extension FileExtension on File {
  ///Returns the name of the file.For example if file path was dirA/dirB/dirC/file_name.extension then this method returns file_name
  /// It can also return it with the extension. Note that the file name must be of the form file_name.extension for this method to give the
  /// expected result
  String getName({bool withExtension = false}) {
    if (withExtension) return path.split(Platform.pathSeparator).last;
    return path.split(Platform.pathSeparator).last.split('.').first;
  }

  ///The file name must be of the form file_name.extension for this method to give the
  /// expected result. For example file_name.extension would return extension
  String getExtension() => path.split('.').last;
}
