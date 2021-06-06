import 'package:flutter/material.dart';

import 'circle.dart';

class CircleAnim extends StatefulWidget {
  @override
  _CircleAnimState createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 500);

  final TextStyleTween tween = TextStyleTween(
      begin: TextStyle(color: Colors.blue, fontSize: 14, letterSpacing: 4,),
      end: TextStyle(color: Colors.purple, fontSize: 40, letterSpacing: 10,));

  Animation<TextStyle> textAnimation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    );
    textAnimation = tween.animate(_ctrl);
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
        child: Center(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: _buildByAnim,
          ),
        ));
  }

  Widget _buildByAnim(_, __) =>  Text(
      "张风捷特烈",style: textAnimation.value,
  );

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}
