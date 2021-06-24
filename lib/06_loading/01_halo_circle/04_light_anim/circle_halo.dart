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

    paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));

    final Path circlePath = Path()..addOval(
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));

    Path circlePath2 = Path()..addOval(
        Rect.fromCenter(center: Offset(-1, 0), width: 100, height: 100));

    Path result = Path.combine(PathOperation.difference, circlePath, circlePath2);

    canvas.save();
    canvas.rotate(animation.value * 2 * pi);
    paint..style = PaintingStyle.fill..color = Color(0xff00abf2);
    canvas.drawPath(result, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
