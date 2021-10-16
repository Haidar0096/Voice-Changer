import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';

///This class provides access to the file system.
@Injectable()
class FileSystemService {
  final Logger _logger = serviceLocator.get<Logger>();

  ///The default storage directory of the app
  Future<Either<Failure, Directory>> getDefaultStorageDirectory() async {
    try {
      Directory defaultStorageDirectory =
          (await path_provider.getApplicationDocumentsDirectory());
      return Right(defaultStorageDirectory);
    } catch (e) {
      _logger.e('error occurred in _getDefaultStorageDirectory', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.getDefaultStorageDirectoryError(),
        ),
      );
    }
  }

  ///creates a file object which will have a path as "[path]/[fileName].[extension]", and returns it.
  /// If file point to path of a file which already exists in the provided directory, it will be deleted first
  Future<Either<Failure, File>> createFile({
    required String fileName,
    required String extension,
    required String path,
  }) async {
    try {
      File file = File('$path/$fileName.$extension');
      bool exists = await file.exists();
      if (exists) {
        await file.delete();
      }
      return Right(file);
    } catch (e) {
      _logger.e('error occurred in createTempFile', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.createFileError(),
        ),
      );
    }
  }

  Future<Either<Failure, void>> deleteFile(File file) async {
    try {
      await file.delete();
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in deleteFile()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.deleteFileError(),
        ),
      );
    }
  }

  ///- [file] : The file to rename. The [fileName] must consist of only alphanumeric  and underscore characters.
  ///- [extension] : The extension for the new file
  Future<Either<Failure, File>> renameFile({
    required File file,
    required String newFileName,
    required String extension,
  }) async {
    try {
      final r = RegExp(
          r'^[a-zA-Z0-9_]*$'); //alphanumeric and underscores only for file name
      if (!r.hasMatch(newFileName) || newFileName.isEmpty) {
        throw Exception(
            '$newFileName is not a valid file name, it must only contain alphanumeric/underscore characters');
      }
      final path = file.path;
      final lastSeparator = path.lastIndexOf(Platform.pathSeparator);
      final newPath =
          path.substring(0, lastSeparator + 1) + newFileName + '.$extension';
      final renamedFile = await file.rename(newPath);
      return Right(renamedFile);
    } catch (e) {
      _logger.e('error occurred in renameFile()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.renameFileError(),
        ),
      );
    }
  }
}
