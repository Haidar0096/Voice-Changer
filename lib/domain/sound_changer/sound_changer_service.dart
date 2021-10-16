import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';

///The contract of sound changer.
abstract class SoundChangerService {
  ///Changes the tempo.
  ///* [tempo] must be between 0.5 and 100.
  ///<br></br>
  ///<br></br>
  ///If [outputFile] exists, then it will be overwritten.
  Future<Either<Failure, void>> changeTempo({
    required File inputFile,
    required File outputFile,
    required double tempo,
  }); //todo remove this  ffmpeg -y -i ip_file -af atempo=tempo_value op_file

  ///Adds echo.
  ///- [inputGain] : input gain of reflected signal. Must be between 0 and 1
  ///- [outputGain] : output gain of reflected signal. Must be between 0 and 1
  ///- [delays] : list of time intervals in milliseconds between original signal and reflections. Allowed range for each delay is (0 - 90000.0].
  ///- [decays] : list of loudness of reflected signals. Allowed range for each decay is (0 - 1.0] with 1.0 being the loudest.
  ///<br></br>
  ///<br></br>
  /// The length of the [delays] and [decays] lists must be the same (each delay corresponds to the decay at the same index)
  ///<br></br>
  ///<br></br>
  ///If [outputFile] exists, then it will be overwritten.
  Future<Either<Failure, void>> addEcho({
    required File inputFile,
    required File outputFile,
    required double inputGain,
    required double outputGain,
    required List<double> delays,
    required List<double> decays,
  }); //todo remove this  ffmpeg -y -i ip_file -af aecho=in_gain:out_gain:delay1|delay2|delay3:decay1|decay2|decay3 op_file

  ///Trims the audio at the supplied location and only keeps the part between [start] and [end]. [start] and [end] are in seconds
  ///- Constraints: [start] must be less than [end], and both [start] and [end] must be positive and less than audio duration
  ///<br></br>
  ///<br></br>
  ///If [outputFile] exists, then it will be overwritten.
  Future<Either<Failure, void>> trimSound({
    required File inputFile,
    required File outputFile,
    required int start,
    required int end,
  }); // todo remove this  ffmpeg -y -i ip -af 'atrim=start_time_in_seconds:end_time_in_seconds'  op

  ///Set the sample rate without altering the PCM data. This will result in a change of speed and pitch.
  ///- [sampleRate] : must be between 8000 and 120000
  ///<br></br>
  ///<br></br>
  ///If [outputFile] exists, then it will be overwritten.
  Future<Either<Failure, void>> setSampleRate({
    required File inputFile,
    required File outputFile,
    required int sampleRate,
  }); // todo remove this  ffmpeg -y -i ip -af 'asetrate=sampling_rate_value'  op

  ///Adjust the input audio volume.
  ///Must be between 0 (no sound) and 100 (highest value, but output volume will be clipped to the maximum value)
  ///<br></br>
  ///If [outputFile] exists, then it will be overwritten.
  Future<Either<Failure, void>> setVolume({
    required File inputFile,
    required File outputFile,
    required double volume,
  }); //todo remove this  ffmpeg -y -i ip -af 'volume=volume_value'  op

  ///Reverses the audio.
  ///<br></br>
  ///If [outputFile] exists, then it will be overwritten.
  Future<Either<Failure, void>> reverseAudio({
    required File inputFile,
    required File outputFile,
  }); //todo remove this  ffmpeg -y -i ip -af 'areverse'  op
}
