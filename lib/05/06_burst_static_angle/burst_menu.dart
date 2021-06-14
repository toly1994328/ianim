import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明:

class BurstMenu extends StatefulWidget {
  final List<Widget> menus;
  final Widget center;

  BurstMenu({Key key, @required this.menus, @required this.center})
      : super(key: key);

  @override
  BurstMenuState createState() => BurstMenuState();
}

class BurstMenuState extends State<BurstMenu> {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(),
      children: [...widget.menus, widget.center],
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  // 菜单圆弧的扫描角度
  final double swapAngle;

  // 菜单圆弧的起始角度
  final double startAngle;

  _CircleFlowDelegate({
    this.swapAngle = 120,
    this.startAngle = -60,
  });

  //绘制孩子的方法
  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    final int count = context.childCount - 1;

    final double perRad = swapAngle / 180 * pi / (count - 1);
    double rotate = startAngle / 180 * pi;

    for (int i = 0; i < count; i++) {
      final double cSizeX = context.getChildSize(i).width / 2;
      final double cSizeY = context.getChildSize(i).height / 2;

      final double offsetX =
          (radius - cSizeX) * cos(i * perRad + rotate) + radius;
      final double offsetY =
          (radius - cSizeY) * sin(i * perRad + rotate) + radius;

      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          offsetX - cSizeX,
          offsetY - cSizeY,
          0.0,
        ),
      );
    }

    context.paintChild(
      context.childCount - 1,
      transform: Matrix4.translationValues(
        radius - context.getChildSize(context.childCount - 1).width / 2,
        radius - context.getChildSize(context.childCount - 1).height / 2,
        0.0,
      ),
    );
  }

  @override
  bool shouldRepaint(_CircleFlowDelegate oldDelegate) =>
      swapAngle != oldDelegate.swapAngle ||
      startAngle != oldDelegate.startAngle;
}
