import 'package:flutter/cupertino.dart';

import 'ext.dart';

class Polar {
  final double rad;
  final double len;

  Offset _offset;

  Offset get offset{
    if(_offset==null){
      double x = len * rad.sin;
      double y = len * rad.cos;
      _offset = Offset(x, y);
    }
    return _offset;
  }

   Polar(this.rad, this.len );

  static  Polar zero = Polar(0,0);

}
