import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations(// 使设备横屏显示
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: Center(
          child: AnimDemo(),
        )));
  }
}

class AnimDemo extends StatefulWidget {
  @override
  _AnimDemoState createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  final Alignment startAlignment = Alignment.center;
  final Alignment endAlignment = Alignment.bottomRight;

  Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _alignment = startAlignment;
  }

  bool get selected => _alignment == endAlignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          value: selected,
          onChanged: onChanged,
        ),
        Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            color: Colors.grey.withAlpha(22),
            child: buildAnim())
      ],
    );
  }

  Widget buildAnim() => AnimatedAlign(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        alignment: _alignment,
        onEnd: onEnd,
        child: const Icon(
          Icons.accessible_forward_sharp,
          color: Colors.green,
          size: 25,
        ),
      );


  void onChanged(bool value) {
    setState(() {
      _alignment = value ? endAlignment : startAlignment;
    });
  }

  void onEnd() {
    print('End');
  }
}
