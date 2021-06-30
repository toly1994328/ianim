import 'package:flutter/material.dart';

class CircleAnim extends StatefulWidget {
  @override
  _CircleAnimState createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
      print("------${_ctrl.value}----${DateTime.now().toIso8601String()}----------");
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _startAnim,
        child:Container(
          width: 60,
          height: 60,
          color: Colors.green,
        ));
  }

  Color get color => Color.lerp(Colors.blue, Colors.red, _ctrl.value);

  Widget _buildByAnim(_, __) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}
