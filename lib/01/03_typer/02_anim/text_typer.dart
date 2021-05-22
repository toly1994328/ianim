import 'dart:async';

import 'package:flutter/material.dart';

class TextTyper extends StatefulWidget {
  @override
  _TextTyperState createState() => _TextTyperState();
}

class _TextTyperState extends State<TextTyper> {

  final Duration animDuration = const Duration(milliseconds: 200);

  final String text = '桃树、杏树、梨树，你不让我，我不让你，都开满了花赶趟儿。'
      '红的像火，粉的像霞，白的像雪。花里带着甜味，闭了眼，'
      '树上仿佛已经满是桃儿、杏儿、梨儿。';

  final ValueNotifier<String> data = ValueNotifier<String>("");

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAnim();
  }

  int currentIndex = 0;

  String get currentText =>text.substring(0,currentIndex);

  void _type(Timer timer) {
    if (currentIndex < text.length) {
      currentIndex++;
      data.value= currentText;
    }else{
      _timer?.cancel();
      _timer=null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: SizedBox(
        width: 300,
        child: AnimatedBuilder(
          animation: data,
          builder: _buildByAnim,
        ),
      ),
    );
  }

  Widget _buildByAnim(_, __) => Text(
        data.value,
        style: const TextStyle(color: Colors.blue),
      );

  void _startAnim() {
    _timer?.cancel();
    data.value = '';
    currentIndex = 0;
    _timer = Timer.periodic(animDuration, _type);
  }
}
