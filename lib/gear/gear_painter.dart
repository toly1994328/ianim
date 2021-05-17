import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ianim/paint_helper/paint_helper.dart';
import 'package:ianim/paint_helper/polar.dart';

import '../paint_helper/ext.dart';

class GearPainter extends CustomPainter {
  final PainterHelper painterHelper = PainterHelper();

  double radius = 100;

 final ValueListenable<double> listenable ;


  GearPainter({this.listenable}):super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.stroke..color=Colors.black;

    Polar o = Polar(0, 0);
    Polar a = Polar(120.rad + 90.rad, 100);
    Polar b = Polar((360*listenable.value).rad + 90.rad, 100);

    canvas.translate(size.width / 2, size.height / 2);
    painterHelper.paint(canvas, size);

    canvas.drawCircle(Offset.zero, radius, paint);

    painterHelper.paintPolar(canvas, o);
    painterHelper.paintPolar(canvas, a);
    painterHelper.paintPolar(canvas, b);

    painterHelper.paintPolarLine(canvas, o, a);
    painterHelper.paintPolarLine(canvas, o, b);

    painterHelper.paintText(canvas, "A", a.offset.translate(-10, -5));
    painterHelper.paintText(canvas, "B", b.offset.translate(10, 0));

    canvas.save();
    canvas.translate(b.offset.dx, b.offset.dy);
    canvas.rotate(90.rad-b.rad);
    canvas.translate(-b.offset.dx, -b.offset.dy);

    paint..color=Colors.orange;
    canvas.drawLine(b.offset.translate(0, 1000), b.offset.translate(0, -1000), paint);
    canvas.drawCircle(b.offset.translate(0, -100), 3, paint);

    canvas.restore();


    painterHelper.paintText(canvas, "基圆", Offset(50, 50));

    print(size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
