import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui ;

class CircleHalo extends StatefulWidget {

  const CircleHalo({Key key}) : super(key: key);

  @override
  _CircleHaloState createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
        size: Size(200, 200),
        painter: CircleHaloPainter(_ctrl),
    );
  }
}

class CircleHaloPainter extends CustomPainter {
  Animation<double> animation;

  CircleHaloPainter(this.animation) : super(repaint: animation);

  final Animatable<double> breatheTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 4),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 4, end: 0),
        weight: 1,
      ),
    ],
  ).chain(CurveTween(curve: Curves.decelerate));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;


    Path circlePath = Path()
      ..addOval(Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));

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


    paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
