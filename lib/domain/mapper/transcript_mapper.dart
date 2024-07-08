import 'package:elea_mobile/common/bases/base_mapper.dart';
import 'package:elea_mobile/data/dto/transcript_dto.dart';
import 'package:elea_mobile/domain/entity/transcript.dart';

class TranscriptMapper extends BaseMapper<TranscriptDto, Transcript> {
  @override
  mapFrom(type) {
    return Transcript(
      text: type?.text ?? "",
    );
  }
}
