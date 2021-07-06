import 'dart:math';

import 'package:flutter/material.dart';

class SkewShadowText extends StatelessWidget{

  final TextStyle commonStyle =  TextStyle(fontSize: 60, color: Colors.blue);
  final TextStyle shadowStyle = TextStyle(fontSize: 60, color: Colors.blue.withAlpha(88));
  final String text = '张风捷特烈';
  @override
  Widget build(BuildContext context) {
    Matrix4 matrix4 = Matrix4.skewX(4*pi/180);
    return Stack(
      children: [
        Text(
          text,
          style: commonStyle,
        ),
        Transform(
          transform: matrix4,
          child: Text(
            text,
            style: shadowStyle,
          ),
        ),
      ],
    );
  }
}
