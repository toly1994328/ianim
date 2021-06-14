import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明:

typedef BurstMenuItemClick = bool Function(int index);

class BurstMenu extends StatefulWidget {
  final List<Widget> children;
  final Widget menu;
  final double startAngle;
  final BurstMenuItemClick burstMenuItemClick;

  final double swapAngle;

  BurstMenu(
      {Key key,
      @required this.children,
      this.startAngle = 30 + 90.0,
      this.burstMenuItemClick,
      this.swapAngle = 120,
      @required this.menu})
      : super(key: key);

  @override
  BurstMenuState createState() => BurstMenuState();
}

class BurstMenuState extends State<BurstMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _closed = true;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {}
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(
        _controller,
        swapAngle: widget.swapAngle,
        startAngle: widget.startAngle,
      ),
      children: [
        ...widget.children.asMap().keys.map((int index) => GestureDetector(
              onTap: () => _handleItemClick(index),
              child: widget.children[index],
            )),
        GestureDetector(onTap: toggle, child: widget.menu)
      ],
    );
  }

  void toggle() {
    if (_closed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _closed = !_closed;
  }

  void _handleItemClick(int index) {
    if (widget.burstMenuItemClick == null) {
      toggle();
      return;
    }
    bool close = widget.burstMenuItemClick.call(index);
    if (close) toggle();
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  final Animation<double> repaint;

  _CircleFlowDelegate(this.repaint,
      {this.startAngle = 30 + 90.0, this.swapAngle = 120})
      : super(repaint: repaint);

  final double startAngle;

  final double swapAngle;

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    if (repaint.value > 0.3) {
      var count = context.childCount - 1;

      var perRad = 360 / 180 * pi / count;

      for (int i = 0; i < count; i++) {
        var cSizeX = context.getChildSize(i).width / 2;
        var cSizeY = context.getChildSize(i).height / 2;

        var offsetX =
            repaint.value * (radius - cSizeX) * cos(i * perRad) + radius;
        var offsetY =
            repaint.value * (radius - cSizeY) * sin(i * perRad) + radius;

        context.paintChild(
          i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0),
          // opacity: repaint.value
        );
      }
    }

    context.paintChild(context.childCount - 1,
        transform: Matrix4.translationValues(
            radius - context.getChildSize(context.childCount - 1).width / 2,
            radius - context.getChildSize(context.childCount - 1).height / 2,
            0.0));
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
