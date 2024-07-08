import 'dart:convert';

class TranscriptDto {
  TranscriptDto({
    this.text,
    this.id,
  });

  final String? text;
  final String? id;

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory TranscriptDto.fromJson(String str) =>
      TranscriptDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Map
  // ---------------------------------------------------------------------------
  factory TranscriptDto.fromMap(Map<String, dynamic> json, {String? id}) =>
      TranscriptDto(
        text: json['text'],
        id: json['id'] ?? id,
      );

  Map<String, dynamic> toMap() => {
        'text': text,
        'id': id,
      };
}
