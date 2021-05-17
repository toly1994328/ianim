import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

extension NumPlus on num {
  double get rad => this / 180 * math.pi;

  double get sin => math.sin(this);

  double get cos => math.cos(this);
}

