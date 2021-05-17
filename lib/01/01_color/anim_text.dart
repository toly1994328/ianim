import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class AnimText extends StatefulWidget {
  @override
  _AnimTextState createState() => _AnimTextState();
}

class _AnimTextState extends State<AnimText>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  final TextStyle commonStyle = TextStyle(fontSize: 36, color: Colors.blue);
  final TextStyle shadowStyle =
      TextStyle(fontSize: 36, color: Colors.blue.withAlpha(88));
  String text = "张风捷特烈";

  double get rad => 360 * (_ctrl.value) / 180 * pi / 2;

  final List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  final List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];

  final Matrix4 matrix4 = Matrix4.rotationZ(pi / 6);

  Paint getGradientPaint(double sigma) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(100, 0),
      colors,
      pos,
      TileMode.mirror,
      matrix4.storage,
    );
    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, sigma);
    return paint;
  }

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
      ),
    );
  }

  Widget _buildByAnim(BuildContext context, Widget child) {
    // Matrix4 matrix4 = Matrix4.rotationZ(rad);

    // print("---$matrix4-----");
    return Text(
      text,
      style: TextStyle(fontSize: 36, foreground: getGradientPaint(rad)),
    );
  }

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}
