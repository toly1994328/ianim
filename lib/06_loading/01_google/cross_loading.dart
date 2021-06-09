import 'dart:math';

import 'package:flutter/material.dart';

class CrossLoading extends StatefulWidget {
  final double size;

  const CrossLoading({Key key, this.size = 100}) : super(key: key);

  @override
  _CrossLoadingState createState() => _CrossLoadingState();
}

class _CrossLoadingState extends State<CrossLoading>
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
        _ctrl.repeat(reverse: true);
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

  double _width = 0;

  double get width => _width;

  @override
  void paint(Canvas canvas, Size size) {
    _width = 33;
    //
    // canvas.drawRect(
    //     Offset.zero & size, Paint()..color = Colors.grey.withAlpha(11));
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint();

    drawRedShape(canvas, paint, size);
    drawBlueShape(canvas, paint, size);
    drawShape2(canvas, paint, size);
    drawShape3(canvas, paint, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawRedShape(Canvas canvas, Paint paint, Size size) {
    Tween<double> redTween = Tween(
        begin: -size.height / 2 + _width / sqrt(2),
        end: size.height / 2 - _width / sqrt(2) + 20.0);

    Tween<double> redTweenBack = Tween(
        begin: size.height / 2 - _width / sqrt(2) + 20.0,
        end: -size.height / 2 + _width / sqrt(2));

    Animatable<double> tween = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: redTween,
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: redTweenBack,
          weight: 1,
        ),
      ],
    ).chain(CurveTween(curve: Curves.easeIn));
    canvas.save();
    canvas.translate(0, tween.evaluate(animation));

    canvas.save();
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: width, height: width),
        paint..color = colors[0]);
    canvas.restore();
    canvas.restore();
  }

  void drawBlueShape(Canvas canvas, Paint paint, Size size) {
    Tween<double> redTween = Tween(
        begin: size.height / 2 - _width / sqrt(2),
        end: -size.height / 2 + _width / sqrt(2) - 20.0);

    Tween<double> redTweenBack = Tween(
        begin: -size.height / 2 + _width / sqrt(2) - 20.0,
        end: size.height / 2 - _width / sqrt(2));

    Animatable<double> tween = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: redTween,
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: redTweenBack,
          weight: 1,
        ),
      ],
    ).chain(CurveTween(curve: Curves.easeIn));
    canvas.save();
    canvas.translate(0, tween.evaluate(animation));

    canvas.save();
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: width, height: width),
        paint..color = colors[1]);
    canvas.restore();
    canvas.restore();
  }

  void drawShape2(Canvas canvas, Paint paint, Size size) {
    Tween<double> redTween = Tween(
        begin: size.height / 2 - _width / sqrt(2),
        end: -size.height / 2 + _width / sqrt(2) - 20.0);
    Tween<double> redTweenBack = Tween(
        begin: -size.height / 2 + _width / sqrt(2) - 20.0,
        end: size.height / 2 - _width / sqrt(2));

    Animatable<double> tween = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: redTween,
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: redTweenBack,
          weight: 1,
        ),
      ],
    ).chain(CurveTween(curve: Curves.easeIn)); //
    canvas.save();
    canvas.translate(
      tween.evaluate(animation),
      0,
    );

    canvas.save();
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: width, height: width),
        paint..color = colors[2]);
    canvas.restore();
    canvas.restore();
  }

  void drawShape3(Canvas canvas, Paint paint, Size size) {
    Tween<double> redTween = Tween(
        begin: -size.height / 2 + _width / sqrt(2),
        end: size.height / 2 - _width / sqrt(2) + 20);

    Tween<double> redTweenBack = Tween(
        begin: size.height / 2 - _width / sqrt(2) + 20,
        end: -size.height / 2 + _width / sqrt(2));

    Animatable<double> tween = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: redTween,
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: redTweenBack,
          weight: 1,
        ),
      ],
    ).chain(CurveTween(curve: Curves.easeIn));
    canvas.save();
    canvas.translate(
      tween.evaluate(animation),
      0,
    );

    canvas.save();
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: width, height: width),
        paint..color = colors[3]);
    canvas.restore();
    canvas.restore();
  }
}
