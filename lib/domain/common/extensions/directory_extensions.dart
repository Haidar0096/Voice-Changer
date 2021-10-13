import 'dart:io';

import 'package:voice_changer/domain/common/extensions/file_extensions.dart';

extension DirectoryExtension on Directory {
  ///Returns the files in this directory
  ///- [extension] : if provided then the only the files with this extension will
  ///be returned
  List<File> getFiles({String? extension}) {
    List<FileSystemEntity> fileSystemEntities = listSync(recursive: false)
      ..removeWhere((element) => element is! File);
    if (extension != null) {
      fileSystemEntities.removeWhere(
          (element) => (element as File).getExtension() != extension);
    }
    return fileSystemEntities.map((element) => File(element.path)).toList();
  }
}
