import 'dart:math';

import 'package:flutter/material.dart';

class AnimText extends StatefulWidget {
  @override
  _AnimTextState createState() => _AnimTextState();
}

class _AnimTextState extends State<AnimText>
    with SingleTickerProviderStateMixin {

  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 800);

  final TextStyle commonStyle =  TextStyle(fontSize: 36, color: Colors.blue);
  final TextStyle shadowStyle = TextStyle(fontSize: 36, color: Colors.blue.withAlpha(88));
  String text = "张风捷特烈";

  double get rad => 6*(_ctrl.value)/ 180 * pi;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: _buildByAnim,
        child: Text(
          text,
          style: commonStyle,
        ),
      ),
    );
  }

  Widget _buildByAnim(BuildContext context, Widget child) {
    Matrix4 matrix4 = Matrix4.skewX(rad);
    return Stack(
      children: [
        child,
        Transform(
          transform: matrix4,
          child: Text(
            text,
            style: shadowStyle,
          ),
        ),
      ],
    );
  }

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}
