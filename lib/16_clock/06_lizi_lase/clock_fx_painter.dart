import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'clock_fx.dart';
import 'particle.dart';

/// Where handles should start, denoted in percentage of full radius.
const double handlesStart = .1;

/// Where noise should start, denoted in percentage of full radius.
const double noiseStart = .15;

/// Alpha value for noise particles.
const double noiseAlpha = 160;

class ClockFxPainter extends CustomPainter {
  ClockFx fx;

  // ChangeNotifier used as repaint notifier.
  ClockFxPainter({@required this.fx}) : super(repaint: fx);

  @override
  void paint(Canvas canvas, Size size) {
    fx.particles.forEach((p) {
      double a;

      a = max(0.0, (p.distFrac - .13) / p.distFrac) * 255;
      a = min(a, min(noiseAlpha, p.lifeLeft * 3 * 255));

      var alpha = a.floor();

      var circlePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = p.size / 4
        ..color = p.color.withAlpha(alpha);

      var particlePosition = Offset(p.x, p.y);

      circlePaint.style = PaintingStyle.fill;
      canvas.drawCircle(particlePosition, p.size, circlePaint);
    });
  }

  @override
  bool shouldRepaint(_) => true;
}
