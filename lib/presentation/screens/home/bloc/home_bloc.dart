import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:elea_mobile/common/bases/screen_status.dart';
import 'package:elea_mobile/common/permission_handler.dart';
import 'package:elea_mobile/common/recording_handler.dart';
import 'package:elea_mobile/common/utils.dart';
import 'package:elea_mobile/domain/entity/record_file.dart';
import 'package:elea_mobile/injector.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_event.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required BuildContext context})
      : _context = context,
        super(const HomeState()) {
    _recordingHandler = injector();

    on<CheckMicPermissionEvent>(_checkMicPermission);
    on<StartRecordingEvent>(_startRecording);
    on<EndRecordingEvent>(_endRecording);
    on<StartPlayingRecordEvent>(_startPlaying);
    on<PausePlayingRecordEvent>(_pausePlaying);
    on<ForwardPlayingRecordEvent>(_forwardPlaying);
    on<BackwardPlayingRecordEvent>(_backwardPlaying);
  }

  final BuildContext _context;
  late final RecordingHandler _recordingHandler;
  RecordFile? recordFile;

  RecorderController get recorderController =>
      _recordingHandler.recorderController;

  PlayerController get playerController => _recordingHandler.playerController;

  Future<void> _checkMicPermission(event, Emitter<HomeState> emit) async {
    await PermissionHandler.checkMicPermission(
      context: _context,
      onGranted: () {
        emit(const PermissionGrantedState());
      },
      onDenied: () {
        emit(const PermissionDeniedState());
      },
      onPermanentlyDenied: () {
        emit(const PermissionPermanentlyDeniedState());
      },
    );
    emit(state.copyWith(status: ScreenStatus.content));
  }

  Future<void> _startRecording(event, Emitter<HomeState> emit) async {
    await _checkMicPermission(null, emit);
    if (!state.isMicPermissionGranted) return;
    await _recordingHandler.startRecording();
    emit(const RecordingStartedState());
    emit(state.copyWith(status: ScreenStatus.content));
  }

  Future<void> _endRecording(event, Emitter<HomeState> emit) async {
    await _recordingHandler.endRecording().then((path) async {
      if (path != null) {
        recordFile = RecordFile(
          id: UniqueIdGenerator.generateUniqueId(),
          path: path,
          createdAt: DateTime.now().formatRecordingDate(),
          duration: recorderController.recordedDuration.formatDuration(),
        );
        emit(const LoadingState());
        await Future.delayed(const Duration(milliseconds: 500));
        debugPrint("Recording completed");
      }
    });
    emit(const RecordingEndedState());
    emit(state.copyWith(status: ScreenStatus.content, recordFile: recordFile));
  }

  Future<void> _startPlaying(event, Emitter<HomeState> emit) async {
    await _recordingHandler.play();
  }

  Future<void> _pausePlaying(event, Emitter<HomeState> emit) async {
    await _recordingHandler.pause();
  }

  Future<void> _forwardPlaying(event, Emitter<HomeState> emit) async {
    await _recordingHandler.forward();
  }

  Future<void> _backwardPlaying(event, Emitter<HomeState> emit) async {
    await _recordingHandler.backward();
  }

  @override
  Future<void> close() {
    _recordingHandler.dispose();
    return super.close();
  }
}
