import 'package:flutter/cupertino.dart';

class Circle {
  final Color color;
  final double radius;
  final Offset center;

  Circle({this.color, this.radius, this.center});
}

class CircleTween extends Tween<Circle> {
  CircleTween({Circle begin, Circle end}) : super(begin: begin, end: end);

  @override
  Circle lerp(double t) {
    return Circle(
        color: Color.lerp(begin.color, end.color, t),
        radius: (begin.radius + (end.radius - begin.radius) * t),
        center: Offset.lerp(begin.center, end.center, t));
  }
}
