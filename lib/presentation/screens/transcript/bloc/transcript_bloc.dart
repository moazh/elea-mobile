import 'package:elea_mobile/common/bases/screen_status.dart';
import 'package:elea_mobile/common/utils.dart';
import 'package:elea_mobile/domain/usecase/generate_transcript.dart';
import 'package:elea_mobile/presentation/screens/transcript/bloc/transcript_event.dart';
import 'package:elea_mobile/presentation/screens/transcript/bloc/transcript_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranscriptBloc extends Bloc<TranscriptEvent, TranscriptState> {
  TranscriptBloc({
    required GenerateTranscript generateTranscript,
  })  : _generateTranscript = generateTranscript,
        super(const TranscriptState()) {
    on<GenerateTranscriptEvent>(
      _sendAndGenerateTranscript,
      transformer: Utils.throttleDroppable(const Duration(milliseconds: 100)),
    );
  }

  final GenerateTranscript _generateTranscript;

  Future<void> _sendAndGenerateTranscript(
      GenerateTranscriptEvent event, Emitter<TranscriptState> emit) async {
    emit(state.copyWith(status: ScreenStatus.loading));

    final transcript = await _generateTranscript(
      id: event.recordFile.id,
      path: event.recordFile.path,
    );
    emit(TranscriptGeneratedState(transcript: transcript));
    emit(state.copyWith(status: ScreenStatus.content));
  }
}
