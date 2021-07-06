import 'package:flutter/material.dart';

class TickerDemo extends StatefulWidget {
  @override
  _TickerDemoState createState() => _TickerDemoState();
}

class _TickerDemoState extends State<TickerDemo> with SingleTickerProviderStateMixin {
  AnimationController _ctrlA;

  final Duration animDuration = const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _ctrlA = AnimationController(
      value: 0.4,
      vsync: this,
      duration: animDuration,
    );


  }

  @override
  void dispose() {
    _ctrlA.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _start,
        child: Container(
          width: 60,
          height: 60,
          color: Colors.green,
        ));
  }

  void _start() {}
}
