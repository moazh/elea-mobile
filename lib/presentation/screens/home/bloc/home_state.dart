import 'package:elea_mobile/common/bases/screen_status.dart';
import 'package:elea_mobile/domain/entity/record_file.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = ScreenStatus.content,
    this.recordFile,
    this.isMicPermissionGranted = false,
  });

  final ScreenStatus status;
  final RecordFile? recordFile;
  final bool isMicPermissionGranted;

  HomeState copyWith({
    ScreenStatus? status,
    RecordFile? recordFile,
    bool? isMicPermissionGranted,
  }) {
    return HomeState(
      status: status ?? this.status,
      recordFile: recordFile,
      isMicPermissionGranted:
          isMicPermissionGranted ?? this.isMicPermissionGranted,
    );
  }

  @override
  List<Object> get props => [status, isMicPermissionGranted];
}

class PermissionGrantedState extends HomeState {
  const PermissionGrantedState() : super(isMicPermissionGranted: true);
}

class PermissionDeniedState extends HomeState {
  const PermissionDeniedState() : super(isMicPermissionGranted: false);
}

class PermissionPermanentlyDeniedState extends HomeState {
  const PermissionPermanentlyDeniedState()
      : super(isMicPermissionGranted: false);
}

class LoadingState extends HomeState {
  const LoadingState() : super(status: ScreenStatus.loading);
}

class RecordingStartedState extends HomeState {
  const RecordingStartedState();
}

class RecordingEndedState extends HomeState {
  const RecordingEndedState();
}
