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
  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          value: isFirst,
          onChanged: _onChanged,
        ),
         AnimatedCrossFade(
            firstCurve: Curves.easeInCirc,
            secondCurve: Curves.easeInToLinear,
            sizeCurve: Curves.bounceOut,
            firstChild: buildFirstChild(),
            secondChild: buildSecondChild(),
            duration: Duration(milliseconds: 1000),
            crossFadeState: _crossFadeState,
        ),
      ],
    );
  }

  Widget buildFirstChild() => Container(
        height: 60,
        width: 60,
        color: Colors.grey.withAlpha(22),
        alignment: Alignment.center,
        child: const FlutterLogo(
          size: 40,
        ),
      );

  Widget buildSecondChild() => Image.asset(
        "assets/images/icon_head.jpg",
        height: 100,
        width: 100,
      );

  void _onChanged(bool value) {
    setState(() {
      _crossFadeState =
          value ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }
}
