import 'package:dio/dio.dart';
import 'package:elea_mobile/data/dto/transcript_dto.dart';
import 'package:flutter/cupertino.dart';

abstract class Api {
  Future<TranscriptDto?> generateTranscript({
    required String id,
    required String path,
  });
}

class ApiImpl implements Api {
  final dio = Dio();

  static const String apiKey = '';
  static const String model = 'whisper-1';
  static const String baseUrl =
      'https://api.openai.com/v1/audio/transcriptions';

  @override
  Future<TranscriptDto?> generateTranscript({
    required String id,
    required String path,
  }) async {
    dio.options.headers['Authorization'] = 'Bearer $apiKey';
    dio.options.headers['Content-Type'] = 'multipart/form-data';

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path),
      'model': model,
    });

    try {
      final response = await dio.post(
        baseUrl,
        data: formData,
      );
      debugPrint('Data: ${response.data}');
      return TranscriptDto.fromMap(response.data, id: id);
    } on DioException catch (e) {
      debugPrint('Error: ${e.response?.data ?? e.message}');
    }
    return null;
  }
}
