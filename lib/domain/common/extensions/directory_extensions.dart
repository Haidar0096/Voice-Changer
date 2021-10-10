import 'dart:io';

extension DirectoryExtension on Directory {
  List<File> getFiles() {
    List<FileSystemEntity> fileSystemEntities = listSync(recursive: false)
      ..removeWhere((element) => element is! File);
    return fileSystemEntities.map((element) => File(element.path)).toList();
  }
}
