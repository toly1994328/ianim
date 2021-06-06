import 'dart:math';

import 'package:flutter/material.dart';

class X2Curve extends Curve{

  const X2Curve();


  @override
  double transformInternal(double t) {
    return t*t;
  }

}

class DampingCurve extends Curve {
  const DampingCurve();

  @override
  double transformInternal(double t) {
    t = t - 1.0;
    return t * t * t * t * t + 1.0;
  }
}
