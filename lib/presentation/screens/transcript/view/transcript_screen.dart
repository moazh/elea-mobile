import 'package:elea_mobile/common/bases/base_screen.dart';
import 'package:elea_mobile/common/bases/screen_status.dart';
import 'package:elea_mobile/domain/entity/record_file.dart';
import 'package:elea_mobile/injector.dart';
import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:elea_mobile/presentation/app_navigator.dart';
import 'package:elea_mobile/presentation/app_strings.dart';
import 'package:elea_mobile/presentation/screens/transcript/bloc/transcript_bloc.dart';
import 'package:elea_mobile/presentation/screens/transcript/bloc/transcript_event.dart';
import 'package:elea_mobile/presentation/screens/transcript/bloc/transcript_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// -----------------------------------------------------------------------------
// Screen
// -----------------------------------------------------------------------------
class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key});

  static Future bottomSheet({
    required BuildContext context,
    required RecordFile recordFile,
  }) =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (context) {
            return BlocProvider(
                create: (context) =>
                    TranscriptBloc(generateTranscript: injector())
                      ..add(GenerateTranscriptEvent(recordFile: recordFile)),
                child: Container(
                    color: AppColors.colorRed,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const TranscriptScreen()));
          });

  static Route<void> route({required RecordFile recordFile}) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
          create: (context) => TranscriptBloc(generateTranscript: injector())
            ..add(GenerateTranscriptEvent(recordFile: recordFile)),
          child: const TranscriptScreen());
    });
  }

  @override
  Widget build(BuildContext context) => const TranscriptView();
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class TranscriptView extends StatelessWidget {
  const TranscriptView({super.key});

  @override
  Widget build(BuildContext context) => const _Content();
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends BaseScreen<_Content> {
  String _transcript = "";

  @override
  Color? get backgroundColor => AppColors.colorGrayDark;

  @override
  Widget get body => BlocListener(
      bloc: context.watch<TranscriptBloc>(),
      listener: (context, dynamic state) {
        _onState(state);
      },
      child: _body());

  Widget _body() {
    final status = context.select((TranscriptBloc b) => b.state.status);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.all(AppDimens.mainPadding),
          child: Row(children: [
            const Spacer(),
            const Text(AppStrings.csTranscript,
                style: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: AppDimens.fontRegular,
                  fontWeight: FontWeight.w500,
                )),
            const Spacer(),
            CircleAvatar(
                maxRadius: AppDimens.iconSmall,
                backgroundColor: AppColors.colorGrayMid,
                child: IconButton(
                  iconSize: AppDimens.iconSmall,
                  icon:
                      const Icon(Icons.close, color: AppColors.colorGrayLight),
                  onPressed: () {
                    AppNavigator.toBack(context: context);
                  },
                ))
          ])),
      SingleChildScrollView(
          child: status == ScreenStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.colorWhite,
                ))
              : Padding(
                  padding: const EdgeInsets.all(AppDimens.mainPadding),
                  child: Text(
                    _transcript,
                    style: const TextStyle(color: AppColors.colorWhite),
                  )))
    ]);
  }

  void _updateTranscript({required String transcript}) {
    setState(() {
      _transcript = transcript;
    });
  }

  void _onState(TranscriptState state) {
    if (state is TranscriptGeneratedState) {
      _updateTranscript(transcript: state.transcript.text);
    }
  }
}
