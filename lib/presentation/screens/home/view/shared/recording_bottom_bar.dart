import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:elea_mobile/common/utils.dart';
import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:elea_mobile/presentation/app_strings.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_bloc.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_event.dart';
import 'package:elea_mobile/presentation/screens/home/view/shared/record_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingBottomBar extends StatefulWidget {
  const RecordingBottomBar({super.key, this.onChanged});

  final Function(String path)? onChanged;

  @override
  State<StatefulWidget> createState() => _RecordingBottomBarState();
}

class _RecordingBottomBarState extends State<RecordingBottomBar> {
  bool _isRecording = false;
  String _elapsedTime = "00:00:00:000";

  HomeBloc get homeBloc => context.read<HomeBloc>();

  @override
  void initState() {
    _updateDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.colorGrayDark,
        child: Column(children: [
          SizedBox(
              height: _isRecording ? null : 0,
              child: Column(children: [
                const SizedBox(height: AppDimens.mainMargin),
                const Text(AppStrings.titleNewRecording,
                    style: TextStyle(
                      color: AppColors.colorWhite,
                      fontSize: AppDimens.fontRegular,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: AppDimens.mainMargin),
                Text(
                  _elapsedTime,
                  style: const TextStyle(color: AppColors.colorWhite),
                ),
                const SizedBox(height: AppDimens.mainMargin),
                AudioWaveforms(
                    enableGesture: true,
                    size: Size(MediaQuery.of(context).size.width, 50),
                    recorderController: homeBloc.recorderController,
                    waveStyle: const WaveStyle(
                      waveColor: AppColors.colorRed,
                      extendWaveform: true,
                      showMiddleLine: false,
                    )),
                const SizedBox(height: AppDimens.mainMargin)
              ])),
          Padding(
              padding: const EdgeInsets.all(AppDimens.xlMargin),
              child: RecordButton(onChanged: (bool isRecording) {
                setState(() {
                  _isRecording
                      ? homeBloc.add(const EndRecordingEvent())
                      : homeBloc.add(const StartRecordingEvent());
                  _isRecording = isRecording;
                });
              }))
        ]));
  }

  void _updateDuration() {
    //TODO dispose listener
    homeBloc.recorderController.onCurrentDuration.listen((duration) {
      setState(() {
        _elapsedTime = duration.toRecordingTime();
      });
    });
  }
}
