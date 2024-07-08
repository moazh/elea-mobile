import 'package:elea_mobile/data/source/local/storage.dart';
import 'package:elea_mobile/data/source/remote/api.dart';
import 'package:elea_mobile/domain/entity/transcript.dart';
import 'package:elea_mobile/domain/mapper/transcript_mapper.dart';

abstract class TranscriptRepository {
  Future<Transcript> generateTranscript({
    required String id,
    required String path,
  });
}

class TranscriptRepositoryImpl implements TranscriptRepository {
  final Api _api;
  final Storage _storage;
  final TranscriptMapper _mapper;

  TranscriptRepositoryImpl({
    required Api api,
    required Storage storage,
    required TranscriptMapper mapper,
  })  : _api = api,
        _storage = storage,
        _mapper = mapper;

  @override
  Future<Transcript> generateTranscript({
    required String id,
    required String path,
  }) async {
    final localTranscriptDto = _storage.getTranscript(id: id);
    if (localTranscriptDto != null) return _mapper.mapFrom(localTranscriptDto);
    final remoteTranscriptDto = await _api.generateTranscript(
      id: id,
      path: path,
    );
    await _storage.saveTranscript(id: id, transcriptDto: remoteTranscriptDto);
    return _mapper.mapFrom(remoteTranscriptDto);
  }
}
