import 'package:elea_mobile/domain/entity/record_file.dart';
import 'package:equatable/equatable.dart';

sealed class TranscriptEvent extends Equatable {
  const TranscriptEvent();

  @override
  List<Object?> get props => [];
}

final class GenerateTranscriptEvent extends TranscriptEvent {
  final RecordFile recordFile;

  const GenerateTranscriptEvent({required this.recordFile});
}
