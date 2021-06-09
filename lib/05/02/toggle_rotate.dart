library toggle_rotate;

import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRotate extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool> onEnd;
  final VoidCallback onTap;
  final double beginAngle;
  final double endAngle;
  final int durationMs;
  final bool clockwise;
  final Curve curve;

  ToggleRotate({
    @required this.child,
    this.onTap,
    this.onEnd,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.clockwise = true,
    this.durationMs = 200,
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  _ToggleRotateState createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate>
    with SingleTickerProviderStateMixin {
  bool _rotated = false;
  AnimationController _controller;
  Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.durationMs), vsync: this);
    _initTweenAnim();
  }

  void _initTweenAnim() {
    _rotateAnim = Tween<double>(
            begin: widget.beginAngle / 180 * pi,
            end: widget.endAngle / 180 * pi)
        .chain(CurveTween(curve: widget.curve))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(ToggleRotate oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.durationMs != oldWidget.durationMs) {
      _controller.dispose();
      _controller = AnimationController(
          duration: Duration(milliseconds: widget.durationMs), vsync: this);
    }
    if (widget.beginAngle != oldWidget.beginAngle ||
        widget.endAngle != oldWidget.endAngle ||
        widget.curve != oldWidget.curve ||
        widget.durationMs != oldWidget.durationMs) {
      _initTweenAnim();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get rad => widget.clockwise ? _rotateAnim.value : -_rotateAnim.value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onTap?.call();
        if (_rotated) {
          await _controller.reverse();
        } else {
          await _controller.forward();
        }
        _rotated = !_rotated;
        widget.onEnd?.call(_rotated);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Transform(
          transform: Matrix4.rotationZ(rad),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
