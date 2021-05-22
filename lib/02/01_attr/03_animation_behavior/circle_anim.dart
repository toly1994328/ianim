import 'package:flutter/material.dart';

class CircleAnim extends StatefulWidget {
  @override
  _CircleAnimState createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
      animationBehavior: AnimationBehavior.preserve
    );
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
        ));
  }

  double get radius => 32 + (80 - 32) * _ctrl.value;

  Widget _buildByAnim(_, __) => Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      );

  void _startAnim() {
    _ctrl.forward();
  }
}
