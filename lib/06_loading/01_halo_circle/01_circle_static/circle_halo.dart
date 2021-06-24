import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CircleHalo extends StatefulWidget {
  const CircleHalo({Key key}) : super(key: key);

  @override
  _CircleHaloState createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: CircleHaloPainter(),
    );
  }
}

class CircleHaloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    List<Color> colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    colors.addAll(colors.reversed.toList());
    final List<double> pos = List.generate(colors.length, (index) => index / colors.length);

    paint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, 0, 2 * pi);

    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 4);

    final Path circlePath = Path();

    circlePath.addOval(
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
