import 'package:elea_mobile/data/dto/transcript_dto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedCharacterListKey = 'CACHED_TRANSCRIPT';

abstract class Storage {
  Future<bool> saveTranscript({
    required String id,
    TranscriptDto? transcriptDto,
  });

  TranscriptDto? getTranscript({required String id});
}

class StorageImpl implements Storage {
  StorageImpl({
    required SharedPreferences sharedPref,
  }) : _sharedPref = sharedPref;

  final SharedPreferences _sharedPref;

  @override
  Future<bool> saveTranscript({
    TranscriptDto? transcriptDto,
    required String id,
  }) {
    if (transcriptDto == null) return Future.value(false);
    final jsonData = transcriptDto.toJson();
    final key = getKeyToTranscript(id);
    return _sharedPref.setString(key, jsonData);
  }

  @override
  TranscriptDto? getTranscript({required String id}) {
    final key = getKeyToTranscript(id);
    final jsonData = _sharedPref.getString(key);
    return jsonData != null ? TranscriptDto.fromJson(jsonData) : null;
  }

  @visibleForTesting
  static String getKeyToTranscript(String id) {
    return '${cachedCharacterListKey}_$id';
  }
}
