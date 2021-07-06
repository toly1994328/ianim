import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerDemo extends StatefulWidget {
  @override
  _TickerDemoState createState() => _TickerDemoState();
}

class _TickerDemoState extends State<TickerDemo> {
  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.scheduleFrameCallback(_tick);
    _ticker = Ticker(_tick)..start();
  }

  void _tick(Duration elapsed) {
    print('----elapsed:$elapsed---${DateTime.now().toIso8601String()}------------');
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _startTicker,
        child: Container(
          width: 60,
          height: 60,
          color: Colors.green,
        ));
  }

  void _startTicker() {
    if (_ticker.muted) {
      _ticker.muted = false;
    } else {
      _ticker.muted = true;
    }
  }
}
