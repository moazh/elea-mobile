import 'package:elea_mobile/common/bases/screen_status.dart';
import 'package:elea_mobile/domain/entity/record_file.dart';
import 'package:elea_mobile/domain/entity/transcript.dart';
import 'package:equatable/equatable.dart';

class TranscriptState extends Equatable {
  const TranscriptState({
    this.status = ScreenStatus.content,
  });

  final ScreenStatus status;

  TranscriptState copyWith({
    ScreenStatus? status,
    RecordFile? recordFile,
  }) {
    return TranscriptState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

class TranscriptGeneratedState extends TranscriptState {
  final Transcript transcript;

  const TranscriptGeneratedState({required this.transcript});
}
