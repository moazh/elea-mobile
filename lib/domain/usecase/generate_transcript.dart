import 'package:elea_mobile/domain/entity/transcript.dart';
import 'package:elea_mobile/domain/repository/transcript_repository.dart';

class GenerateTranscript {
  GenerateTranscript({
    required TranscriptRepository repository,
  }) : _repository = repository;

  final TranscriptRepository _repository;

  Future<Transcript> call({required String id, required String path}) async {
    final transcript = await _repository.generateTranscript(id: id,path: path);
    return transcript;
  }
}
