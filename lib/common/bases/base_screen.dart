import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseScreen<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  Widget? get appBar => null;

  Widget? get body => null;

  @override
  bool get wantKeepAlive => true;

  Color? get backgroundColor => AppColors.colorBlack;

  String? get debugLabel => null;

  @override
  Widget build(BuildContext context) {
    debugPrint("$runtimeType Launched or Recreated]");
    super.build(context);
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar as PreferredSizeWidget?,
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: body ?? Container(),
        ));
  }
}
