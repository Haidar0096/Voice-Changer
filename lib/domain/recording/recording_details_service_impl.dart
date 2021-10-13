import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/common/extensions/file_extensions.dart';
import 'package:voice_changer/domain/recording/recording_details_service.dart';

@Injectable(as: RecordingDetailsService)
class RecordingDetailsServiceImpl implements RecordingDetailsService {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);

  @override
  Future<Either<Failure, RecordingDetails>> getRecordingDetails(
      File recordingFile) async {
    try {
      Duration? duration;
      final ffprobe = FlutterFFprobe();
      final mediaInfo = await ffprobe.getMediaInformation(recordingFile.path);
      String? durationString = mediaInfo.getMediaProperties()?['duration'];
      if (durationString != null) {
        duration = _parseDuration(durationString);
      }
      return Right(
        RecordingDetails(
          path: recordingFile.path,
          name: recordingFile.getName(),
          duration: duration,
        ),
      );
    } catch (e) {
      _logger.e('error occurred in getRecordingDetails()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.getRecordingDetailsError(),
        ),
      );
    }
  }

  Duration _parseDuration(String durationString) {
    //example of the durationString: 1.536000
    int seconds = int.parse(durationString.split('.')[0]);
    int milliseconds =
        int.parse(durationString.split('.')[1].substring(0, 1)) * 100;
    return Duration(
        seconds: seconds,
        milliseconds:
            milliseconds); // returns Duration of 1 sec and 500 ms for the above example
  }
}
