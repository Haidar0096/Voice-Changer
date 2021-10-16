import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';

abstract class RecordingDetailsService {
  ///Returns the details of the provided recording fiel
  Future<Either<Failure, RecordingDetails>> getRecordingDetails(
      File recordingFile);
}

class RecordingDetails {
  final String name;
  final String path;

  ///The duration of the recording, or null if unavailable
  final Duration? duration;

  RecordingDetails({
    required this.name,
    required this.path,
    required this.duration,
  });

  @override
  String toString() {
    return 'RecordingDetails{name: $name, path: $path, duration: $duration}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordingDetails &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          path == other.path &&
          duration == other.duration;

  @override
  int get hashCode => name.hashCode ^ path.hashCode ^ duration.hashCode;
}
