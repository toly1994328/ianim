import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:ianim/02/02_function/06_fling_spring/spring_painter.dart';

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
      upperBound: 100,
      lowerBound: 50
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
    _ctrl.reset();
    print('fling start!---${DateTime.now().toIso8601String()}----------');
    await _ctrl.fling(
      velocity: 10,
      springDescription: SpringDescription.withDampingRatio(
        mass: 1.0,
        stiffness: 1000.0,
        ratio: 3.0,
      )
    );
    print('fling end!---${DateTime.now().toIso8601String()}----------');

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(
            painter: SpringPainter(height: _ctrl)),
      ),
    );
  }
}


