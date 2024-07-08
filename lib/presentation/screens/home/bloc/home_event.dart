import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class CheckMicPermissionEvent extends HomeEvent {
  const CheckMicPermissionEvent();
}

final class StartRecordingEvent extends HomeEvent {
  const StartRecordingEvent();
}

final class EndRecordingEvent extends HomeEvent {
  const EndRecordingEvent();
}

final class StartPlayingRecordEvent extends HomeEvent {
  const StartPlayingRecordEvent();
}

final class PausePlayingRecordEvent extends HomeEvent {
  const PausePlayingRecordEvent();
}

final class ForwardPlayingRecordEvent extends HomeEvent {
  const ForwardPlayingRecordEvent();
}

final class BackwardPlayingRecordEvent extends HomeEvent {
  const BackwardPlayingRecordEvent();
}
