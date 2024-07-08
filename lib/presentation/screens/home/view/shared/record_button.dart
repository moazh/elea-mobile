import 'package:elea_mobile/presentation/app_colors.dart';
import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:flutter/material.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({
    super.key,
    this.onChanged,
  });

  final Function(bool isRecording)? onChanged;

  @override
  State<StatefulWidget> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  static const _animationDuration = Duration(milliseconds: 200);
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onRecordButtonPressed,
        child: Container(
            width: AppDimens.recordButtonContainer.width,
            height: AppDimens.recordButtonContainer.height,
            decoration: const BoxDecoration(
              color: AppColors.colorWhite,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: _animationDuration,
                    width: _isRecording
                        ? AppDimens.recordButtonSquare.width
                        : AppDimens.recordButtonCircle.width,
                    height: _isRecording
                        ? AppDimens.recordButtonSquare.height
                        : AppDimens.recordButtonCircle.height,
                    decoration: BoxDecoration(
                      color: AppColors.colorRed,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(
                        _isRecording
                            ? AppDimens.recordButtonCorner
                            : AppDimens.recordButtonFullCorner,
                      ), // Rounded corners
                    )))));
  }

  void _onRecordButtonPressed() {
    setState(() {
      _isRecording = !_isRecording;
    });
    widget.onChanged?.call(_isRecording);
  }
}
