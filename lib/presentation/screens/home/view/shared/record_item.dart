import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:elea_mobile/common/utils.dart';
import 'package:elea_mobile/domain/entity/record_file.dart';
import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:elea_mobile/presentation/app_strings.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_bloc.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_event.dart';
import 'package:elea_mobile/presentation/screens/home/view/shared/play_button.dart';
import 'package:elea_mobile/presentation/screens/transcript/view/transcript_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordItem extends StatefulWidget {
  const RecordItem({
    super.key,
    required this.recordFile,
  });

  final RecordFile recordFile;

  @override
  State<StatefulWidget> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  HomeBloc get homeBloc => context.read<HomeBloc>();

  String _progressingDuration = '00:00';
  final _playButtonKey = GlobalKey<PlayButtonState>();

  @override
  void initState() {
    _syncProgressingDuration();
    _syncPlayButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: AppColors.colorTransparent,
        ),
        child: ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            iconColor: AppColors.colorWhite,
            collapsedIconColor: AppColors.colorWhite,
            title: const Text(AppStrings.titleNewRecording,
                style: TextStyle(color: AppColors.colorWhite)),
            subtitle: Text(
              widget.recordFile.createdAt,
              style: const TextStyle(color: AppColors.colorGrayLight),
            ),
            children: [
              IconButton(
                  iconSize: AppDimens.iconMedium,
                  icon: const Icon(Icons.wrap_text_outlined),
                  onPressed: () {
                    TranscriptScreen.bottomSheet(
                      context: context,
                      recordFile: homeBloc.state.recordFile!,
                    );
                  }),
              const SizedBox(height: AppDimens.mainMargin),
              AudioFileWaveforms(
                  size: Size(MediaQuery.of(context).size.width, 100),
                  playerController: homeBloc.playerController,
                  enableSeekGesture: true,
                  waveformType: WaveformType.fitWidth,
                  playerWaveStyle: const PlayerWaveStyle(
                    fixedWaveColor: AppColors.colorGrayLight,
                    liveWaveColor: AppColors.colorWhite,
                    spacing: 6,
                  )),
              // Text(homeBloc.playerController.currentScrolledDuration)
              Row(
                children: [
                  const SizedBox(width: AppDimens.mainMargin),
                  Text(
                    _progressingDuration,
                    style: const TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.colorWhite),
                  ),
                  const Spacer(),
                  Text(
                    widget.recordFile.duration,
                    style: const TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.colorWhite),
                  ),
                  const SizedBox(width: AppDimens.mainMargin)
                ],
              ),
              const SizedBox(height: AppDimens.mainMargin),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                    iconSize: AppDimens.iconMedium,
                    icon: const Icon(Icons.replay_10),
                    onPressed: () {
                      homeBloc.add(const BackwardPlayingRecordEvent());
                    }),
                PlayButton(
                  key: _playButtonKey,
                  onPressed: (bool isPlaying) {
                    isPlaying
                        ? homeBloc.add(const StartPlayingRecordEvent())
                        : homeBloc.add(const PausePlayingRecordEvent());
                  },
                ),
                IconButton(
                    iconSize: AppDimens.iconMedium,
                    icon: const Icon(Icons.forward_10),
                    onPressed: () {
                      homeBloc.add(const ForwardPlayingRecordEvent());
                    })
              ]),
              Container(
                color: AppColors.colorGrayMid,
                width: MediaQuery.of(context).size.width,
                height: AppDimens.divider.height,
              )
            ]));
  }

  void _syncProgressingDuration() {
    //TODO dispose listener
    homeBloc.playerController.onCurrentDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _progressingDuration = duration.toDuration();
        });
      }
    });
  }

  void _syncPlayButton() {
    //TODO dispose listener
    homeBloc.playerController.onCompletion.listen((_) {
      _playButtonKey.currentState?.stopPlaying();
      setState(() {
        _progressingDuration = '00:00';
      });
    });
  }
}
