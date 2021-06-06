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

  Animation<double> sequenceAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    )..addListener(_collectPoint);

    sequenceAnim = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0,end: 0.5).chain(CurveTween(curve: Curves.ease)),
          weight: 4.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.5),
          weight: 2.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.5,end: 1.0).chain(CurveTween(curve: Curves.decelerate)),
          weight: 4.0,
        ),
      ],
    ).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  void _collectPoint() {
    points.push(sequenceAnim.value);
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


