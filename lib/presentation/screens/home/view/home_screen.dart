import 'package:elea_mobile/common/alert_builder.dart';
import 'package:elea_mobile/common/bases/base_screen.dart';
import 'package:elea_mobile/common/bases/screen_status.dart';
import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:elea_mobile/presentation/app_strings.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_bloc.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_event.dart';
import 'package:elea_mobile/presentation/screens/home/bloc/home_state.dart';
import 'package:elea_mobile/presentation/screens/home/view/shared/record_item.dart';
import 'package:elea_mobile/presentation/screens/home/view/shared/recording_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

// -----------------------------------------------------------------------------
// Screen
// -----------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => HomeBloc(
            context: context,
          )..add(const CheckMicPermissionEvent()),
      child: const HomeView());
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
  @override
  Widget get appBar => AppBar(backgroundColor: AppColors.colorBlack);

  HomeBloc get homeBloc => context.read<HomeBloc>();

  @override
  Widget get body => BlocListener(
      bloc: context.watch<HomeBloc>(),
      listener: (context, dynamic state) {
        _onState(state);
      },
      child: _body());

  Widget _body() {
    final status = context.select((HomeBloc b) => b.state.status);
    final recordFile = context.select((HomeBloc b) => b.state.recordFile);
    return Column(
      children: [
        status == ScreenStatus.loading
            ? const Expanded(
                child: Center(
                    child: CircularProgressIndicator(
                  color: AppColors.colorWhite,
                )),
              )
            : Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: AppDimens.mainMargin,
                            right: AppDimens.mainMargin,
                            bottom: AppDimens.mainMargin),
                        child: const Text(AppStrings.titleAllRecordings,
                            style: TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: AppDimens.fontLarge,
                              fontWeight: FontWeight.w800,
                            ))),
                    if (recordFile != null) RecordItem(recordFile: recordFile),
                  ]))),
        RecordingBottomBar(onChanged: (path) {})
      ],
    );
  }

  Future<void> _showPermissionDenied() => AlertBuilder.showAlert(
      context: context,
      title: AppStrings.titlePermissionDenied,
      content: AppStrings.msgPermissionDenied,
      actionsBuilder: (context) => [
            AlertBuilder.defaultButton(context, AppStrings.btRetry,
                onPressed: () {
              _checkMicPermission();
            })
          ]);

  Future<void> _showPermissionPermanentlyDenied() => AlertBuilder.showAlert(
      context: context,
      title: AppStrings.titlePermissionDenied,
      content: AppStrings.msgPermissionPermanentlyDenied,
      actionsBuilder: (context) => [
            AlertBuilder.defaultButton(context, AppStrings.btSettings,
                onPressed: () {
              openAppSettings();
            })
          ]);

  void _checkMicPermission() {
    homeBloc.add(const CheckMicPermissionEvent());
  }

  void _onState(HomeState state) {
    switch (state.runtimeType) {
      case const (PermissionDeniedState):
        _showPermissionDenied();
        break;
      case const (PermissionPermanentlyDeniedState):
        _showPermissionPermanentlyDenied();
        break;
    }
  }
}
