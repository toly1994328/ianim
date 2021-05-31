import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'anim_painter.dart';
import 'point_data.dart';

class AnimPanel extends StatefulWidget {
  @override
  _AnimPanelState createState() => _AnimPanelState();
}

class _AnimPanelState extends State<AnimPanel>
    with SingleTickerProviderStateMixin {

  PointData points = PointData();
  AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    )..addListener(_collectPoint);
    // curve = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  void _collectPoint() {
    points.push(_ctrl.value);
  }


  void _startAnim() async{
    points.clear();
    print('fling start!---${DateTime.now().toIso8601String()}----------');
    await _ctrl.fling(
      velocity: 10
    );
    print('fling end!---${DateTime.now().toIso8601String()}----------');

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


