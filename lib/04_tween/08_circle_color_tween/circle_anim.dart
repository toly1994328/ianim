import 'package:flutter/material.dart';

import 'circle.dart';

class CircleAnim extends StatefulWidget {
  @override
  _CircleAnimState createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  final CircleTween tween = CircleTween(
      begin: Circle(center: Offset.zero, radius: 25, color: Colors.blue),
      end: Circle(center: Offset(100, 0), radius: 50, color: Colors.red));

  Animation<Circle> circleAnimation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    );
    circleAnimation = tween.animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
        onTap: _startAnim,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: _buildByAnim,
        ));
  }

  Widget _buildByAnim(_, __) =>CircleWidget(
    circle: circleAnimation.value,
  );

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}

class CircleWidget extends StatelessWidget {
  final Circle circle;
  const CircleWidget({Key key,@required this.circle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(circle.center.dx,
          circle.center.dy, 0),
      width: circle.radius * 2,
      height: circle.radius * 2,
      decoration: BoxDecoration(
          color: circle.color, shape: BoxShape.circle),
    );
  }
}
