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

  //.loader-ring-track {
  //   position: absolute;
  //   top: 0;
  //   left: 0;
  //   width: 240px;
  //   height: 240px;
  //   -moz-border-radius: 240px;
  //   -webkit-border-radius: 240px;
  //   border-radius: 240px;
  //   -moz-box-shadow: 0 0 10px 4px rgba(0, 0, 0, 0.3) inset;
  //   -webkit-box-shadow: 0 0 10px 4px rgba(0, 0, 0, 0.3) inset;
  //   box-shadow: 0 0 10px 4px rgba(0, 0, 0, 0.3) inset;
  // }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _ctrl.repeat(reverse: false);
      },
      child:
          // Container(
          //   width: 240,
          //   height: 240,
          //   decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          //     BoxShadow(
          //         blurRadius: 10,
          //         spreadRadius: 4,
          //         color: Colors.black.withOpacity(0.3))
          //   ]),
          // )

          CustomPaint(
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

  final Animatable<double> rotateTween = Tween<double>(begin: 0, end: 2 * pi)
      .chain(CurveTween(curve: Curves.easeIn));

  final Animatable<double> breatheTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0,end: 4),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 4,end: 0),
        weight: 1,
      ),
    ],
  ).chain(CurveTween(curve: Curves.decelerate));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
    ..style=PaintingStyle.stroke
      ..color = Colors.purple;

    Path path1 = Path();
    path1.addOval(
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));
    Path path2 = Path();

    path2.addOval(
        Rect.fromCenter(center: Offset(-1, 0), width: 100, height: 100));
    Path result = Path.combine(PathOperation.difference, path1, path2);


    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));

    canvas.drawPath(path1, paint);

    canvas.save();
    canvas.rotate(animation.value * 2 * pi);
    paint..style = PaintingStyle.fill..color = Color(0xff00abf2);
    canvas.drawPath(result, paint);
    canvas.restore();

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
