import 'dart:math';

import 'package:flutter/material.dart';

class SkewShadowText extends StatefulWidget {
  @override
  _SkewShadowTextState createState() => _SkewShadowTextState();
}

class _SkewShadowTextState extends State<SkewShadowText>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 800);

  final TextStyle commonStyle = TextStyle(fontSize: 60, color: Colors.blue);
  final TextStyle shadowStyle =
      TextStyle(fontSize: 60, color: Colors.blue.withAlpha(88));
  String text = "张风捷特烈";


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
        child: Stack(
          children: [
            Text(text, style: commonStyle,),
            AnimatedBuilder(
              animation: _ctrl,
              builder: _buildByAnim,
            ),
          ],
        ));
  }

  double get rad => 6 * (_ctrl.value) / 180 * pi;

  Widget _buildByAnim(_, __) => Transform(
        transform: Matrix4.skewX(rad),
        child: Text(
          text,
          style: shadowStyle,
        ),
      );

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}
