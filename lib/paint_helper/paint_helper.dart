import 'package:flutter/material.dart';
import 'package:ianim/paint_helper/dash_painter.dart';

import 'polar.dart';

class PainterHelper {
  final Paint helpPaint = Paint()..style = PaintingStyle.stroke;
  final Path helpPath = Path();

  final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  final DashPainter dashPainter =
      DashPainter(pointWidth: 2, step: 8, pointCount: 2);

  void paint(Canvas canvas, Size size, {bool center=false}) {
    helpPath.reset();

    helpPath
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);

    dashPainter.paint(canvas, helpPath, helpPaint);

    if(center){
      canvas.drawCircle(Offset.zero, 3, helpPaint);
    }
  }

  void paintRefer(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 3, helpPaint);
  }

  void paintPolar(Canvas canvas, Polar polar) {
    final Offset offset = polar.offset;
    canvas.drawCircle(offset, 3, helpPaint);
  }

  void paintPolarLine(Canvas canvas, Polar a,Polar b) {
    canvas.drawLine(a.offset, b.offset, helpPaint);
  }

  void paintText(Canvas canvas, String str, Offset offset) {
    TextSpan text = TextSpan(
        text: str, style: TextStyle(fontSize: 14, color: Colors.black));
    textPainter.text = text;
    textPainter.layout(); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(
        canvas, offset.translate(-size.width / 2, -size.height / 2));
  }


}
