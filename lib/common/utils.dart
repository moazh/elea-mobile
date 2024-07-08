import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stream_transform/stream_transform.dart';

class Utils {
  static EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }
}

extension DurationFormatting on Duration {
  String formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension DateFormatting on DateTime {
  String formatRecordingDate() {
    return DateFormat('dd/MM/yyyy, HH:mm').format(this);
  }
}

extension MillisecondsDuration on int {
  String toDuration() {
    Duration duration = Duration(milliseconds: this);
    return duration.formatDuration();
  }
}

extension RecordingTimeFormating on Duration {
  String toRecordingTime() {
    String twoDigitHours = inHours.toString().padLeft(2, '0');
    String twoDigitMinutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    String twoDigitSeconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    String threeDigitMilliseconds =
        inMilliseconds.remainder(1000).toString().padLeft(3, '0');
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds:$threeDigitMilliseconds";
  }
}

extension UniqueIdGenerator on DateTime {
  static String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}