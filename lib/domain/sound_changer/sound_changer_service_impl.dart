import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/common/extensions/datetime_extensions.dart';
import 'package:voice_changer/domain/common/extensions/file_extensions.dart';
import 'package:voice_changer/domain/common/service/filesystem_service.dart';
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';
import 'package:voice_changer/domain/sound_changer/sound_changer_service.dart';

@Injectable(as: SoundChangerService)
class SoundChangerServiceImpl implements SoundChangerService {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
  final FileSystemService _fileSystemService =
      serviceLocator.get<FileSystemService>();
  final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
  final RecordingDetailsService _recordingDetailsService =
      serviceLocator.get<RecordingDetailsService>();

  @override
  Future<Either<Failure, void>> addEcho({
    required File inputFile,
    required File outputFile,
    required double inputGain,
    required double outputGain,
    required List<double> delays,
    required List<double> decays,
  }) async {
    try {
      if (inputGain < 0 || inputGain > 1 || outputGain < 0 || outputGain > 1) {
        throw Exception(
            'input gain and output gain must be in the range [0,1]');
      }
      for (final delay in delays) {
        if (delay < 0 || delay > 90000) {
          throw Exception('delay must be an int in range [0,90000]');
        }
      }
      for (final decay in decays) {
        if (decay < 0 || decay > 1) {
          throw Exception('decay must be a double in range [0,1]');
        }
      }
      if (delays.length != decays.length) {
        throw Exception('delays and decays must have same lengths');
      }
      if (delays.isEmpty || decays.isEmpty) {
        throw Exception('delays and decays must not be empty');
      }

      int changeEchoResult = 0;
      int moveDataResult = 0;
      String delaysParams = '';
      String decaysParams = '';
      for (int i = 0; i < delays.length; i++) {
        delaysParams += '${delays[i]}${i == delays.length - 1 ? '' : '|'}';
      }
      for (int i = 0; i < decays.length; i++) {
        decaysParams += '${decays[i]}${i == decays.length - 1 ? '' : '|'}';
      }
      String echoCommandParams =
          '$inputGain:$outputGain:$delaysParams:$decaysParams';
      if (inputFile.path != outputFile.path) {
        //write directly into the output file
        changeEchoResult = await _ffmpeg.execute(
            '-y -i ${inputFile.path} -af \'aecho=$echoCommandParams\' ${outputFile.path}');
      } else {
        //write into a temp file first then move the data to the output file
        File tempFile = await _createTempFile(outputFile);
        changeEchoResult = await _ffmpeg.execute(
            '-i ${inputFile.path} -af \'aecho=$echoCommandParams\' ${tempFile.path}');
        moveDataResult =
            await _ffmpeg.execute('-y -i ${tempFile.path} ${outputFile.path}');
        await tempFile.delete();
      }
      if (changeEchoResult != 0 || moveDataResult != 0) {
        throw Exception('add echo command did not execute successfully');
      }
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in addEcho', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.addEchoError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> changeTempo({
    required File inputFile,
    required File outputFile,
    required double tempo,
  }) async {
    try {
      if (tempo < 0.5 || tempo > 100) {
        throw Exception('tempo value must be between 0.5 and 100');
      }
      int changeTempoResult = 0;
      int moveDataResult = 0;
      if (inputFile.path != outputFile.path) {
        //write directly into the output file
        changeTempoResult = await _ffmpeg.execute(
            '-y -i ${inputFile.path} -af \'atempo=$tempo\' ${outputFile.path}');
      } else {
        //write into a temp file first then move the data to outputFilePath
        File tempFile = await _createTempFile(outputFile);
        changeTempoResult = await _ffmpeg.execute(
            '-i ${inputFile.path} -af \'atempo=$tempo\' ${tempFile.path}');
        moveDataResult =
            await _ffmpeg.execute('-y -i ${tempFile.path} ${outputFile.path}');
        await tempFile.delete();
      }
      if (changeTempoResult != 0 || moveDataResult != 0) {
        throw Exception('change tempo command did not execute successfully');
      }
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in changeTempo', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.changeTempoError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> reverseAudio({
    required File inputFile,
    required File outputFile,
  }) async {
    try {
      int reverseResult = 0;
      int moveDataResult = 0;
      if (inputFile.path != outputFile.path) {
        //write directly into the output file
        reverseResult = await _ffmpeg.execute(
            '-y -i ${inputFile.path} -af \'areverse\' ${outputFile.path}');
      } else {
        //write into a temp file first then move the data to outputFilePath
        File tempFile = await _createTempFile(outputFile);
        reverseResult = await _ffmpeg
            .execute('-i ${inputFile.path} -af \'areverse\' ${tempFile.path}');
        moveDataResult =
            await _ffmpeg.execute('-y -i ${tempFile.path} ${outputFile.path}');
        await tempFile.delete();
      }
      if (reverseResult != 0 || moveDataResult != 0) {
        throw Exception('reverse audio command did not execute successfully');
      }
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in reverseAudio', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.reverseAudioError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setSampleRate({
    required File inputFile,
    required File outputFile,
    required int sampleRate,
  }) async {
    try {
      if (sampleRate < 8000 || sampleRate > 120000) {
        throw Exception('sample rate must be between 8000 and 120000');
      }
      int setRateResult = 0;
      int moveDataResult = 0;
      if (inputFile.path != outputFile.path) {
        //write directly into the output file
        setRateResult = await _ffmpeg.execute(
            '-y -i ${inputFile.path} -af \'asetrate=$sampleRate\' ${outputFile.path}');
      } else {
        //write into a temp file first then move the data to outputFilePath
        File tempFile = await _createTempFile(outputFile);
        setRateResult = await _ffmpeg.execute(
            '-i ${inputFile.path} -af \'asetrate=$sampleRate\' ${tempFile.path}');
        moveDataResult =
            await _ffmpeg.execute('-y -i ${tempFile.path} ${outputFile.path}');
        await tempFile.delete();
      }
      if (setRateResult != 0 || moveDataResult != 0) {
        throw Exception('set sample rate command did not execute successfully');
      }
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in setSampleRate', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.setSampleRateError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setVolume({
    required File inputFile,
    required File outputFile,
    required double volume,
  }) async {
    try {
      if (volume < 0 || volume > 100) {
        throw Exception('volume must be between 0 and 100');
      }
      int changeVolumeResult = 0;
      int moveDataResult = 0;
      if (inputFile.path != outputFile.path) {
        //write directly into the output file
        changeVolumeResult = await _ffmpeg.execute(
            '-y -i ${inputFile.path} -af \'volume=$volume\' ${outputFile.path}');
      } else {
        //write into a temp file first then move the data to outputFilePath
        File tempFile = await _createTempFile(outputFile);
        changeVolumeResult = await _ffmpeg.execute(
            '-i ${inputFile.path} -af \'volume=$volume\' ${tempFile.path}');
        moveDataResult =
            await _ffmpeg.execute('-y -i ${tempFile.path} ${outputFile.path}');
        await tempFile.delete();
      }
      if (changeVolumeResult != 0 || moveDataResult != 0) {
        throw Exception('change volume command did not execute successfully');
      }
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in setVolume', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.setVolumeError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> trimSound({
    required File inputFile,
    required File outputFile,
    required int start,
    required int end,
  }) async {
    try {
      if (start >= end) {
        throw Exception('start must be < end');
      }
      Duration? audioDuration =
          await (await _recordingDetailsService.getRecordingDetails(inputFile))
              .fold(
        (f) => throw f,
        (recordingDetails) => recordingDetails.duration,
      );
      if (audioDuration == null) {
        throw Exception('couldn\'t get duration of the audio');
      }
      if (start < 0 || end < 0 || end > audioDuration.inSeconds) {
        throw Exception(
            'start < 0, end < 0, end < audio duration constraints were not fully satisfied');
      }
      int trimResult = 0;
      int moveDataResult = 0;
      if (inputFile.path != outputFile.path) {
        //write directly into the output file
        trimResult = await _ffmpeg.execute(
            '-y -i ${inputFile.path} -af \'atrim=$start:$end\' ${outputFile.path}');
      } else {
        //write into a temp file first then move the data to outputFilePath
        File tempFile = await _createTempFile(outputFile);
        trimResult = await _ffmpeg.execute(
            '-i ${inputFile.path} -af \'atrim=$start:$end\' ${tempFile.path}');
        moveDataResult =
            await _ffmpeg.execute('-y -i ${tempFile.path} ${outputFile.path}');
        await tempFile.delete();
      }
      if (trimResult != 0 || moveDataResult != 0) {
        throw Exception('trim command did not execute successfully');
      }
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in trimSound', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.trimSoundError(),
        ),
      );
    }
  }

  Future<File> _createTempFile(File outputFile) async {
    return await ((await _fileSystemService.getDefaultStorageDirectory()).fold(
      (f) => throw f,
      (defaultDirectory) async => (await _fileSystemService.createFile(
        fileName: 'tmp${DateTime.now().toPathSuitableString()}',
        extension: FileExtension.getExtension(outputFile.path),
        path: defaultDirectory.path,
      ))
          .fold(
        (f) => throw f,
        id,
      ),
    ));
  }
}
