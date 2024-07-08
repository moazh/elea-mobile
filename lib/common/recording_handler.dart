import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class RecordingHandler {
  factory RecordingHandler() {
    return _cache ?? RecordingHandler._internal();
  }

  RecordingHandler._internal() {
    _initRecordController();
    _cache = this;
  }

  static RecordingHandler? _cache;

  final RecorderController recorderController = RecorderController();
  final PlayerController playerController = PlayerController();

  static const _sampleRate = 44100;
  static const _oneSecondDuration = Duration(seconds: 1);

  Timer? _timer;
  Duration _elapsedTime = Duration.zero;
  String? _path;

  Future<void> _initPlayerController() async {
    await playerController.preparePlayer(
      path: _path ?? "",
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }

  void _initRecordController() {
    recorderController
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = _sampleRate;
  }

  void _startTimer() {
    _timer = Timer.periodic(_oneSecondDuration, (_) {
      _elapsedTime = _elapsedTime + _oneSecondDuration;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _elapsedTime = Duration.zero;
  }

  Future<void> startRecording() async {
    try {
      await recorderController.record(path: _path);
      _startTimer();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> endRecording() async {
    try {
      recorderController.reset();
      _stopTimer();
      _path = await recorderController.stop(false);
      if (_path != null) {
        debugPrint(_path);
        debugPrint("Recorded file size: ${File(_path!).lengthSync()}");
        _initPlayerController();
        return _path;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> play() async {
    await playerController.startPlayer(finishMode: FinishMode.pause);
  }

  Future<void> pause() async {
    await playerController.pausePlayer();
  }

  Future<void> forward() async {
    await playerController.seekTo(10000);
  }

  Future<void> backward() async {
    //TODO: Fix backward seek
    await playerController.seekTo(-10000);
  }

  Future<void> stop() async {
    await playerController.stopPlayer();
  }

  void dispose() {
    _timer?.cancel();
    recorderController.dispose();
    playerController.dispose();
  }
}
