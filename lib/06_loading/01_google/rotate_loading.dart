import 'dart:math';

import 'package:flutter/material.dart';

class RotateLoading extends StatefulWidget {
  final double size;

  const RotateLoading({Key key, this.size = 100}) : super(key: key);

  @override
  _RotateLoadingState createState() => _RotateLoadingState();
}

class _RotateLoadingState extends State<RotateLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
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
      onTap: () {
        _ctrl.repeat(reverse: false);
      },
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: CrossLoadingPainter(_ctrl),
      ),
    );
  }
}

class CrossLoadingPainter extends CustomPainter {
  Animation<double> animation;

  CrossLoadingPainter(this.animation) : super(repaint: animation);

  final List<Color> colors = [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A)
  ];

  double _width = 33;

  double get width => _width;

  final Animatable<double> rotateTween =
  Tween<double>(begin: 0, end: 2 * pi)
      .chain(CurveTween(curve: Curves.easeIn));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint();

    canvas.save();
    canvas.rotate(animation.value * 2 * pi);

    canvas.save();
    Rect a = Rect.fromPoints(Offset(-4, -4), Offset(-_width, -_width));
    Offset centerRed = Offset(-(_width / 2 + 4), -(_width / 2 + 4));
    canvas.translate(centerRed.dx, centerRed.dy);
    canvas.rotate(rotateTween.evaluate(animation));
    canvas.translate(-centerRed.dx, -centerRed.dy);
    canvas.drawRRect(RRect.fromRectAndRadius(a, Radius.circular(5)),
        paint..color = colors[0]);
    canvas.restore();

    canvas.save();
    Rect b = Rect.fromPoints(Offset(4, 4), Offset(_width, _width));
    Offset centerB = Offset(_width / 2 + 4, _width / 2 + 4);
    canvas.translate(centerB.dx, centerB.dy);
    canvas.rotate(rotateTween.evaluate(animation));
    canvas.translate(-centerB.dx, -centerB.dy);
    canvas.drawRRect(RRect.fromRectAndRadius(b, Radius.circular(5)),
        paint..color = colors[1]);
    canvas.restore();

    canvas.save();
    Rect c = Rect.fromPoints(Offset(4, -4), Offset(_width, -_width));
    Offset centerC = Offset(_width / 2 + 4, -(_width / 2 + 4));
    canvas.translate(centerC.dx, centerC.dy);
    canvas.rotate(rotateTween.evaluate(animation));
    canvas.translate(-centerC.dx, -centerC.dy);
    canvas.drawRRect(RRect.fromRectAndRadius(c, Radius.circular(5)),
        paint..color = colors[2]);
    canvas.restore();

    canvas.save();
    Rect d = Rect.fromPoints(Offset(-4, 4), Offset(-_width, _width));
    Offset centerD = Offset(-(_width / 2 + 4), _width / 2 + 4);
    canvas.translate(centerD.dx, centerD.dy);
    canvas.rotate(rotateTween.evaluate(animation));
    canvas.translate(-centerD.dx, -centerD.dy);
    canvas.drawRRect(RRect.fromRectAndRadius(d, Radius.circular(5)),
        paint..color = colors[3]);
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
