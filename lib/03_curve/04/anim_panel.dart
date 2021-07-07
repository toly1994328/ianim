import 'dart:ui';

import 'package:flutter/material.dart';

import 'anim_painter.dart';
import 'point_data.dart';
import 'toly_curve.dart';

class AnimPanel extends StatefulWidget {
  @override
  _AnimPanelState createState() => _AnimPanelState();
}

class _AnimPanelState extends State<AnimPanel>
    with SingleTickerProviderStateMixin {
  PointData points = PointData();

  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  Animation<double> curveAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    )..addListener(_collectPoint);
    // curveAnim = CurvedAnimation(parent: _ctrl, curve: const X2Curve());
    curveAnim = CurvedAnimation(parent: _ctrl, curve: const DampingCurve());

  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  void _collectPoint() {
    points.push(curveAnim.value);
  }

  void _startAnim() async{
    points.clear();
    print('start!---${DateTime.now().toIso8601String()}----------');
    // await _ctrl.forward(from: 0);
    await _ctrl.forward(from: 0);
    print('done!---${DateTime.now().toIso8601String()}----------');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: CustomPaint(
        painter: AnimPainter(points),
        size: const Size(
          200,
          200,
        ),
      ),
    );
  }
}


