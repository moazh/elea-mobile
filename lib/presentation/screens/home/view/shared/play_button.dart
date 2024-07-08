import 'package:elea_mobile/presentation/app_dimens.dart';
import 'package:flutter/material.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
    this.onPressed,
  });

  final Function(bool isPlaying)? onPressed;

  @override
  State<StatefulWidget> createState() => PlayButtonState();
}

class PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const _animationDuration = Duration(milliseconds: 100);
  bool _isPlaying = false;

  @override
  void initState() {
    _initAnimationController();
    super.initState();
  }

  void _initAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: AppDimens.iconLarge,
        icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause,
          progress: _controller,
        ),
        onPressed: () {
          setState(() {
            _isPlaying = !_isPlaying;
            _isPlaying ? _controller.forward() : _controller.reverse();
            widget.onPressed?.call(_isPlaying);
          });
        });
  }

  void stopPlaying() {
    setState(() {
      _isPlaying = false;
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
