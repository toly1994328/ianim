import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'particle.dart';

/// create by 张风捷特烈 on 2021/2/7
/// contact me by email 1981462002@qq.com
/// 说明:

class ClockWidget extends StatefulWidget {
  final double radius;

  const ClockWidget({Key key, this.radius = 100}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  Ticker _ticker;
  ValueNotifier<DateTime> time = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);

  }

  @override
  void dispose() {
    _ticker.dispose();
    time.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    // _fx.tick(duration);
    if (time.value.second != DateTime.now().second) {
      time.value = DateTime.now();
      // _fx.setTime(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // debugDumpRenderTree();
        _ticker.start();
      },
      child: CustomPaint(
            size: Size(widget.radius * 2, widget.radius * 2),
            painter: ClockFxPainter(),
            // child: Container(),
          ),
    );
  }
}

class ClockFxPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
            Offset.zero & size, Paint()..color = Colors.grey.withAlpha(11));


    List<Particle> particles = [
      Particle(size: 10,color: Colors.indigo),
      Particle(size: 8,color: Colors.amber,x:size.width ),
      Particle(size: 16,color: Colors.blueGrey, x:size.width/2,y: size.height/2),
      Particle(size: 12,color: Colors.green,y:size.height),
      Particle(size: 12,color: Colors.green,y:33,x: 44),
      Particle(size: 12,color: Colors.blue ,y:size.height/2),
      Particle(size: 15,color: Colors.red ,y:size.height/2,x: 156),
    ];

    particles.forEach((Particle p) {
      Paint circlePaint = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = p.size / 4
        ..color = p.color;
      canvas.drawCircle(Offset(p.x, p.y), p.size, circlePaint);
    });

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
