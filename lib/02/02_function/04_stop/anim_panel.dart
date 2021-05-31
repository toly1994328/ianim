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
    )..addListener(_collectPoint)..addStatusListener(_listenStatus);
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

  void _listenStatus(AnimationStatus status){
    // print(status);
    // if(status == AnimationStatus.reverse){
    //   points.clear();
    // }
  }

  void _startAnim() async{
    points.clear();
    Timer(Duration(milliseconds: 1500),_stop);
    print('start!---${DateTime.now().toIso8601String()}----------');
     _ctrl.repeat(reverse: true).orCancel.then((v) {
       print('cancel!---${DateTime.now().toIso8601String()}----------');
     },onError: (e){
       print('cancel!---$e----------');
     });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      onDoubleTap: _restartAnim,
      child: CustomPaint(
        painter: AnimPainter(points),
        size: const Size(
          400,
          200,
        ),
      ),
    );
  }

  void _stop() {
    _ctrl.stop(canceled: true);
  }

  void _restartAnim() {
    _ctrl.reverse();
  }
}


