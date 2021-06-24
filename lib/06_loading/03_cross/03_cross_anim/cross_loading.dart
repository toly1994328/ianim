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
      duration: const Duration(seconds: 2),
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
      onTap: () => _ctrl.repeat(reverse: true),
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: CrossLoadingPainter(_ctrl),
      ),
    );
  }
}

class CrossLoadingPainter extends CustomPainter {
  final Animation<double> animation;

  CrossLoadingPainter(this.animation, {this.itemWidth = 33})
      : super(repaint: animation);

  final List<Color> colors = const [
    Color(0xffF44336),
    Color(0xff5C6BC0),
    Color(0xffFFB74D),
    Color(0xff8BC34A),
  ];

  final double itemWidth;
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    final double begin = -size.height / 2 + itemWidth / sqrt(2);
    final double end = size.height / 2 - itemWidth / sqrt(2) + 20.0;

    drawItem(canvas, begin, end, colors[0], true);
    drawItem(canvas, -begin, -end, colors[1], true);
    drawItem(canvas, -begin, -end, colors[2], false);
    drawItem(canvas, begin, end, colors[3], false);
  }

  void drawItem(Canvas canvas, double begin, double end, Color color,
      bool vertical,
      {Curve curve = Curves.easeIn}) {
    Animatable<double> tween = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: begin, end: end),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: end, end: begin),
          weight: 1,
        ),
      ],
    ).chain(CurveTween(curve: curve));
    drawDiamond(canvas, tween.evaluate(animation), color, vertical,);
  }

  void drawDiamond(Canvas canvas, double offset, Color color, bool vertical,) {
    canvas.save();
    if (vertical) {
      canvas.translate(0, offset);
    } else {
      canvas.translate(offset, 0);
    }
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: itemWidth, height: itemWidth),
        _paint..color = color);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CrossLoadingPainter oldDelegate) =>
      oldDelegate.itemWidth != itemWidth;
}
