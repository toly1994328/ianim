import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RawGestureDetectorDemo extends StatefulWidget {
  @override
  _RawGestureDetectorDemoState createState() => _RawGestureDetectorDemoState();
}

class _RawGestureDetectorDemoState extends State<RawGestureDetectorDemo> {
  String action = '';
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    Map<Type, GestureRecognizerFactory> gestures = {
      TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
          TapGestureRecognizer>(
            () {
          return TapGestureRecognizer();
        },
            (TapGestureRecognizer instance) {
          instance
            ..onTapDown = _tapDown
            ..onTapUp = _tapUp
            ..onTap = _tap
            ..onTapCancel = _tapCancel;
        },
      ),
      DoubleTapGestureRecognizer:
      GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
            () => DoubleTapGestureRecognizer(),
            (DoubleTapGestureRecognizer instance) => instance
          ..onDoubleTap = _doubleTap
          ..onDoubleTapDown = _doubleDown
          ..onDoubleTapCancel = _doubleTapCancel,
      ),

    };

    return RawGestureDetector(
      gestures: gestures,
      child: Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "测试",
            style: TextStyle(color: Colors.white),
          )),
    );
  }


  void _tapDown(TapDownDetails details) {
    print('_tapDown------${DateTime.now().millisecondsSinceEpoch}-----------');
  }

  void _tapUp(TapUpDetails details) {
    print('_tapUp------${DateTime.now().millisecondsSinceEpoch}-----------');
  }

  void _tap() {
    print('_tap------${DateTime.now().millisecondsSinceEpoch}-----------');
  }

  void _tapCancel() {
    print('_tapCancel------${DateTime.now().millisecondsSinceEpoch}-----------');

  }

  void _doubleTap() {
    print('_doubleTap------${DateTime.now().millisecondsSinceEpoch}-----------');
    setState(() {
      action = '_doubleTap';
      color = Colors.green;
    });
  }

  void _doubleDown(TapDownDetails details) {
    print('_doubleDown------${DateTime.now().millisecondsSinceEpoch}-----------');
    setState(() {
      action = '_doubleDown';
      color = Colors.orange;
    });
  }

  void _doubleTapCancel() {
    print('_doubleTapCancel');
    setState(() {
      action = '_doubleTapCancel';
      color = Colors.red;
    });
  }
}
