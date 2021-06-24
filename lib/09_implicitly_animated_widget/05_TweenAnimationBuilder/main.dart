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
  bool _selected = false;

  Color color1 = Colors.red;
  Color color2 = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          value: _selected,
          onChanged: onChanged,
        ),
        buildAnim()
      ],
    );
  }

  Widget buildAnim() => TweenAnimationBuilder<Color>(
        tween: ColorTween(begin: Colors.blue, end: _selected?color1:color2),
        duration: Duration(seconds: 1),
        builder: (_, Color color, Widget child) => Container(
          width: 60,
          height: 60,
          child: child,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _buildChild(),
      );

  Widget _buildChild() => const Icon(
    Icons.camera_outlined,
    size: 30,
    color: Colors.white,
  );

  void onChanged(bool value) {
    setState(() {
      _selected = !_selected;
    });
  }

  void onEnd() {
    print('End');
  }
}
