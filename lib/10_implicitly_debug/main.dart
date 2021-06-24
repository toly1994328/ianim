import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations( // 使设备横屏显示
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
  final EdgeInsets beginOpacity = const EdgeInsets.all(10);
  final EdgeInsets endPadding = const EdgeInsets.all(30);


  EdgeInsets _padding;

  @override
  void initState() {
    super.initState();
    _padding = beginOpacity;
  }

  bool get selected => _padding == endPadding;

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
          color: Colors.grey.withAlpha(22),
          alignment: Alignment.topLeft,
          width: 100,
          height: 100,
          child: buildAnimatedOpacity(),
        ),
      ],
    );
  }

  Widget buildAnimatedOpacity() =>
      AnimatedPadding(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        padding: _padding,
        onEnd: onEnd,
        child: _buildChild(),
      );

  void onChanged(bool value) {
    setState(() {
      _padding = value ? endPadding : beginOpacity;
    });
  }

  void onEnd() {
    print('End');
  }

  Widget _buildChild() =>
      const Icon(
        Icons.camera_outlined,
        color: Colors.green,
        size: 60,
      );
}
