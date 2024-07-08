import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:elea_mobile/presentation/app_navigator.dart';
import 'package:elea_mobile/presentation/app_strings.dart';
import 'package:flutter/material.dart';

class AlertBuilder {
  static Widget defaultButton(
    BuildContext context,
    String text, {
    Function? onPressed,
  }) {
    return ElevatedButton(
        onPressed: () {
          AppNavigator.toBack(context: context);
          onPressed?.call();
        },
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.colorWhite),
            backgroundColor: WidgetStateProperty.all(AppColors.colorGrayMid),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.mainCorner)))),
        child: Text(text));
  }

  static Future<T?> showAlert<T>({
    required BuildContext context,
    required String title,
    required String content,
    List<Widget> Function(BuildContext)? actionsBuilder,
    bool dismissOnTapOutside = false,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: dismissOnTapOutside,
        builder: (context) {
          var actions = [defaultButton(context, AppStrings.btOk)];
          if (actionsBuilder != null) {
            actions = actionsBuilder(context);
          }
          return Theme(
              data: ThemeData(
                  buttonBarTheme: const ButtonBarThemeData(
                      alignment: MainAxisAlignment.spaceAround)),
              child: AlertDialog(
                  contentPadding: const EdgeInsets.only(
                    left: AppDimens.xPadding,
                    right: AppDimens.xPadding,
                    top: AppDimens.mainPadding,
                    bottom: AppDimens.mainPadding,
                  ),
                  backgroundColor: AppColors.colorGrayDark,
                  title: Container(
                      margin: const EdgeInsets.only(top: AppDimens.mMargin),
                      child: Text(title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: AppDimens.fontRegular,
                              color: AppColors.colorWhite))),
                  content: Text(content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: AppDimens.fontRegular,
                          color: AppColors.colorWhite)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.mainCorner),
                  ),
                  actionsAlignment: actions.length == 2
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  actionsPadding: const EdgeInsets.only(
                    left: AppDimens.xPadding,
                    right: AppDimens.xPadding,
                    bottom: AppDimens.xPadding,
                  ),
                  actions: actions));
        });
  }
}
